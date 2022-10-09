//
//  TISSwitch.m
//  TisComponent
//
//  Created by tanikawa on 2022/10/9.
//

#import "TISSwitch.h"
#import "TISHeader.h"
#import "TISButtonActivity.h"

CGFloat switch_width = 52;
CGFloat switch_height = 32;

@interface TISSwitch()
@property (nonatomic, strong) TISButtonActivity *activityIndicator;
@end

@implementation TISSwitch

- (instancetype)init {
    if (self = [super init]) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setUpView];
    }
    return self;
}

/// 创建视图
- (void)setUpView {
    [self addSubview:self.tisSwitch];
}

- (void)setIsLoading:(BOOL)isLoading {
    _isLoading = isLoading;
    [self setLoadingState:isLoading];
}

/// 设置是否loading
/// @param loading 是否
- (void)setLoadingState:(BOOL)loading {
    NSArray * sub1 = self.tisSwitch.subviews;
    UIImageView * onImg = nil;
    for (UIView * v1 in sub1) {
        NSArray * sub2 = v1.subviews;
        //iOS12在这里
        for (UIView * v2 in sub2) {
            if ([v2 isKindOfClass:UIImageView.class] && v2.frame.size.width == 43 && v2.frame.size.height == 43) {
                onImg = (UIImageView *)v2;
                break;
            }
            //iOS13在这里
            NSArray * sub3 = v2.subviews;
            for (UIView * v3 in sub3) {
                if ([v3 isKindOfClass:UIImageView.class] && v3.frame.size.width == 43 && v3.frame.size.height == 43) {
                    onImg = (UIImageView *)v3;
                    break;
                }
            }
        }
    }
    if (onImg) {
        if (loading) {
            if (!_activityIndicator) {
                [onImg addSubview:self.activityIndicator];
                [self.activityIndicator startAnimating];
                self.tisSwitch.enabled = NO;
            }
            self.activityIndicator.frame = CGRectMake(8, 5, 27, 27);
            self.activityIndicator.hidden = NO;
        } else {
            self.activityIndicator.hidden = YES;
            [self.activityIndicator stopAnimating];
            self.tisSwitch.enabled = YES;
        }
    }
}

- (void)setIsDisable:(BOOL)isDisable {
    _isDisable = isDisable;
    self.tisSwitch.enabled = !isDisable;
}

- (void)setSwithType:(SWITCH_TYPE)swithType {
    _swithType = swithType;
    CGFloat left = (self.frame.size.width-switch_width)/2>0 ? (self.frame.size.width-switch_width)/2 : 0;
    CGFloat top = (self.frame.size.height-switch_height)/2>0 ? (self.frame.size.height-switch_height)/2 : 0;
    switch (swithType) {
        case SWITCH_TITLE:
        {
            if (_titleLabel == nil) {
                [self addSubview:self.titleLabel];
            }
            self.descLabel.hidden = YES;
            self.titleLabel.frame = CGRectMake(20, top, self.frame.size.width - 20 * 3 - switch_width, switch_height);
            self.tisSwitch.frame = CGRectMake(self.frame.size.width - 20 - switch_width, top, switch_width, switch_height);
        }
            break;
        case SWITCH_DESC:
        {
            CGFloat width = (self.frame.size.width - 20 * 4 - switch_width) / 2;
            if (_titleLabel == nil) {
                [self addSubview:self.titleLabel];
            }
            self.titleLabel.frame = CGRectMake(20, top, width, switch_height);
            if (_descLabel == nil) {
                [self addSubview:self.descLabel];
            }
            self.descLabel.frame = CGRectMake(20 + width + 20, top, width, switch_height);
            self.tisSwitch.frame = CGRectMake(self.frame.size.width - 20 - switch_width, top, switch_width, switch_height);
            self.titleLabel.hidden = NO;
            self.descLabel.hidden = NO;
        }
            break;
        default:
        {
            self.tisSwitch.frame = CGRectMake(left, top, switch_width, switch_height);
            self.titleLabel.hidden = YES;
            self.descLabel.hidden = YES;
            
        }
            break;
    }
}



#pragma mark - 初始化

- (UISwitch *)tisSwitch {
    if (!_tisSwitch) {
        _tisSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, switch_width, switch_height)];
        _tisSwitch.onTintColor = COLOR_S5;
        _tisSwitch.backgroundColor = COLOR_M7;
        _tisSwitch.layer.cornerRadius = switch_height / 2;
        _tisSwitch.layer.masksToBounds = YES;
    }
    return _tisSwitch;
}

- (TISButtonActivity *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[TISButtonActivity alloc] init];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [self addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = COLOR_M2;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:16];
        _descLabel.textColor = COLOR_M5;
        _descLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descLabel;
}



@end
