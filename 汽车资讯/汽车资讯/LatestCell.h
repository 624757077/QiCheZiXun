//
//  LatestCell.h
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LatestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *commentLb;

@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@end
