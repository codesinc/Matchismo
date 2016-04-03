// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray * cards;
//@property (nonatomic) NSUInteger i;
@end

@implementation Deck

#pragma mark - Properties

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  
  return _cards;
}

#pragma mark - Public methods

- (void)addCard:(id <Card>)card atTop:(BOOL)atTop {
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }
  else {
    [self.cards addObject:card];
  }
}

- (void)addCard:(id <Card>)card {
  [self addCard:card atTop:NO];
}

- (id <Card>)darwRandomCard {
  id <Card> randomCard = nil;
  
  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
//  randomCard = self.cards[self.i];
//  [self.cards removeObjectAtIndex:self.i];
//  self.i = self.i + 1;

  return randomCard;
}

@end
