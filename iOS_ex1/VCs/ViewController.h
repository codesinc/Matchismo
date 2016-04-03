// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.
//
// Abstaract class


#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatcher.h"
#import "CardMatchingGame.h"
#import "CardView.h"
#import "Grid.h"

@interface ViewController : UIViewController

/// Protected method for subclasses.
- (Deck *)createDeck;
- (NSArray *)getVisibleCards;
- (void)createUIDeck:(BOOL)animate;
- (void)placeUIDeck;
- (id <CardDealer>)createDealer;
- (id <CardMatcher>)createMatcher;
- (NSUInteger)gameMode;
- (CardView *)createCardView:(id <Card>)card withFrame:(CGRect)frame;
- (NSUInteger)startCardGameCount;


@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) CardMatchingGame *game;
@property (readonly, nonatomic) Grid * gridCardOrder;
@property (nonatomic) BOOL duringAnimation;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end
