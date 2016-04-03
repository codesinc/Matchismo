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
//@property (readonly, nonatomic) NSInteger cardCount;
//@property (strong, readonly, nonatomic) NSString *lastSessionLog;
//@property (strong, readonly, nonatomic) NSArray *lastSessionCards;


@property (nonatomic) NSUInteger gameCardMode;
@property (strong, nonatomic) id <CardMatcher> gameMatcher;
@property (readonly, nonatomic) id cardDealer;


@end
