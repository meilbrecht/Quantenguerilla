//
//  AppDelegate.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 26.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

