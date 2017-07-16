//
//  Project.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 28.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "Project.h"

@implementation Project

@synthesize title = _title;
@synthesize screenshot = _screenshot;
@synthesize workspaceType = _workspaceType;

@synthesize hasChanged = _hasChanged;

- (id)init {
    _title = [[NSString alloc] init];
    _screenshot = [[UIImage alloc] init];
    return self;
}

@end
