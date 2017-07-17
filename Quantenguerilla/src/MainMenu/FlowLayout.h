//
//  FlowLayout.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.07.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowLayout : UICollectionViewFlowLayout

@property (assign, nonatomic) CGFloat scrollingSpeed;
@property (assign, nonatomic) UIEdgeInsets scrollingTriggerEdgeInsets;

- (void)handlePanGesture:(UIGestureRecognizer *)gestureRecognizer;

@end
