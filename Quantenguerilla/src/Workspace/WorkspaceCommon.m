//
//  WorkspaceCommon.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.05.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "WorkspaceCommon.h"

@implementation WorkspaceCommon


- (void)setProject:(Project *)project {
    _project = project;
}

- (UIImage*) getScreenshotOfView:(UIView*)view {
    UIGraphicsBeginImageContext(view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}

- (void)storeProjectData:(UIView*)view {
    if(_project==nil) {
        _project =[[Project alloc]init];
        _project.title = @"NEW PROJECT";
    }
    _project.screenshot = [self getScreenshotOfView:view];
    // todo...
}

@end
