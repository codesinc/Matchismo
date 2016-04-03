// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by codesinc.

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingCardView : CardView

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic) BOOL faceUp;

@end
