// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import "SetCard.h"

@implementation SetCard

- (NSString *)contents {
  return nil;
}

//+ (NSArray *)validSymbols {
//  return @[@"▲", @"◼︎", @"●"];
//}

+ (NSUInteger)maxNumberOfSymbols {
  return 3;
}

//@synthesize symbol = _symbol;
//
//- (NSString *)symbol {
//  return _symbol ? _symbol : @"?";
//}

//- (void)setSymbol:(NSString *)symbol {
//  if ([[SetCard validSymbols] containsObject:symbol]) {
//    _symbol = symbol;
//  }
//}

- (void)setNumberOfSymbols:(NSUInteger)numberOfSymbols {
  if (numberOfSymbols <= [SetCard maxNumberOfSymbols]) {
    _numberOfSymbols = numberOfSymbols;
  }
}


@end
