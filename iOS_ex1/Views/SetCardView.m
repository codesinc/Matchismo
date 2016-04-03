// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "SetCardView.h"

#define kMARGIN_SIZE 0.1
#define kPADDING_SIZE 0.1
#define kSTRIPE_SIZE 0.05
#define kCHOSEN_STROKE_SIZE 0.05

@interface SetCardView()
@property (strong, nonatomic) UIBezierPath *path;
@end


@implementation SetCardView : CardView

#pragma mark - Properties

- (void)setChoosen:(BOOL)choosen {
  _choosen = choosen;
  [self setNeedsDisplay]; // Re-draw
  
}
- (UIBezierPath *)path
{
  if(!_path){
    _path = [[UIBezierPath alloc] init];
  }
  return _path;
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  self.path = nil;
  
  if (self.choosen) {
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:rect];
    [[self colorShape] setStroke];
    borderPath.lineWidth = self.bounds.size.width * kCHOSEN_STROKE_SIZE;
    [borderPath stroke];
  }
  
  CGRect marginCardPlace;
  // So the shapes of cards will not stick to each other, we use percentage so it will work to any size of a card.
  // This area will contain the shapes in one card.
  marginCardPlace.size.height = self.bounds.size.height - 2 * kMARGIN_SIZE * self.bounds.size.height;
  marginCardPlace.size.width = self.bounds.size.width - 2 * kMARGIN_SIZE * self.bounds.size.width;
  // Adjust origin
  marginCardPlace.origin.x = self.bounds.origin.x + self.bounds.size.width * kMARGIN_SIZE;
  marginCardPlace.origin.y = self.bounds.origin.y + self.bounds.size.height * kMARGIN_SIZE;
  
  // One shape size (A card has number of shapes in it)
  CGSize shapeSizeNoPadding = marginCardPlace.size;
  shapeSizeNoPadding.height /= [SetCard maxNumberOfSymbols];
  
  // So the shapes in a card will not stick to each other, we use percentage so it will work to any size of a card.
  // This area will contain one shape of a card.
  CGSize shapeSizePadding;
  shapeSizePadding.height = shapeSizeNoPadding.height - 2 * kPADDING_SIZE * shapeSizeNoPadding.height;
  shapeSizePadding.width = shapeSizeNoPadding.width - 2 * kPADDING_SIZE * shapeSizeNoPadding.width;
  
  CGRect shapePlace;
  shapePlace.size = shapeSizePadding;
  // Adjust origin
  shapePlace.origin.y = marginCardPlace.origin.y + kPADDING_SIZE*shapeSizeNoPadding.height;
  shapePlace.origin.x = marginCardPlace.origin.x + kPADDING_SIZE*shapeSizeNoPadding.width;
  
  // Adjust all shapes of one card drawing to be centered
  SetCard * setCard = (SetCard *)self.card;
  shapePlace.origin.y += marginCardPlace.size.height/2 - setCard.numberOfSymbols*shapeSizeNoPadding.height/2;
  // Draw shapes
  for (int i = 0 ; i < setCard.numberOfSymbols; i++) {
    [self drawShape:shapePlace];
    shapePlace.origin.y += shapeSizeNoPadding.height;
    
  }
  [self shadeShapes];
  
}

- (void)drawShape:(CGRect)bounds {
  SetCard * setCard = self.card;
  if (setCard.shape == Diamond) {
    [self drawDiamond:bounds];
  }
  else if (setCard.shape == Oval) {
    [self drawOval:bounds];
  }
  else { // Squiggle
    [self drawSquiggle:bounds];
  }
}

- (void)drawDiamond:(CGRect)bounds {
  [self.path moveToPoint:CGPointMake(bounds.origin.x + bounds.size.width/2,bounds.origin.y)];
  [self.path addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height/2)];
  [self.path addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width/2, bounds.origin.y + bounds.size.height)];
  [self.path addLineToPoint:CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height/2)];
  [self.path closePath];
}

- (void)drawOval:(CGRect)bounds{
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)
                                                  cornerRadius:0.5*bounds.size.width];
  [self.path appendPath:path];
}

- (void)drawSquiggle:(CGRect)bounds {
  
  [self.path moveToPoint:CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.15)];
  [self.path addCurveToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height * 0.15)
               controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width / 2, bounds.origin.y - bounds.size.height * 0.5)
               controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width / 2, bounds.origin.y + bounds.size.height * 1)];
  [self.path addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height * 0.85)];
  [self.path addCurveToPoint:CGPointMake(bounds.origin.x, bounds.origin.y + bounds.size.height * 0.85)
               controlPoint1:CGPointMake(bounds.origin.x + bounds.size.width / 2, bounds.origin.y + bounds.size.height * 1.5)
               controlPoint2:CGPointMake(bounds.origin.x + bounds.size.width / 2, bounds.origin.y + bounds.size.height * 0)];
  [self.path closePath];
  
}

#pragma mark - Shape attributes

- (UIColor *)colorShape {
  SetCard * setCard = (SetCard *)self.card;
  UIColor *color = [UIColor blackColor];
  
  color = setCard.color == Red ? [UIColor redColor] : color;
  color = setCard.color == Green ? [UIColor greenColor]: color;
  color = setCard.color == Purple ? [UIColor purpleColor] : color;
  return color;
}

- (void)shadeShapes{
  UIColor * color = [self colorShape];
  [color setStroke];
  [self.path stroke];
  
  SetCard * setCard = self.card;
  if (setCard.shading == Solid) {
    [color setFill];
    [self.path fill];
  }
  
  else if (setCard.shading == Striped) {
    [self.path addClip]; // Limits lines to cards' shapes
    UIBezierPath * stripPath = [[UIBezierPath alloc] init];
    CGFloat x = self.bounds.origin.x;
    int y = self.bounds.origin.y + self.bounds.size.height;
    
    while (x < self.bounds.origin.x + self.bounds.size.width) {
      [stripPath moveToPoint:CGPointMake(x, self.bounds.origin.y)];
      [stripPath addLineToPoint:CGPointMake(x, y)];
      x += self.bounds.size.width * kSTRIPE_SIZE;
    }
    
    [stripPath stroke];
  }
  else { // Open
    [[UIColor clearColor] setFill];
    [self.path fill];
  }
  
}

@end