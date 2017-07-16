//
//  WorkspaceCommon.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.05.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "WorkspaceCommon.h"

@implementation WorkspaceCommon

- (id)init {
    if(_project==nil) {
        _project =[[Project alloc]init];
        _project.title = @"NEW PROJECT";
    }
    return self;
}

- (void)setProject:(Project *)project {
    if(project==nil) {
        NSLog(@"project is empty");
        project = [[Project alloc] init];
    }
    if([project.title compare:@""]==0) {
        NSLog(@"new project");
        project.title = @"NEW PROJECT";
    }
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
    } else {
        // project already exists
    }
    _project.screenshot = [self getScreenshotOfView:view];
    // todo...
}

@end
