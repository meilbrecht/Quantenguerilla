//
//  FingerboardContainerView.m
//  Quantenguerilla
//
//  Created by Marius Eilbrecht on 17.07.17.
//  Copyright © 2017 Marius Eilbrecht. All rights reserved.
//

#import "FingerboardContainerView.h"

@implementation FingerboardContainerView

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    //    if (self) {
    //        [self initializeSubviews];
    //    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //    if (self) {
    //        [self initializeSubviews];
    //    }
    return self;
}

-(void)initializeSubviews {
    UIView* view = [[[NSBundle mainBundle] loadNibNamed:@"FingerboardContainerView" owner:self options:nil] firstObject];
    view.frame = self.bounds;
    [self addSubview:view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
