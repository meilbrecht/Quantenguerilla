//
//  FingerboardContainerView.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.07.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FingerboardView.h"

@interface FingerboardContainerView : UIView

-(void)initializeSubviews;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet FingerboardView *fingerboardView;


@end
