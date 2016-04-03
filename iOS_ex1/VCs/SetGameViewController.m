// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "SetGameViewController.h"
#import "SetCardsMatcher.h"
#import "SetCardDeck.h"
#import "SetCardDealer.h"
#import "SetCardView.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *moreCards;
@end

@implementation SetGameViewController

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (id <CardMatcher>)createMatcher {
  return [[SetCardsMatcher alloc] init];
}

- (id <CardDealer>)createDealer {
  return [[SetCardDealer alloc] init];
}

- (NSUInteger)gameMode {
  return 3;
}

- (NSArray *)getVisibleCards {
  NSMutableArray * cards = [[NSMutableArray alloc] init];
  for (int i = 0; i < self.game.cardCount; i++) {
    if (![self.game isCardMatched:i]) {
      [cards addObject:[self.game cardAtIndex:i]];
    }
  }
  
  return cards;
}


- (CardView *)createCardView:(id <Card>)card withFrame:(CGRect)frame {
  if (![card isKindOfClass:[SetCard class]]) {
    NSLog(@"Error: not a SetCard type");
    return nil;
  }
  
  SetCard *setCard = (SetCard *)card;
  NSUInteger cardIndex = [self.game findCard:setCard];
  if ([self.game isCardMatched:cardIndex]) {
    return nil;
  }
  
  SetCardView * cardView = [[SetCardView alloc] initWithFrame:frame];
  cardView.card = setCard;
  cardView.choosen = [self.game isCardChosen:cardIndex];
  
  return cardView;
}

- (NSUInteger)startCardGameCount {
  return 12;
}

- (IBAction)moreTouchButton:(UIButton *)sender {
  [self.game addCards];
  [self createUIDeck:YES];
}

- (void)updateUI {
  for (SetCardView *cardView in [self.gameView subviews]) {
    SetCard * card = cardView.card;
    NSUInteger cardIndex = [self.game findCard:card];
    
    BOOL chosen = [self.game isCardChosen:cardIndex];
    BOOL matched = [self.game isCardMatched:cardIndex];
    
    if (cardView.choosen != chosen) {
      cardView.choosen= chosen;
    }
    if (matched) {
      [UIView animateWithDuration:0.5
                            delay:0
                          options:UIViewAnimationOptionBeginFromCurrentState
                       animations:^{
                         cardView.alpha = 0.0;
                         cardView.frame = self.view.bounds;
                         self.duringAnimation = YES;
                       }
                       completion:^(BOOL fin){ if (fin) {
        [cardView removeFromSuperview];
        self.duringAnimation = false;
        [self placeUIDeck:NO];
      } }];
      //[cardView removeFromSuperview];
    }
  }
  
  //[self placeUIDeck];
  
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.gameScore];
  int moreCount = [self.game moreCardsCount];
  self.moreCards.hidden = !moreCount;
  
}

@end
