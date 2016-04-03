// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "CardMatchingGame.h"
#import "CardState.h"

@interface CardMatchingGame()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableArray *cardsState;

@property (strong, nonatomic) id <CardMatcher> gameMatcher;
@property (strong, nonatomic) id <CardDealer> cardDealer;

@property (readwrite, nonatomic) NSInteger gameScore;
@end

@implementation CardMatchingGame

#pragma mark - Properties

- (NSMutableArray *)cards {
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  return _cards;
}

- (NSMutableArray *)cardsState {
  if (!_cardsState) {
    _cardsState = [[NSMutableArray alloc] init];
  }
  return _cardsState;
}

- (void)setCardMode:(NSUInteger)cardMode {
  if (cardMode < 2) {
    cardMode = 2;
  }
  
  _gameCardMode = cardMode;
}



#pragma mark - Private functions

- (NSMutableArray *)chosenCards {
  NSMutableArray * chosen = [[NSMutableArray alloc] init];
  for (int i =0; i < [self.cardsState count]; i++) {
    CardState * card = (CardState *)self.cardsState[i];
    if (card.chosen && !card.matched) {
      [chosen addObject:self.cards[i]];
    }
  }
  return chosen;
}

- (NSMutableArray *)nonMatchedCards {
  NSMutableArray * nonMatchedCards = [[NSMutableArray alloc] init];
  for (int i =0; i < [self.cardsState count]; i++) {
    CardState * card = (CardState *)self.cardsState[i];
    if (!card.matched) {
      [nonMatchedCards addObject:self.cards[i]];
    }
    
  }
  return nonMatchedCards;
}


- (void)emptyChosenCards {
  for (int i =0; i < [self.cardsState count]; i++) {
    CardState * card = (CardState *)self.cardsState[i];
    if (card.chosen && !card.matched) {
      card.chosen = NO;
    }
  }
}

- (void)matchChosenCards {
  for (int i =0; i < [self.cardsState count]; i++) {
    CardState * card = (CardState *)self.cardsState[i];
    if (card.chosen && !card.matched) {
      card.matched = YES;
    }
  }
}

- (void)mismatchUpdate:(NSUInteger)index {
  self.gameScore -= kMISMATCH_PENALTY;
  [self emptyChosenCards];
  CardState * cardState = (CardState *)self.cardsState[index];
  cardState.chosen = YES; // Add last card
}

- (void)matchUpdate {
  NSInteger bonus = self.gameCardMode * kMATCH_BONUS;
  self.gameScore += bonus;
  [self matchChosenCards];
}

- (void)chooseUpdate {
}

- (void)unchooseUpdate:(NSUInteger)index {
  CardState * cardState = (CardState *)self.cardsState[index];
  cardState.chosen = NO;
}

#pragma mark - Init

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                     usingMatcher:(id <CardMatcher>)matcher
                      usingDealer:(id <CardDealer>)dealer
                    usingGameMode:(NSUInteger)gameMode {
  if (count < 2 || !matcher || !deck || gameMode < 2|| !dealer) { // Can't mach less than two cards
    return nil;
    
  }
  
  if (self = [super init]) {
    for (int i = 0; i < count; i++) {
      id <Card> card = [deck darwRandomCard];
      CardState *cardState = [[CardState alloc]init];
      if (card) {
        [self.cards addObject:card];
        [self.cardsState addObject:cardState];
      }
      else {
        self = nil;
        break;
      }
    }
    self.cardMode = gameMode;
  }
  
  self.gameMatcher = matcher;
  self.cardDealer = dealer;
  self.deck = deck;
  return self;
}

// Protect our designated initializer
- (instancetype)init {
  return nil;
}

#pragma mark - Public API

- (id <Card>)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (BOOL)isCardChosen:(NSUInteger)index {
  if (![self cardAtIndex:index]) {
    return NO;
  }
  
  CardState * cardState = (CardState *)self.cardsState[index];
  return cardState.isChosen;
}

- (BOOL)isCardMatched:(NSUInteger)index {
  if (![self cardAtIndex:index]) {
    return NO;
  }
  
  CardState * cardState = (CardState *)self.cardsState[index];
  return cardState.isMatched;
}

- (int)moreCardsCount {
  return [self.cardDealer moreCardsToDeal:[self nonMatchedCards] usingCardMatcher:self.gameMatcher];
}

- (BOOL)addCards {
  int moreCounter = [self moreCardsCount];
  BOOL added = NO;
  for (int i = 0; i < moreCounter; i++) {
    id <Card> card = [self.deck darwRandomCard];
    added = YES;
    if (card) {
      CardState *cardState = [[CardState alloc]init];
      [self.cards addObject:card];
      [self.cardsState addObject:cardState];
    }
    else {
      // Empty deck
      added = NO;
      break;
    }
  }
  return added;
}

static const int kMISMATCH_PENALTY = 2;
static const int kMATCH_BONUS = 2;
static const int kCOST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
  if (![self cardAtIndex:index]) {
    return;
  }
  
  CardState * cardState = (CardState *)self.cardsState[index];
  if (cardState.isMatched) {
    // Nothing to be done.
    return;
  }
  
  if (cardState.isChosen) {
    [self unchooseUpdate:index];
  } else {
    self.gameScore -= kCOST_TO_CHOOSE;
    cardState.chosen = YES;
    int matchScore = [self.gameMatcher match:[self chosenCards] maxMatchedCards:self.gameCardMode];
    
    if (matchScore == -1) {
      NSLog(@"ERORR: match function");
      return;
    }
    if (!matchScore && ([[self chosenCards] count] == self.gameCardMode)) {
      [self mismatchUpdate:index];
    } else if (matchScore && ([[self chosenCards] count] == self.gameCardMode)) {
      [self matchUpdate];
    } else {
      [self chooseUpdate];
    }
  }
}

- (void)chooseCard:(id <Card>)card {
  [self chooseCardAtIndex:[self.cards indexOfObject:card]];
}

- (NSUInteger)findCard:(id <Card>)card {
  return [self.cards indexOfObject:card];
}


- (NSUInteger)cardCount {
  return [[self cards] count];
}

@end
