// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardsMatcher.h"
#import "PlayingCardDealer.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()
@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

- (id <CardMatcher>)createMatcher {
  return [[PlayingCardsMatcher alloc] init];
}

- (id <CardDealer>)createDealer {
  return [[PlayingCardDealer alloc] init];
}

- (NSArray *)getVisibleCards {
  NSMutableArray * cards = [[NSMutableArray alloc] init];
  for (int i = 0; i < self.game.cardCount; i++) {
    [cards addObject:[self.game cardAtIndex:i]];
  }
  
  return cards;
}

- (NSUInteger)gameMode {
  return 2;
}

- (CardView *)createCardView:(id <Card>)card withFrame:(CGRect)frame {
  if (![card isKindOfClass:[PlayingCard class]]) {
    NSLog(@"Error: not a PlayinCard type");
    return nil;
  }
  PlayingCard *playingCard = (PlayingCard *)card;
  PlayingCardView * cardView = [[PlayingCardView alloc] initWithFrame:frame];
  cardView.card = playingCard;
  
  NSUInteger cardIndex = [self.game findCard:playingCard];
  cardView.faceUp = [self.game isCardChosen:cardIndex];
  cardView.alpha = [self.game isCardMatched:cardIndex] ? 0.5 : 1;
  return cardView;
}

- (NSUInteger)startCardGameCount {
  return 20;
}

- (void)updateUI {
  for (PlayingCardView *cardView in self.gameView.subviews) {
    PlayingCard * card = cardView.card;
    NSUInteger cardIndex = [self.game findCard:card];
        
    BOOL chosen = [self.game isCardChosen:cardIndex];
    BOOL matched = [self.game isCardMatched:cardIndex];
    if (cardView.faceUp != chosen) {
      cardView.faceUp = chosen;
    }
    if (matched) {
//      cardView.tintColor = [UIColor redColor];
//      cardView.backgroundColor = [UIColor grayColor];
      cardView.alpha = 0.5;
    }
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.gameScore];
}

@end
