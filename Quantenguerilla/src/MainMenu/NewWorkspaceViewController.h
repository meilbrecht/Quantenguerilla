//
//  NewWorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NEW_WORKSPACE_VC_WIDTH  598
#define NEW_WORKSPACE_VC_HEIGHT 420

typedef enum workspace_type {
    no_workspace_type_selected,
    fx_controller,
    fx_fb_controller
}WorkspaceType;

@class NewWorkspaceViewController;

@protocol NewWorkspaceDelegate <NSObject>
- (void)newWorkspaceTypeSelected:(NewWorkspaceViewController*)controller newWorkspaceType:(WorkspaceType)type;
@end

@interface NewWorkspaceViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, weak) id <NewWorkspaceDelegate> delegate;
@property (nonatomic) WorkspaceType selectedWorkspaceType;
@property (strong, nonatomic) UITapGestureRecognizer *tapBehindGesture;

@end
