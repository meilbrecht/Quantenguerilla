//
//  MainMenu.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 26.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface MainMenu : NSObject


@property (nonatomic) NSMutableArray* projects;
@property (nonatomic) int16_t dndIndex;
@property (nonatomic) int16_t dndTarget;

- (void) loadProjects;
- (NSArray*) getImgDirectoryContent;
//- (NSArray*) loadImages;
- (uint16_t) getNumberOfImages;
- (void) reorderProjects;
- (void) addProject:(Project*)project;

@end
