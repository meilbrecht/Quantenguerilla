//
//  MainMenu.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 26.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "MainMenu.h"
#import <UIKit/UIKit.h>

@implementation MainMenu

- (id) init {
    
    self = [super init];
    
    if(self) {
        _dndIndex = -1;
        _dndTarget = -1;
    }
    
    return self;
}

- (void) showFolderContentForPath:(NSString*)path {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *direnum = [manager enumeratorAtPath:path];
    NSString *filename;
    
    NSLog(@"### Current Path: %@ ###", path);
    NSLog(@"### Files in resource folder: ###");
    while ((filename = [direnum nextObject] )) {
        
        //change the suffix to what you are looking for
        //if ([filename hasSuffix:@".data"]) {
        
        // Do work here
        NSLog(@"> %@", filename);
        //}
    }
}

- (NSArray*) getImgDirectoryContent {
    NSMutableString* bundlePath = [NSMutableString stringWithCapacity:4];
    [bundlePath appendString:[[NSBundle mainBundle] bundlePath]];
    [self showFolderContentForPath:bundlePath];
    NSArray *directoryContent  = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:nil];
    return directoryContent;
}

- (uint16_t) getNumberOfImages {
    
    __block uint16_t numberOfImages=0;
    NSArray *directoryContent = [self getImgDirectoryContent];
    
    [directoryContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if([extension isEqualToString:@"jpg"] && ![filename isEqualToString:@"plus.jpg"]) {
            numberOfImages++;
        }
    }];
    
    return numberOfImages;
}

// unused
//- (NSArray*) loadImages {
//    
//    __block NSMutableArray* images = [[NSMutableArray alloc]init];
//    NSArray *directoryContent = [self getImgDirectoryContent];
//    
//    [directoryContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//       
//        NSString *filename = (NSString *)obj;
//        NSString *extension = [[filename pathExtension] lowercaseString];
//        
//        if([extension isEqualToString:@"jpg"] && ![filename isEqualToString:@"plus.jpg"]) {
//            // skip "plus.jpg" - will be added manually
//            [images addObject:[UIImage imageNamed:filename]];
//        }
//    }];
//    
//    return images;
//}

- (void) loadProjects {
    
    if(_projects==nil) {
        _projects = [[NSMutableArray alloc] init];
    }
    
    // todo -   FAKE version for testing only!!!!
    //      TODO:
    //          load project files, not screenshots here!!
    //          project file needs "link" to screenshot
        
    NSArray *directoryContent = [self getImgDirectoryContent];
    [directoryContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Project *project = [[Project alloc] init];
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if([extension isEqualToString:@"jpg"] && ![filename isEqualToString:@"plus.jpg"]) {
            project.screenshot = [UIImage imageNamed:filename];
            project.title = [filename stringByDeletingPathExtension];
            [_projects addObject:project];
        }
    }];
}

- (void) reorderProjects {
    
    //_dndIndex is the object currently moved by drag and drop
    if((_projects == nil) || (_dndIndex == -1) || (_dndTarget == -1)) {
        // invalid
        return;
    }
    
    if(_dndTarget > [_projects count]) {
        [NSException raise:@"Invalid operation - target index does not exist" format:@"Invalid operation - target index %d does not exist", _dndTarget];
    }
    
    NSLog(@"move element %d to position %d", _dndIndex, _dndTarget);
    
    Project *movedProject = [_projects objectAtIndex:_dndIndex];
    [_projects removeObjectAtIndex:_dndIndex];
    [_projects insertObject:movedProject atIndex:_dndTarget];
    
    // todo - save to global app settings file!!!
}

- (void) addProject:(Project*)project {
    if((_projects == nil) || (project == nil)) {
        [NSException raise:@"Invalid operation - could not add project to list" format:@"Invalid operation - either the project array (%@) or the new project (%@) does not exist", _projects, project];
    }
    
    int count=0;
    boolean_t overrideProject=false;
    //uint8_t equalNameCounter=0;
    // todo - wont work if projects with equal name + number are changed in order!!!
    for(count=0; count<[_projects count]; count++) {
        Project *oldProject = [_projects objectAtIndex:count];
        if([oldProject.title isEqualToString:project.title]) {
            overrideProject = true; // todo - pop-up: ask if project shall be overwritten?
            break;
            // todo - replace old project with new project (delete and add?)
//            equalNameCounter++;
//            NSString *appending = [NSString stringWithFormat: @" %d", equalNameCounter];
//            project.title = [project.title stringByAppendingString:appending];
        }
    }

    if(overrideProject) {
        [_projects replaceObjectAtIndex:count withObject:project];
    } else {
        [_projects addObject:project];
    }
}

@end
