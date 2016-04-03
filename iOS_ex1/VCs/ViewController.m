// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "ViewController.h"
#import "CardView.h"

@interface ViewController ()
@property (readwrite, nonatomic) Grid * gridCardOrder;
@property (nonatomic) BOOL extractPile;

@end

@implementation ViewController

static const CGSize kCARD_SIZE = {45, 60};

- (void)createGame {
  self.game = [[CardMatchingGame alloc] initWithCardCount:[self startCardGameCount]
                                                usingDeck:[self createDeck]
                                             usingMatcher:[self createMatcher]
                                              usingDealer:[self createDealer]
                                            usingGameMode: [self gameMode]];
}

- (Deck *)createDeck {
  return nil;
}

- (id <CardMatcher>)createMatcher {
  return nil;
}

- (NSUInteger)gameMode {
  return 0;
}

- (NSUInteger)startCardGameCount {
  return 0;
}

- (void)updateUI {
  return;
}

- (Grid *)createGrid {
  return nil;
}

- (NSArray *)getVisibleCards {
  return nil;
}

- (Grid *)gridCardOrder {
  if (!_gridCardOrder) {
    _gridCardOrder  = [[Grid alloc] init];
    _gridCardOrder.cellAspectRatio = kCARD_SIZE.width/kCARD_SIZE.height;
    _gridCardOrder.size = self.gameView.bounds.size;
    _gridCardOrder.minimumNumberOfCells = [[self getVisibleCards] count];
  }
  return _gridCardOrder;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  // geometry set
  if (!self.duringAnimation) {
    [self placeUIDeck:NO];
  }
  
  self.gridCardOrder = nil;
  
  
  //  });
  
}

-(id <CardDealer>)createDealer {
  return nil;
}

- (CardView *)createCardView:(id <Card>)card withFrame:(CGRect)frame {
  return nil;
}

//The event handling method
- (void)touchCard:(UITapGestureRecognizer *)recognizer {
  if (![recognizer.view isKindOfClass:[CardView class]]) {
    return;
  }
  
  if (self.extractPile) {
    [self createUIDeck:YES];
    self.extractPile = NO;
    return;
  }
  
  CardView * cardView = (CardView *)recognizer.view;
  [self.game chooseCard:cardView.card];
  [self updateUI];
}

- (void)createUIDeck:(BOOL)animate {
  [[self.gameView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  self.gridCardOrder = nil;
  NSArray * visibleCards = [self getVisibleCards];
  
  for (id <Card> card in visibleCards) {
    
    NSUInteger cardIndex = [visibleCards indexOfObject:card];
    
    NSUInteger col = cardIndex % self.gridCardOrder.columnCount;
    NSUInteger row = cardIndex / self.gridCardOrder.columnCount;
    
    CGRect frame = [self.gridCardOrder frameOfCellAtRow:row inColumn:col];
    CardView *cardView = [self createCardView:card withFrame:frame];
    
    if (!cardView) {
      continue;
    }
    
    [self.gameView addSubview:cardView];
    
    UITapGestureRecognizer *tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(touchCard:)];
    
    [cardView addGestureRecognizer:tapRecognizer];
    
    
    if (animate) {
      cardView.alpha = 0.0;
      cardView.frame = CGRectMake(0, 0, 0, 0);
      [UIView animateWithDuration:0.2
                            delay:0.2 * cardIndex
                          options:UIViewAnimationOptionBeginFromCurrentState
                       animations:^{ cardView.alpha = 1.0; cardView.frame = frame; }
                       completion:^(BOOL fin) { }];
    }
  }
  [self updateUI];
}

- (void)placeUIDeck:(BOOL)extractPile {
  NSArray * visibleCards = [self getVisibleCards];
  
  for (CardView * cardView in self.gameView.subviews) {
    if (extractPile) {
      cardView.alpha = 1;
    }
    
    id <Card> card = cardView.card;
    NSUInteger cardIndex = [visibleCards indexOfObject:card];
    
    NSUInteger col = cardIndex % self.gridCardOrder.columnCount;
    NSUInteger row = cardIndex / self.gridCardOrder.columnCount;
    
    cardView.frame = [self.gridCardOrder frameOfCellAtRow:row inColumn:col];
  }
}


- (IBAction)touchRedealButton:(id)sender {
  [self createGame]; // Starting a new game
  [self createUIDeck:YES];
}

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  //  [self createUIDeck:NO];
  [self placeUIDeck:NO];
}


//The event handling method
- (void)extractPile:(UITapGestureRecognizer *)recognizer {
  [self placeUIDeck:YES];
}
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
  CardView *head = self.gameView.subviews[0];
  
//  UITapGestureRecognizer *extractRecognizer =
//  [[UITapGestureRecognizer alloc] initWithTarget:self
//                                            action:@selector(extractPile:)];
//  [self.view addGestureRecognizer:extractRecognizer];
  
  for (CardView *cardView in [self.gameView subviews]) {
    id <Card> card = cardView.card;
    NSUInteger cardIndex = [self.game findCard:card];
    
    
    [UIView animateWithDuration:1.0
                          delay:0.1*cardIndex
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                       if (cardView != head) {
                         cardView.center = self.gameView.bounds.origin;
                         cardView.alpha = 0;
                       }
                       
                       self.duringAnimation = YES;
                     }
                     completion:^(BOOL fin){ if (fin) {
      self.duringAnimation = false;
      self.extractPile = YES;
//      [head removeGestureRecognizer:extractRecognizer];
    } }];
    
  }
  
}

-(void)viewDidLoad {
  [super viewDidLoad];
  [self createGame];
  [self createUIDeck:YES];
  
  
  UIPinchGestureRecognizer *pinchRecognizer =
  [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(pinch:)];
  [self.gameView addGestureRecognizer:pinchRecognizer];
  
  
}


@end
