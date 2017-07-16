//
//  WorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 28.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkspaceCommon.h"
#import "XyFieldView.h"

@class WorkspaceViewController;

@protocol WorkspaceDelegate <NSObject>
- (void)workspaceChanged:(WorkspaceViewController*)controller forProject:(Project*)project;
@end

@interface WorkspaceViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <WorkspaceDelegate> delegate;

@property (nonatomic, strong) WorkspaceCommon *workspace;

@property (weak, nonatomic) IBOutlet XyFieldView *xyFieldView1;
@property (weak, nonatomic) IBOutlet XyFieldView *xyFieldView2;
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;

- (void) setProject:(Project*)project;

@end
