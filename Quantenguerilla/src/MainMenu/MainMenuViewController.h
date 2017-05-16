//
//  MainMenuViewController.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 26.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenu.h"
#import "RMPZoomTransitionAnimator.h"
#import "NewWorkspaceViewController.h"

@interface MainMenuViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, NewWorkspaceDelegate, RMPZoomTransitionAnimating>

@property (strong, nonatomic) MainMenu *mainmenu;
@property (strong, nonatomic) IBOutlet UICollectionView *menuGridCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic) NSIndexPath *selectedItemIndexPath;
@property (nonatomic) boolean_t bEditMode;


- (IBAction)editButtonPressed:(id)sender;
- (void) handleLongGesture:(UILongPressGestureRecognizer*) gesture;

@end

