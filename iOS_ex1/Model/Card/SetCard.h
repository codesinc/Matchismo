// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import <Foundation/Foundation.h>
#import "Card.h"


typedef NS_ENUM(NSUInteger, SetCardShading) {
  Solid,
  Striped,
  Open,
  TotalShading
};
typedef NS_ENUM(NSUInteger, SetCardColor) {
  Red,
  Green,
  Purple,
  TotalColor
};
typedef NS_ENUM(NSUInteger, SetCardShape) {
  Diamond,
  Squiggle,
  Oval,
  TotalShape
};

@interface SetCard : NSObject <Card>

+ (NSUInteger)maxNumberOfSymbols;

@property (nonatomic) NSUInteger numberOfSymbols;
@property (nonatomic) SetCardColor color;
@property (nonatomic) SetCardShading shading;
@property (nonatomic) SetCardShape shape;


@end
