// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "SetCardDealer.h"
#import "SetCard.h"

@implementation SetCardDealer

#define kCARDS_TO_DEAL 3

- (int)moreCardsToDeal:(NSArray *)cards usingCardMatcher:(id <CardMatcher>)matcher {
  if (!cards || [cards count] == 0) {
    return 0;
  }
  
  BOOL match = NO;
  for (int i = 0; i < [cards count]; i++) {
    for (int j = i + 1; j < [cards count]; j++) {
      for (int k = j + 1; k < [cards count]; k++) {
        if (![[cards objectAtIndex:i] isKindOfClass:[SetCard class]] ||
            ![[cards objectAtIndex:j] isKindOfClass:[SetCard class]] ||
            ![[cards objectAtIndex:k] isKindOfClass:[SetCard class]]) {
          return 0;
        }
        
        SetCard *card = [cards objectAtIndex:i];
        SetCard *otherCard = [cards objectAtIndex:j];
        SetCard *anotherCard = [cards objectAtIndex:k];
        match = match || [matcher match:@[card, otherCard, anotherCard] maxMatchedCards:3];
      }
    }
  }
  
  return !match ? kCARDS_TO_DEAL: 0;
}

@end
