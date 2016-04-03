// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "PlayingCard.h"

@implementation PlayingCard

#pragma mark - Properties

- (NSString *)contents {
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (void)setRank:(NSUInteger)rank {
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

#pragma mark - Class methods

+ (NSArray *)validSuits {
  return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+ (NSArray *)rankStrings {
  return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
  return [[self rankStrings] count] - 1;
}

@end
