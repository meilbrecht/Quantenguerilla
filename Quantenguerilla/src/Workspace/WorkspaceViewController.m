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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setProject:(nullable NSObject*)project {
    
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
