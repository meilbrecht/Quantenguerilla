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

- (NSArray*) getImgDirectoryContent {
    NSMutableString* bundlePath = [NSMutableString stringWithCapacity:4];
    [bundlePath appendString:[[NSBundle mainBundle] bundlePath]];
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

- (NSArray*) loadImages {
    
    __block NSMutableArray* images = [[NSMutableArray alloc]init];
    NSArray *directoryContent = [self getImgDirectoryContent];
    
    [directoryContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        
        if([extension isEqualToString:@"jpg"] && ![filename isEqualToString:@"plus.jpg"]) {
            // skip "plus.jpg" - will be added manually
            [images addObject:[UIImage imageNamed:filename]];
        }
    }];
    
    return images;
}

- (void) loadProjects {
    
    if(_projects==nil) {
        _projects = [[NSMutableArray alloc] init];
    }
        
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

@end
