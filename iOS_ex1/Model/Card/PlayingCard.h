// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import "Card.h"

@interface PlayingCard : NSObject <Card>

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
