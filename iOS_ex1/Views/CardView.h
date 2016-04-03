// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import <UIKit/UIKit.h>
#import "Card.h"
@interface CardView: UIView
@property (strong, nonatomic) id <Card> card;

- (CGFloat)cornerScaleFactor;// { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius; //{ return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset; //{ return [self cornerRadius] / 3.0; }


@end
