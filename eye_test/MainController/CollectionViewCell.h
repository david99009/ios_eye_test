//
//  CollectionViewCell.h
//  eye_test
//
//  Created by lam hung fat on 2/7/2017.
//  Copyright © 2017年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *viewColors;
- (void)setcolors:(UIColor*)color;
@end
