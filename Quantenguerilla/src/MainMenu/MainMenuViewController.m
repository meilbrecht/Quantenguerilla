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
#import "NewWorkspaceViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mainmenu = [[MainMenu alloc]init];
    [_mainmenu loadProjects];
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
    //[_menuGridCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_menuGridCollectionView registerClass:[ProjectPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_menuGridCollectionView setBackgroundColor:[UIColor blackColor]];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //[_flowLayout setItemSize:_menuGridCollectionView.itemSize];
    [_flowLayout setItemSize:CGSizeMake(391, 293)];
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //[_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [_menuGridCollectionView setBounces:NO];
    [_menuGridCollectionView setCollectionViewLayout:_flowLayout];
    _menuGridCollectionView.pagingEnabled = true;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // todo - get number of projects!!! (not images)
    return ([_mainmenu getNumberOfImages]+1);   // +1 for new project button (plus)
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
    
    if(([indexPath row])<[_mainmenu.projects count]) {
        Project *project = [_mainmenu.projects objectAtIndex:([indexPath row])];
        cell.imageView.image = project.screenshot;
        if(!cell.projectName) {
            [cell projectName];
        }
        cell.projectName.text = project.title;
        NSLog(@"title: %@", project.title);
    }
    [self calcNumberOfPages];
    return cell;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    
    if(_mainmenu.projects == nil) {
        [NSException raise:@"Invalid operation - _mainmenu.projects is undefined" format:@"Invalid operation - _mainmenu.projects is undefined"];
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


#pragma mark - (new) workspace view controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = (NSIndexPath*)sender;
    
    // segue identifier from storyboard!!
    if ([[segue identifier] isEqualToString:@"workspaceSegue"]) {
        // Get reference to the destination view controller
        WorkspaceViewController *workspaceVC = [segue destinationViewController];
//        workspaceVC.transitioningDelegate = self;
        [workspaceVC setProject:[_mainmenu.projects objectAtIndex:indexPath.row]];
    }
    else if ([[segue identifier] isEqualToString:@"newWorkspaceSegue"]) {
          NewWorkspaceViewController* newWorkspaceVC = [segue destinationViewController];
        //newWorkspaceVC.transitioningDelegate = self;
            // todo - pass any data??
        
    }
}



// todo -unused currently (how does that work???)
#pragma mark <RMPZoomTransitionAnimating>

- (UIImageView *)transitionSourceImageView
{
    if(_selectedItemIndexPath) {
        [NSException raise:@"Invalid operation - no valid item selected" format:@"Invalid operation - no valid item selected"];
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



#pragma mark - overwite gesture recognizer

// open project / new project:
- (void) handleTapGesture:(UITapGestureRecognizer*) gesture {
    if(gesture.state == UIGestureRecognizerStateEnded) {
        // open project workspace
        
        NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
        _selectedItemIndexPath = indexPath;
        
        // todo - check which cell was tapped
        if(indexPath.row < [_mainmenu.projects count]) {
            // load workspace
            [self performSegueWithIdentifier:@"workspaceSegue" sender:indexPath];
        } else {
            // new workspace
            [self performSegueWithIdentifier:@"newWorkspaceSegue" sender:indexPath];
        }
        
        
    }
    
}

// reorder cells:
- (void) handleLongGesture:(UILongPressGestureRecognizer*) gesture {
    
    switch(gesture.state) {
            
        case UIGestureRecognizerStateBegan: {
            
                NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
            
            
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
            }
            break;
       
        case UIGestureRecognizerStateChanged: {
            
                if(_mainmenu.dndIndex >= [_mainmenu.projects count]) {
                    break;
                }
                //NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
            
                // forbid item being last element ('+' always!!!)
                //if(indexPath && (indexPath.row < [_mainmenu.projects count])) {
                    [_menuGridCollectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
                //}
            }
            break;
        
        case UIGestureRecognizerStateEnded: {
            
                if(_mainmenu.dndIndex >= [_mainmenu.projects count]) {
                    break;
                }
            
                NSIndexPath *indexPath = [_menuGridCollectionView indexPathForItemAtPoint:[gesture locationInView:_menuGridCollectionView]];
            
                // forbid item being last element ('+' always!!!)
                if(indexPath && (indexPath.row < [_mainmenu.projects count])) {
                    NSLog(@"MainMenuViewController: dropped at new position");
                    _mainmenu.dndTarget = indexPath.row;
                    [_mainmenu reorderProjects];
                    [_menuGridCollectionView endInteractiveMovement];
                } else {
                    NSLog(@"MainMenuViewController: drag & drop canceled - invalid position");
                    [_menuGridCollectionView cancelInteractiveMovement];
                }
                _mainmenu.dndIndex=-1;
                _mainmenu.dndTarget=-1;
            
            }
            break;
        
        default:
            NSLog(@"MainMenuViewController: drag & drop canceled");
            [_menuGridCollectionView cancelInteractiveMovement];
            _mainmenu.dndIndex=-1;
            _mainmenu.dndTarget=-1;
            break;
    }
}

- (void) initGestureRecognizer {
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongGesture:)]
    ;
    [_menuGridCollectionView addGestureRecognizer:lpgr];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [_menuGridCollectionView addGestureRecognizer:tgr];
}

@end
