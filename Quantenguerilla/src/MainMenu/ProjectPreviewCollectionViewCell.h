//
//  ProjectPreviewCollectionViewCell.h
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 27.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectPreviewCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *projectName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

@end
