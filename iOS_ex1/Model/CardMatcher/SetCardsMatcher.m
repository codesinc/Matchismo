// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "SetCardsMatcher.h"
#import "SetCard.h"

@implementation SetCardsMatcher
- (int)match:(NSArray *)cardsToMatch maxMatchedCards:(NSUInteger)maxMatched {
  if (!cardsToMatch || [cardsToMatch count] == 0) {
    return -1;
  }
  
  int maxColorCounter = 0;
  int maxShapeCounter = 0;
  int maxNumberOfSymbolsCounter = 0;
  int maxShadingCounter = 0;
  
  for (int i = 0; i < [cardsToMatch count]; i++) {
    int colorCounter = 0;
    int shapeCounter = 0;
    int numberOfSymbolsCounter = 0;
    int shadingCounter = 0;
    
    for (int j = i + 1; j < [cardsToMatch count]; j++) {
      if (![[cardsToMatch objectAtIndex:i] isKindOfClass:[SetCard class]] || ![[cardsToMatch objectAtIndex:j] isKindOfClass:[SetCard class]]) {
        return -1;
      }
      
      SetCard *card = [cardsToMatch objectAtIndex:i];
      SetCard *otherCard = [cardsToMatch objectAtIndex:j];
      
      if (card.shape == otherCard.shape) {
        shapeCounter += 1;
      }
      if (card.numberOfSymbols == otherCard.numberOfSymbols) {
        numberOfSymbolsCounter += 1;
      }
      if (card.color == otherCard.color) {
        colorCounter += 1;
      }
      if (card.shading == otherCard.shading) {
        shadingCounter += 1;
      }
    }
    
    maxColorCounter = maxColorCounter < colorCounter ? colorCounter : maxColorCounter;
    maxShapeCounter = maxShapeCounter < shapeCounter ? shapeCounter : maxShapeCounter;
    maxNumberOfSymbolsCounter = maxNumberOfSymbolsCounter < numberOfSymbolsCounter ? numberOfSymbolsCounter : maxNumberOfSymbolsCounter;
    maxShadingCounter = maxShadingCounter < shadingCounter ? shadingCounter : maxShadingCounter;
    
  }
  
  return ((maxShadingCounter == 0 || maxShadingCounter == maxMatched - 1) &&
          (maxColorCounter == 0 || maxColorCounter == maxMatched - 1) &&
          (maxNumberOfSymbolsCounter == 0 || maxNumberOfSymbolsCounter == maxMatched - 1) &&
          (maxShapeCounter == 0 || maxShapeCounter == maxMatched - 1));
}

@end
