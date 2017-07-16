//
//  Project.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 28.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum workspace_type {
    no_workspace_type_selected,
    fx_controller,
    fx_fb_controller
}WorkspaceType;

@interface Project : NSObject

@property (nonatomic) NSString* title;
@property (nonatomic) UIImage* screenshot;
@property (nonatomic) WorkspaceType *workspaceType;

@property (nonatomic) boolean_t hasChanged;

@end
