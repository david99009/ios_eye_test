//
//  CollectionViewCell.m
//  eye_test
//
//  Created by lam hung fat on 2/7/2017.
//  Copyright © 2017年 com. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
@synthesize viewColors;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setcolors:(UIColor*)color
{
    viewColors.backgroundColor = color;
}

@end
