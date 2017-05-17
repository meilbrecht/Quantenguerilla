//
//  WorkspaceViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 28.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkspaceCommon.h"

@class WorkspaceViewController;

@protocol WorkspaceDelegate <NSObject>
- (void)workspaceChanged:(WorkspaceViewController*)controller forProject:(Project*)project;
@end

@interface WorkspaceViewController : UIViewController

@property (nonatomic, weak) id <WorkspaceDelegate> delegate;

@property (nonatomic, strong) WorkspaceCommon *workspace;

- (void) setProject:(Project*)project;

@end
