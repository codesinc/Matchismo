// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "ViewController.h"
#import "CardView.h"

@interface ViewController ()
@property (readwrite, nonatomic) Grid * gridCardOrder;

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
    [self placeUIDeck];
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
  
  CardView * cardView = (CardView *)recognizer.view;
  [self.game chooseCard:cardView.card];
  [self updateUI];
}

- (void)createUIDeck:(BOOL)animate {
  [[self.gameView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
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

- (void)placeUIDeck {
  NSArray * visibleCards = [self getVisibleCards];
  
  for (CardView * cardView in self.gameView.subviews) {
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
  [self placeUIDeck];
}
-(void)viewDidLoad {
  [super viewDidLoad];
  [self createGame];
  [self createUIDeck:YES];
}


@end
