//
//  ViewController.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 26.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ProjectPreviewCollectionViewCell.h"
#import "WorkspaceViewController.h"
#import "FXWorkspaceViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _bEditMode = false;
    
    if(_mainmenu==nil) {
        _mainmenu = [[MainMenu alloc]init];
        [_mainmenu loadProjects];
    }
    
    [self initCollectionView];
    [self initGestureRecognizer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initCollectionView {

    [_menuGridCollectionView setDataSource:self];
    [_menuGridCollectionView setDelegate:self];
    [_menuGridCollectionView registerClass:[ProjectPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_menuGridCollectionView setBackgroundColor:[UIColor blackColor]];
    
    _flowLayout = [[FlowLayout alloc] init];
    //[_flowLayout setItemSize:_menuGridCollectionView.itemSize];
    [_flowLayout setItemSize:CGSizeMake(324,224)];
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [_menuGridCollectionView setBounces:NO];
    [_menuGridCollectionView setCollectionViewLayout:_flowLayout];
    _menuGridCollectionView.pagingEnabled = true;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // todo - get number of projects!!! (not images)
    NSInteger numberOfProjects;
    numberOfProjects = [_mainmenu.projects count];
    
    return (numberOfProjects+1);   // +1 for new project button (plus)
}

// create a cell for the "new project" button
- (UICollectionViewCell *) createNewProjectCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"newProjectCell";
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [self calcNumberOfPages];
    return cell;
}

// create a cell for a preview of an existing project
- (ProjectPreviewCollectionViewCell *) createProjectPreviewCell:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifier = @"customCell";
    
    ProjectPreviewCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor blackColor];
    if(_bEditMode) {
        cell.deleteButton.hidden = false;
        [self.view bringSubviewToFront:cell.deleteButton];
    } else {
        cell.deleteButton.hidden = true;
    }
    
    if(([indexPath row])<[_mainmenu.projects count]) {
        Project *project = [_mainmenu.projects objectAtIndex:([indexPath row])];
        cell.imageView.image = project.screenshot;
        if(!cell.projectName) {
            [cell projectName];
        }
        cell.projectName.text = project.title;
        //NSLog(@"title: %@", project.title);
    }
    [self calcNumberOfPages];
    return cell;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if(_mainmenu.projects == nil) {
        [NSException raise:@"MainMenuViewController: Invalid operation - _mainmenu.projects is undefined" format:@"Invalid operation - _mainmenu.projects is undefined"];
    }
    
    if([indexPath row] >= [_mainmenu.projects count]) {
        cell = [self createNewProjectCell:collectionView atIndexPath:indexPath];
    }
    else {
        cell = [self createProjectPreviewCell:collectionView atIndexPath:indexPath];
    }
    
    return cell;
}

- (void) collectionView:(UICollectionView*)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    
}


#pragma mark - UIScrollVewDelegate for UIPageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = _menuGridCollectionView.frame.size.width;
    float currentPage = _menuGridCollectionView.contentOffset.x / pageWidth;
    NSLog(@"MainMenuViewController: scrollViewDidEndDecelerating");
    
    if (0.0f != fmodf(currentPage, 1.0f)) {
        _pageControl.currentPage = currentPage + 1;
    } else {
        _pageControl.currentPage = currentPage;
    }
    //NSLog(@"finishPage: %ld", (long)_pageControl.currentPage);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = _menuGridCollectionView.frame.size.width;
    float currentPage = _menuGridCollectionView.contentOffset.x / pageWidth;
    NSLog(@"MainMenuViewController: scrollViewDidScroll");
    
    if (0.0f != fmodf(currentPage, 1.0f)) {
        _pageControl.currentPage = currentPage + 1;
    } else {
        _pageControl.currentPage = currentPage;
    }
    //NSLog(@"finishPage: %ld", (long)_pageControl.currentPage);
}

- (void)calcNumberOfPages {
    int pages = floor(_menuGridCollectionView.contentSize.width / _menuGridCollectionView.frame.size.width) +1;
    [_pageControl setNumberOfPages:pages];
}


#pragma mark - load another view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath*)sender;
    
    // segue identifier from storyboard!!
    if ([[segue identifier] isEqualToString:@"workspaceSegue"]) {
        // Get reference to the destination view controller
        WorkspaceViewController *workspaceVC = [segue destinationViewController];
//        workspaceVC.transitioningDelegate = self;
        if(indexPath!=nil) {
            NSLog(@"PROJECT INDEX: %ld", (long)indexPath.row);
            NSLog(@"LAST PROJECT INDEX: %u", ([_mainmenu.projects count]-1));
            [workspaceVC setProject:[_mainmenu.projects objectAtIndex:indexPath.row]];
        }
        //[self performSegueWithIdentifier:@"workspaceSegue" sender:self];
        //[self.navigationController pushViewController:workspaceVC animated:YES];
        //[self.navigationController showViewController:workspaceVC sender:self];
        workspaceVC.delegate = self;
        [self.navigationController presentViewController:workspaceVC animated:YES completion:nil];
    } else if ([[segue identifier] isEqualToString:@"fxWorkspaceSegue"]) {
        // Get reference to the destination view controller
        FXWorkspaceViewController *fxWorkspaceVC = [segue destinationViewController];
        //        workspaceVC.transitioningDelegate = self;
        if(indexPath!=nil) {
            [fxWorkspaceVC setProject:[_mainmenu.projects objectAtIndex:indexPath.row]];
        }
        //[self performSegueWithIdentifier:@"fxWorkspaceSegue" sender:self];
        //[self.navigationController pushViewController:fxWorkspaceVC animated:YES];
        //[self.navigationController showViewController:fxWorkspaceVC sender:self];
        fxWorkspaceVC.delegate = self;
        [self.navigationController presentViewController:fxWorkspaceVC animated:YES completion:nil];
    }
    else if ([[segue identifier] isEqualToString:@"newWorkspaceSegue"]) {
        NewWorkspaceViewController* newWorkspaceVC = [segue destinationViewController];
        newWorkspaceVC.delegate = self;
        //newWorkspaceVC.transitioningDelegate = self;
            // todo - pass any data??
        //newWorkspaceVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        [self.navigationController pushViewController:newWorkspaceVC animated:YES];
        
    }
}



// todo -unused currently (how does that work???)
#pragma mark <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView
{
    if(_selectedItemIndexPath) {
        [NSException raise:@"MainMenuViewController: Invalid operation - no valid item selected" format:@"Invalid operation - no valid item selected"];
    }
    //NSIndexPath *selectedIndexPath = [_menuGridCollectionView indexPathForItemAtPoint:_selectedItemPosition];
    //ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    ProjectPreviewCollectionViewCell *cell = (ProjectPreviewCollectionViewCell*)[_menuGridCollectionView cellForItemAtIndexPath:_selectedItemIndexPath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.imageView.image];
    imageView.contentMode = cell.imageView.contentMode;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.view.superview];
    frameInSuperview.origin.x -= cell.layoutMargins.left;
    frameInSuperview.origin.y -= cell.layoutMargins.top;
    imageView.frame = frameInSuperview;
    return imageView;
}

- (UIColor *)transitionSourceBackgroundColor
{
    return self.view.backgroundColor;
}

- (CGRect)transitionDestinationImageViewFrame
{
    //NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    //ImageTableViewCell *cell = (ImageTableViewCell *)[self.tableView cellForRowAtIndexPath:selectedIndexPath];
    ProjectPreviewCollectionViewCell *cell = (ProjectPreviewCollectionViewCell*)[_menuGridCollectionView cellForItemAtIndexPath:_selectedItemIndexPath];
    CGRect frameInSuperview = [cell.imageView convertRect:cell.imageView.frame toView:self.view.superview];
    frameInSuperview.origin.x -= cell.layoutMargins.left;
    frameInSuperview.origin.y -= cell.layoutMargins.top;
    return frameInSuperview;
}

// todo -unused currently (how does that work???)
#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)source;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)presented;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = YES;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> sourceTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)dismissed;
    id <RMPZoomTransitionAnimating, RMPZoomTransitionDelegate> destinationTransition = (id<RMPZoomTransitionAnimating, RMPZoomTransitionDelegate>)self;
    if ([sourceTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)] &&
        [destinationTransition conformsToProtocol:@protocol(RMPZoomTransitionAnimating)]) {
        RMPZoomTransitionAnimator *animator = [[RMPZoomTransitionAnimator alloc] init];
        animator.goingForward = NO;
        animator.sourceTransition = sourceTransition;
        animator.destinationTransition = destinationTransition;
        return animator;
    }
    return nil;
}


#pragma mark - (New) Workspace View Controller Delegates

- (void) handleChangedWorkspaceForProject:(Project*)project {
    // display new screenshot in collection view and add project to array
    //  check if project already exists (previously loaded from here) or if it is a new project!!
    
    //todo - if(projectType == newProject) {
    
        [_mainmenu addProject:project];
        // todo - only reload specific project!?
        [_menuGridCollectionView reloadData];
    
    
    // } else {
    
    // }
    
}

- (void) workspaceChanged:(WorkspaceViewController *)controller forProject:(Project *)project {
    [self handleChangedWorkspaceForProject:project];
}

-(void) fxWorkspaceChanged:(FXWorkspaceViewController *)controller forProject:(Project *)project {
    [self handleChangedWorkspaceForProject:project];
}

- (void) newWorkspaceTypeSelected:(NewWorkspaceViewController *)controller newWorkspaceType:(WorkspaceType)type {
    
    if(type == fx_controller) {
        // todo - set project and workspace to nil (new one!), ask before that, if changes (if available) in last project should be changed
        [self performSegueWithIdentifier:@"fxWorkspaceSegue" sender:nil];
    } else if(type == fx_fb_controller) {
        // todo - set project and workspace to nil (new one!), ask before that, if changes (if available) in last project should be changed
        [self performSegueWithIdentifier:@"workspaceSegue" sender:nil];
    } else {
        // selection for new workspace canceled
    }
}






#pragma mark - gesture recognizer

// open project / new project:
- (void) handleTapGesture:(UITapGestureRecognizer*) gesture {
    
    if(gesture.state == UIGestureRecognizerStateEnded) {
        
        NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
        _selectedItemIndexPath = indexPath;
        
        if(_bEditMode) {
            
            
            
        } else {
            // open project workspace
            // check which cell was tapped
            if(indexPath.row < [_mainmenu.projects count]) {
                // load workspace (todo - check project type!!!)
                //[self performSegueWithIdentifier:@"workspaceSegue" sender:self];
                [self performSegueWithIdentifier:@"workspaceSegue" sender:indexPath];
            } else {
                // new workspace
                [self performSegueWithIdentifier:@"newWorkspaceSegue" sender:indexPath];
            }
        }
        
    }
    
}



- (void) handleLongGesture:(UILongPressGestureRecognizer*) gesture {
    
    switch(gesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            
                NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
            
                //NSLog(@"long gesture on %ld began", (long)indexPath.row);
            
                if(_bEditMode) {
                    // forbid item being last element ('+' always!!!)
                    if(indexPath &&(indexPath.row < [_mainmenu.projects count])) {
                    
                        NSLog(@"MainMenuViewController: start dragging element");
                        [_menuGridCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                        _mainmenu.dndIndex = indexPath.row;
                    } else {
                    
                        NSLog(@"MainMenuViewController: invalid element for drag & drop actions");
                        [_menuGridCollectionView cancelInteractiveMovement];
                        break;
                    }
                } else {
                    
                }
            }
            break;
       
        case UIGestureRecognizerStateChanged: {
            
                //NSLog(@"long gesture changed");
            
                if(_mainmenu.dndIndex >= [_mainmenu.projects count]) {
                    break;
                }
            
                if(_bEditMode) {
                    [_menuGridCollectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
                }
            }
            break;
        
        case UIGestureRecognizerStateEnded: {
            
                //NSLog(@"long gesture on ended");
            
                if(_mainmenu.dndIndex >= [_mainmenu.projects count]) {
                    break;
                }
            
                NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
            
                if(_bEditMode) {
                    if(indexPath && (indexPath.row < [_mainmenu.projects count])) {
                        NSLog(@"MainMenuViewController: dropped at new position");
                        _mainmenu.dndTarget = indexPath.row;
                        [_mainmenu reorderProjects];
                        [_menuGridCollectionView endInteractiveMovement];
                    } else {
                        // todo - does not work!! check falid position also in flow layout!?
                        NSLog(@"MainMenuViewController: drag & drop canceled - invalid position");
                        [_menuGridCollectionView cancelInteractiveMovement];
                    }
                    _mainmenu.dndIndex=-1;
                    _mainmenu.dndTarget=-1;
                } else {
                    
                }
            }
            break;
        
        default:
            if(_bEditMode) {
                NSLog(@"MainMenuViewController: drag & drop canceled");
                [_menuGridCollectionView cancelInteractiveMovement];
                _mainmenu.dndIndex=-1;
                _mainmenu.dndTarget=-1;
            }
            break;
    }
}

- (void) initGestureRecognizer {
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)]
    ;
    [lpgr addTarget:_flowLayout action:@selector(handlePanGesture:)];
    [_menuGridCollectionView addGestureRecognizer:lpgr];

    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_menuGridCollectionView addGestureRecognizer:tgr];
}


#pragma mark - altert message

-(void)showAlertMessage:(NSString*)message withTitle:(NSString *)title {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
        NSLog(@"yes, kill that project! it sucks like hell!");
        // todo - call delete function, remove all setting and screenshot files
    }];
    [alert addAction:yesAction];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
        NSLog(@"nope. let's keep it.");
    }];
    [alert addAction:noAction];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}
    

#pragma mark - other ui actions

- (IBAction)editButtonPressed:(id)sender {
    
    UIButton *btn = (UIButton*)sender;
    // toggle edit mode (TODO - change button image?)
    if(_bEditMode) {
        NSLog(@"MainMenuViewController: edit mode disabled");
        _bEditMode = false;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        NSLog(@"MainMenuViewController: edit mode enabled");
        _bEditMode = true;
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
    [_menuGridCollectionView reloadData];
}

- (IBAction)deleteButtonPressed:(id)sender {
    
    NSIndexPath *indexPath = nil;
    CGPoint location = [sender convertPoint:CGPointZero toView:_menuGridCollectionView];
    indexPath = [_menuGridCollectionView indexPathForItemAtPoint:location];
    NSLog(@"Delete project %ld", (long)[indexPath row]);
    [self showAlertMessage:@"Are you sure that you want to permanently delete the workspace?" withTitle:@"Deleting Workspace"];
}



@end
