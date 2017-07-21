//
//  FXWorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkspaceCommon.h"
#import "XyFieldContainerView.h"
#import "ControllerGroupContainerView.h"
#import "FaderContainerView.h"

@class FXWorkspaceViewController;   // todo - erben von WorkspaceViewController????

@protocol FXWorkspaceDelegate <NSObject>
- (void)fxWorkspaceChanged:(FXWorkspaceViewController*)controller forProject:(Project*)project;
@end

@interface FXWorkspaceViewController : UIViewController

@property (nonatomic, weak) id <FXWorkspaceDelegate> delegate;

@property (nonatomic, strong) WorkspaceCommon *workspace;

@property (weak, nonatomic) IBOutlet XyFieldContainerView *xyFieldContainerView1;
@property (weak, nonatomic) IBOutlet XyFieldContainerView *xyFieldContainerView2;
@property (weak, nonatomic) IBOutlet XyFieldContainerView *xyFieldContainerView3;
@property (weak, nonatomic) IBOutlet XyFieldContainerView *xyFieldContainerView4;

@property (weak, nonatomic) IBOutlet ControllerGroupContainerView *controllerGroupView1;
@property (weak, nonatomic) IBOutlet ControllerGroupContainerView *controllerGroupView2;
@property (weak, nonatomic) IBOutlet ControllerGroupContainerView *controllerGroupView3;
@property (weak, nonatomic) IBOutlet ControllerGroupContainerView *controllerGroupView4;
@property (weak, nonatomic) IBOutlet FaderContainerView *faderContainerView1;
@property (weak, nonatomic) IBOutlet FaderContainerView *faderContainerView2;
@property (weak, nonatomic) IBOutlet FaderContainerView *faderContainerView3;
@property (weak, nonatomic) IBOutlet FaderContainerView *faderContainerView4;


@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;


- (void) setProject:(Project*)project;

@end
