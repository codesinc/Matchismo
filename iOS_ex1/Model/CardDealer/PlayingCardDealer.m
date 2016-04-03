// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "PlayingCardDealer.h"

@implementation PlayingCardDealer

// Playing card maching game sholuld never deal more cards.
- (int)moreCardsToDeal:(NSArray *)cards usingCardMatcher:(id <CardMatcher>)matcher {
  return 0;
}

@end
