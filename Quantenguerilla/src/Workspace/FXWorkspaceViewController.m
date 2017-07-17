//
//  FXWorkspaceViewController.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "FXWorkspaceViewController.h"

@interface FXWorkspaceViewController ()

@end

@implementation FXWorkspaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _workspace = [[WorkspaceCommon alloc] init];
    
    [_xyFieldContainerView1 initializeSubviews];
    [self.view addSubview:_xyFieldContainerView1];
    [_xyFieldContainerView2 initializeSubviews];
    [self.view addSubview:_xyFieldContainerView2];
    [_xyFieldContainerView3 initializeSubviews];
    [self.view addSubview:_xyFieldContainerView3];
    [_xyFieldContainerView4 initializeSubviews];
    [self.view addSubview:_xyFieldContainerView4];
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
    [_workspace storeProjectData:self.view];
    [self.delegate fxWorkspaceChanged:self forProject:_workspace.project];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
