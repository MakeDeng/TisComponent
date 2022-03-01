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
    self.bgView.backgroundColor = [[TISTool tisColorWithHex:@"#e8e8e8"] colorWithAlphaComponent:0.3];
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.borderWidth = 0.5;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = [[TISTool tisColorWithHex:@"#1f6cdd"] colorWithAlphaComponent:0.8].CGColor;
    self.closeImageView.image = [UIImage imageNamed:TISCommonSrcName(@"button_close")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"button_close")];
}

@end
