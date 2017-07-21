//
//  NewWorkspaceViewController.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 29.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "NewWorkspaceViewController.h"
#import "WorkspaceViewController.h"
#import "FXWorkspaceViewController.h"

@interface NewWorkspaceViewController ()

@end

@implementation NewWorkspaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 250, 60)];
    //test.text = @"TEST";
    //[self.view addSubview:test];
//    CGRect newFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, NEW_WORKSPACE_VC_WIDTH, NEW_WORKSPACE_VC_HEIGHT);
//    self.view.frame = newFrame;
    self.preferredContentSize = CGSizeMake(NEW_WORKSPACE_VC_WIDTH, NEW_WORKSPACE_VC_HEIGHT);
    _selectedWorkspaceType = no_workspace_type_selected;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if(!_tapBehindGesture) {
        _tapBehindGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBehindDetected:)];
        [_tapBehindGesture setNumberOfTapsRequired:1];
        [_tapBehindGesture setCancelsTouchesInView:NO]; //So the user can still interact with controls in the modal view
        _tapBehindGesture.delegate = self;
        [self.view.window addGestureRecognizer:_tapBehindGesture];
    }
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(_tapBehindGesture) {
        [self.view.window removeGestureRecognizer:_tapBehindGesture];
        _tapBehindGesture = nil;
    };
    
    [self.delegate newWorkspaceTypeSelected:self newWorkspaceType:_selectedWorkspaceType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Gestures

- (void)tapBehindDetected:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint location = [sender locationInView:nil];//self.view];

        // convert the tap's location into the local view's coordinate system, and test to see if it's in or outside. If outside, dismiss the view.
        if (![self.view pointInside:[self.view convertPoint:location fromView:self.view.window] withEvent:nil]) {
            
            // remove the recognizer first so it's view.window is valid
            [self.view.window removeGestureRecognizer:sender];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}
// because of iOS8
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}



#pragma mark - new workspace (segue)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSIndexPath *indexPath = (NSIndexPath*)sender;
    
    // segue identifier from storyboard!!
    if ([[segue identifier] isEqualToString:@"workspaceSegue"]) {
        
        UIStoryboard *workspaceStoryboard = [UIStoryboard storyboardWithName:@"WorkspaceStoryboard" bundle:nil];
        WorkspaceViewController *workspaceVC = [workspaceStoryboard instantiateInitialViewController];
        //WorkspaceViewController *workspaceVC = (WorkspaceViewController*)[workspaceStoryboard instantiateViewControllerWithIdentifier:@"workspaceSegue"];
        [self.navigationController pushViewController:workspaceVC animated:YES];

        // Get reference to the destination view controller
        //WorkspaceViewController *workspaceVC = [segue destinationViewController];
    }
    else if ([[segue identifier] isEqualToString:@"fxWorkspaceSegue"]) {
        FXWorkspaceViewController* fxWorkspaceVC = [segue destinationViewController];
        //newWorkspaceVC.transitioningDelegate = self;
        // todo - pass any data??
        [self.navigationController pushViewController:fxWorkspaceVC animated:YES];
        
    }
}

- (IBAction)newFxControllerButtonPressed:(id)sender {
    // create FX Controller (FXWorkspaceViewController)
    //[self performSegueWithIdentifier:@"fxWorkspaceSegue" sender:self];
    _selectedWorkspaceType = fx_controller;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)newFxFbControllerButtonPressed:(id)sender {
    // create FX + FB Controller (WorkspaceViewController)
    //[self performSegueWithIdentifier:@"workspaceSegue" sender:self];
    
    // todo - go back to main menu view controller (return value??) and open new view controller from there!
    _selectedWorkspaceType = fx_fb_controller;
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    UIStoryboard *workspaceStoryboard = [UIStoryboard storyboardWithName:@"WorkspaceStoryboard" bundle:nil];
//    WorkspaceViewController *workspaceVC = [workspaceStoryboard instantiateInitialViewController];
//    workspaceVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self.navigationController pushViewController:workspaceVC animated:YES];
}

- (IBAction)backButtonPressed:(id)sender {
    // remove the recognizer first so it's view.window is valid
    [self.view.window removeGestureRecognizer:_tapBehindGesture];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
