//
//  TISHorButtonCollectionViewCell.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISHorButtonCollectionViewCell.h"
#import "TISHeader.h"

@implementation TISHorButtonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.backgroundColor = COLOR_S1;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.closeImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_button_close")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_button_close")];
}

@end
