//
//  XyFieldContainerView.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.07.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XyFieldView.h"

@interface XyFieldContainerView : UIView

-(void)initializeSubviews;

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet XyFieldView *xyFieldView;

@end
