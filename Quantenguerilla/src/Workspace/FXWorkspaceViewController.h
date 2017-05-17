//
//  FXWorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkspaceCommon.h"

@class FXWorkspaceViewController;   // todo - erben von WorkspaceViewController????

@protocol FXWorkspaceDelegate <NSObject>
- (void)fxWorkspaceChanged:(FXWorkspaceViewController*)controller forProject:(Project*)project;
@end

@interface FXWorkspaceViewController : UIViewController

@property (nonatomic, weak) id <FXWorkspaceDelegate> delegate;

@property (nonatomic, strong) WorkspaceCommon *workspace;

- (void) setProject:(Project*)project;

@end
