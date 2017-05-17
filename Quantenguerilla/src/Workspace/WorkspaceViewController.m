//
//  WorkspaceViewController.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 28.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "WorkspaceViewController.h"

@interface WorkspaceViewController ()

@end

@implementation WorkspaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _workspace = [[WorkspaceCommon alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setProject:(Project*)project {
    [_workspace setProject:project];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuButtonPressed:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    
    // todo remove all gesture recognizers etc.
    //[self.view.window removeGestureRecognizer:sender];
    
    // todo - screenshot etc; delegate for communication with parent view controller!!!
    // 1. save in project only
    // 2. back in menu mark workspace cell as "unsaved" (colored frame?)
    // 3. when opening other workspace -> pop up (save, discard, cancel)
    // (same in FXWorkspaceViewController!!)
    // 4. on save: write project data to file
    [_workspace storeProjectData:self.view];
    [self.delegate workspaceChanged:self forProject:_workspace.project];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
