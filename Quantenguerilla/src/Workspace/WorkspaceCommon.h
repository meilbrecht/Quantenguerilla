//
//  WorkspaceCommon.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.05.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Project.h"

@interface WorkspaceCommon : NSObject

@property (nonatomic, strong) Project *project;


- (void)setProject:(Project *)project;
- (UIImage*)getScreenshotOfView:(UIView*)view;
- (void)storeProjectData:(UIView*)view;

@end
