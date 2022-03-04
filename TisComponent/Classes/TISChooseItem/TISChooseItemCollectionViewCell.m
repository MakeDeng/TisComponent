//
//  TISChooseItemCollectionViewCell.m
//  TisComponent
//
//  Created by tanikawa on 2022/3/2.
//

#import "TISChooseItemCollectionViewCell.h"
#import "TISTool.h"

@implementation TISChooseItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.itemLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:self.itemLabel];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        _itemLabel.textColor = [TISTool tisColorWithHex:@"1f6cdd"];
        _itemLabel.layer.borderColor = [[TISTool tisColorWithHex:@"1f6cdd"] colorWithAlphaComponent:0.5].CGColor;
    } else {
        _itemLabel.textColor = [UIColor blackColor];
        _itemLabel.layer.borderColor = [[TISTool tisColorWithHex:@"1f6cdd"] colorWithAlphaComponent:0.1].CGColor;
    }
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [UILabel new];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        _itemLabel.font = [UIFont systemFontOfSize:14];
        _itemLabel.backgroundColor = [[TISTool tisColorWithHex:@"1f6cdd"] colorWithAlphaComponent:0.1];
        _itemLabel.layer.borderColor = [[TISTool tisColorWithHex:@"1f6cdd"] colorWithAlphaComponent:0.1].CGColor;
        _itemLabel.layer.borderWidth = 0.5;
        _itemLabel.layer.cornerRadius = 3;
        _itemLabel.layer.masksToBounds = YES;
    }
    return _itemLabel;
}

@end
