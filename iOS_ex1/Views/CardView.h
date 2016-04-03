// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import <UIKit/UIKit.h>
#import "Card.h"
@interface CardView: UIView
@property (strong, nonatomic) id <Card> card;

- (CGFloat)cornerScaleFactor;
- (CGFloat)cornerRadius;
- (CGFloat)cornerOffset;

@end
