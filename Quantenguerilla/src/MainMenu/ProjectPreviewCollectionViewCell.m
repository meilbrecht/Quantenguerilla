//
//  ProjectPreviewCollectionViewCell.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 27.04.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "ProjectPreviewCollectionViewCell.h"

@implementation ProjectPreviewCollectionViewCell


// Lazy loading of the imageView
- (UIImageView *) imageView {
    if (!_imageView) {
//        CGFloat x = self.frame.origin.x+64;
//        CGFloat y = self.frame.origin.y+20;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(33,20,264,198)];//(64, 20, 264, 198)];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel*) projectName {
    if (!_projectName) {
//        CGFloat x = self.frame.origin.x+20;
//        CGFloat y = self.frame.origin.y+226;
        _projectName = [[UILabel alloc] initWithFrame:CGRectMake(33,226,264,48)];//(20, 226, 352, 48)];
        _projectName.textAlignment = NSTextAlignmentCenter;
        _projectName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_projectName];
    }
    return _projectName;
}

// Here we remove all the custom stuff that we added to our subclassed cell
-(void)prepareForReuse {
    [super prepareForReuse];
    
    [_imageView removeFromSuperview];
    [_projectName removeFromSuperview];
    _imageView = nil;
    _projectName = nil;
}

@end
