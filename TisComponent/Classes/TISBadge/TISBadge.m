//
//  TISBadge.m
//  Pods
//
//  Created by tanikawa on 2022/12/23.
//

#import "TISBadge.h"
#import "TISHeader.h"

@implementation TISBadge

/// 显示通知栏
/// @param type 徽标类型
/// @param text 自定义徽标文字
+ (instancetype)badge:(BADGE_TYPE)type text:(nullable NSString *)text {
    TISBadge *badge = [[TISBadge alloc] init];
    switch (type) {
        case BADGE_POINT:
        {
            badge.frame = CGRectMake(0, 0, 8, 8);
            badge.textLabel.frame = CGRectMake(0, 0, badge.frame.size.width, badge.frame.size.height);
            badge.textLabel.layer.cornerRadius = 4;
            badge.textLabel.layer.masksToBounds = YES;
        }
            break;
        case BADGE_NUMBER:
        {
            badge.frame = CGRectMake(0, 0, 16, 16);
            badge.textLabel.frame = CGRectMake(0, 0, badge.frame.size.width, badge.frame.size.height);
            badge.textLabel.layer.cornerRadius = 8;
            badge.textLabel.layer.masksToBounds = YES;
            badge.textLabel.text = text;
            if (text != nil) {
                if ([text floatValue] > 99) {
                    badge.textLabel.text = @"99+";
                }
                CGFloat width = [TISTool tisGetLabelWidth:badge.textLabel size:CGSizeMake(MAXFLOAT,20)] + 8;
                badge.frame = CGRectMake(0, 0, width, 16);
                badge.textLabel.frame = CGRectMake(0, 0, badge.frame.size.width, badge.frame.size.height);
            }
        }
            break;
        case BADGE_DIY:
        {
            badge.frame = CGRectMake(0, 0, 16, 16);
            badge.textLabel.frame = CGRectMake(0, 0, badge.frame.size.width, badge.frame.size.height);
            badge.textLabel.layer.cornerRadius = 8;
            badge.textLabel.layer.masksToBounds = YES;
            if (text != nil) {
                CGFloat width = [TISTool tisGetLabelWidth:badge.textLabel size:CGSizeMake(MAXFLOAT,20)] + 8;
                badge.frame = CGRectMake(0, 0, width, 16);
                badge.textLabel.frame = CGRectMake(0, 0, badge.frame.size.width, badge.frame.size.height);
            }
        }
            break;
        default:
            break;
    }
    
    return badge;
}

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.textLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self addSubview:self.textLabel];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = COLOR_RED_5;
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
