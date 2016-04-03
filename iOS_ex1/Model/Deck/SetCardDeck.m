// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "SetCardDeck.h"

@implementation SetCardDeck

- (instancetype)init {
  self = [super init];
  if (self) {
    for (NSUInteger shape= 0; shape < TotalShape; shape++) {
      for (NSUInteger numberOfSymbols = 1; numberOfSymbols <= [SetCard maxNumberOfSymbols]; numberOfSymbols++) {
        for (NSUInteger color= 0; color < TotalColor; color++) {
          for (NSUInteger shade = 0; shade < TotalShading; shade++) {
            SetCard *card = [[SetCard alloc] init];
            card.shape = shape;
            card.numberOfSymbols = numberOfSymbols;
            card.color = (SetCardColor)color;
            card.shading = (SetCardShading)shade;
            [self addCard:card];
          }
        }
      }
    }
  }
  return self;
}

@end
