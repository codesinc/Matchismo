// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardMatcher.h"
#import "CardDealer.h"

@interface CardMatchingGame : NSObject

/// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                     usingMatcher:(id <CardMatcher>)matcher
                      usingDealer:(id <CardDealer>)dealer
                    usingGameMode:(NSUInteger)gameMode;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (void)chooseCard:(id <Card>)card;
- (NSUInteger)findCard:(id <Card>)card;
- (id <Card>)cardAtIndex:(NSUInteger)index;
- (NSUInteger)cardCount;
- (BOOL)isCardChosen:(NSUInteger)index;
- (BOOL)isCardMatched:(NSUInteger)index;

- (BOOL)addCards;
- (int)moreCardsCount;

@property (readonly, nonatomic) NSInteger gameScore;
@property (nonatomic) NSUInteger gameCardMode;


@end
