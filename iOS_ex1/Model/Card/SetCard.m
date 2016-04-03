// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "SetCard.h"

@implementation SetCard

#pragma mark - Properties

- (NSString *)contents {
  return nil;
}

- (void)setNumberOfSymbols:(NSUInteger)numberOfSymbols {
  if (numberOfSymbols <= [SetCard maxNumberOfSymbols]) {
    _numberOfSymbols = numberOfSymbols;
  }
}

#pragma mark - Class methods

+ (NSUInteger)maxNumberOfSymbols {
  return 3;
}


@end
