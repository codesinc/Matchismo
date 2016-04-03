// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "PlayingCardsMatcher.h"
#import "PlayingCard.h"

@implementation PlayingCardsMatcher
- (int)match:(NSArray *)cardsToMatch maxMatchedCards:(NSUInteger)maxMatched {
  if (!cardsToMatch || [cardsToMatch count] == 0) {
    return -1;
  }
  
  int maxRankCounter = 0;
  int maxSuitCounter = 0;
  
  for (int i = 0; i < [cardsToMatch count]; i++) {
    int rankCounter = 0;
    int suitCounter = 0;
    
    for (int j = i + 1; j < [cardsToMatch count]; j++) {
      if (![[cardsToMatch objectAtIndex:i] isKindOfClass:[PlayingCard class]] || ![[cardsToMatch objectAtIndex:j] isKindOfClass:[PlayingCard class]]) {
        return -1;
      }
      
      PlayingCard *card = [cardsToMatch objectAtIndex:i];
      PlayingCard *otherCard = [cardsToMatch objectAtIndex:j];
      
      if ([card.suit isEqualToString:otherCard.suit]) {
        suitCounter += 1;
      } else if (card.rank == otherCard.rank) {
        rankCounter += 1;
      }
    }
    if (maxRankCounter < rankCounter) {
      maxRankCounter = rankCounter;
    }
    if (maxSuitCounter < suitCounter) {
      maxSuitCounter = suitCounter;
    }
  }
  
  int max = maxRankCounter > maxSuitCounter ? maxRankCounter: maxSuitCounter;
  return max >= maxMatched -1 ? max: 0;
}

@end
