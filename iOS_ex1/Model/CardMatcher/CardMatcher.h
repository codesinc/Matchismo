// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

NS_ASSUME_NONNULL_BEGIN

@protocol CardMatcher <NSObject>
- (int)match:(NSArray *)cards maxMatchedCards:(NSUInteger)maxMatched;
@end

NS_ASSUME_NONNULL_END
