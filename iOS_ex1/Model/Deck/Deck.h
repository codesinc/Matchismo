// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.


#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(id <Card>)card atTop:(BOOL)atTop;
- (void)addCard:(id <Card>)card;
- (id <Card>)darwRandomCard;

@end
