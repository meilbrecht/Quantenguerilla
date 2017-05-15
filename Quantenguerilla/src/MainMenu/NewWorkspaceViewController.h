//
//  NewWorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewWorkspaceViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UITapGestureRecognizer *tapBehindGesture;

@end
