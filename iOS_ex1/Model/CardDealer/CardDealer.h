// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.
#import "CardMatcher.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CardDealer <NSObject>
- (int)moreCardsToDeal:(NSArray *)cards usingCardMatcher:(id <CardMatcher>)matcher;
@end

NS_ASSUME_NONNULL_END
