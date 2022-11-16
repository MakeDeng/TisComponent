//
//  TISLoading.m
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/10/20.
//

#import "TISLoading.h"
#import "TISHeader.h"

CGFloat activityNormal = 40;
CGFloat activitySmall = 24;
CGFloat loadingLabelWidth = 65;
CGFloat pointNormal = 10;
CGFloat pointSmall = 8;

@implementation TISLoading

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.activityIndicator];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.activityIndicator];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self addSubview:self.activityIndicator];
    }
    return self;
}

- (void)setLoadingType:(LOADING_TYPE)loadingType {
    _loadingType = loadingType;
    switch (loadingType) {
        case LOADING_NORMAL:
        {
            self.activityIndicator.frame = CGRectMake(0, 0, activityNormal, activityNormal);
            [self setActivitySize:activityNormal];
        }
            break;
        case LOADING_NORMAL_HORRIZONTAL:
        {
            self.activityIndicator.frame = CGRectMake(0, 0, activityNormal, activityNormal);
            [self setActivitySize:activityNormal];
            self.loadingLabel.frame = CGRectMake(activityNormal + 4, 0, loadingLabelWidth, activityNormal);
        }
            break;
        case LOADING_NORMAL_VERTICALL:
        {
            self.activityIndicator.frame = CGRectMake((self.frame.size.width - activityNormal) / 2, 0, activityNormal, activityNormal);
            [self setActivitySize:activityNormal];
            self.loadingLabel.frame = CGRectMake((self.frame.size.width - loadingLabelWidth) / 2, activityNormal + 8, loadingLabelWidth, activityNormal);
        }
            break;
        case LOADING_POINT:
        {
            [self.activityIndicator removeFromSuperview];
            if (self.loadingSize == LOADING_SIZE_NORMAL) {
                self.pointLoading.frame = CGRectMake((self.frame.size.width - pointNormal * 5) / 2, (self.frame.size.height - pointNormal) / 2, pointNormal * 5, pointNormal);
            } else {
                self.pointLoading.frame = CGRectMake((self.frame.size.width - pointSmall * 5) / 2, (self.frame.size.height - pointSmall) / 2, pointSmall * 5, pointSmall);
            }
            [self startLoading];
        }
            break;
        case LOADING_PROGRESS:
        {
            [self.activityIndicator removeFromSuperview];
            self.progress.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
            break;
        default:
            break;
    }
}

- (void)setLoadingSize:(LOADING_SIZE)loadingSize {
    _loadingSize = loadingSize;
    switch (loadingSize) {
        case LOADING_SIZE_NORMAL:
        {
            if (self.loadingType == LOADING_POINT) {
                self.pointLoading.frame = CGRectMake((self.frame.size.width - pointNormal * 5) / 2, (self.frame.size.height - pointNormal) / 2, pointNormal * 5, pointNormal);
                [self setPointSize:pointNormal];
            } else {
                self.activityIndicator.frame = CGRectMake(0, 0, activityNormal, activityNormal);
                [self setActivitySize:activityNormal];
            }
        }
            break;
        case LOADING_SIZE_SMALL:
        {
            if (self.loadingType == LOADING_POINT) {
                self.pointLoading.frame = CGRectMake((self.frame.size.width - pointSmall * 5) / 2, (self.frame.size.height - pointSmall) / 2, pointSmall * 5, pointSmall);
                [self setPointSize:pointSmall];
            } else {
                self.activityIndicator.frame = CGRectMake(0, 0, activitySmall, activitySmall);
                [self setActivitySize:activitySmall];
            }
        }
            break;
        default:
            break;
    }
    if (self.loadingType == LOADING_NORMAL_HORRIZONTAL) {
        self.loadingLabel.frame = CGRectMake(self.activityIndicator.frame.size.width + 4, 0, loadingLabelWidth, self.activityIndicator.frame.size.height);
    }
    if (self.loadingType == LOADING_NORMAL_VERTICALL) {
        self.activityIndicator.frame = CGRectMake((self.frame.size.width - self.activityIndicator.frame.size.width) / 2, 0, self.activityIndicator.frame.size.width, self.activityIndicator.frame.size.height);
        [self setActivitySize:self.activityIndicator.frame.size.height];
        self.loadingLabel.frame = CGRectMake((self.frame.size.width - loadingLabelWidth) / 2, self.activityIndicator.frame.size.height + 8, loadingLabelWidth, 20);
    }
}

// 设置菊花大小
- (void)setActivitySize:(CGFloat)size {
    self.activityIndicator.bounds = CGRectMake(0, 0, 20, 20);
    if (size == activityNormal) {
        CGAffineTransform transform = CGAffineTransformMakeScale(2.0, 2.0);
        self.activityIndicator.transform = transform;
    } else {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.activityIndicator.transform = transform;
    }
}

// 三个点loading开始动画
- (void)startLoading {
    for (int i=0; i<3; i++) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //动画重复次数
        animation.repeatCount = HUGE_VALF;
        //动画开始时间
        animation.beginTime = CACurrentMediaTime();
        //是否自动执行逆动画
        animation.autoreverses = YES;
        //动画执行完后会回到初始状态，需要设置这两个属性
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        switch (i) {
            case 0:
            {
                //动画时长
                animation.duration = 0.5;
                //设置动画初始位置
                animation.fromValue = [NSNumber numberWithFloat: 0.7];
                //设置动画目的位置
                animation.toValue = [NSNumber numberWithFloat: 1.2];
            }
                break;
            case 1:
            {
                //动画时长
                animation.duration = 0.4;
                //设置动画初始位置
                animation.fromValue = [NSNumber numberWithFloat: 0.9];
                //设置动画目的位置
                animation.toValue = [NSNumber numberWithFloat: 1.1];
            }
                break;
            case 2:
            {
                //动画时长
                animation.duration = 0.5;
                //设置动画初始位置
                animation.fromValue = [NSNumber numberWithFloat: 1.2];
                //设置动画目的位置
                animation.toValue = [NSNumber numberWithFloat: 0.7];
            }
                break;
            default:
                break;
        }
        //添加动画
        CALayer *pointLayer = self.pointLoading.layer.sublayers[i];
        [pointLayer addAnimation:animation forKey:[NSString stringWithFormat:@"animation-layer-%d", i]];
    }
}

// 三个点loading结束动画
- (void)endLoading {
    for (int i=0; i<3; i++) {
        CALayer *pointLayer = self.pointLoading.layer.sublayers[i];
        [pointLayer removeAnimationForKey:[NSString stringWithFormat:@"animation-layer-%d", i]];
    }
}

// 设置三个点loading尺寸
- (void)setPointSize:(CGFloat)pointSize {
    NSArray *pointArray = self.pointLoading.layer.sublayers;
    for (int i=0; i<pointArray.count; i++) {
        CALayer *pointLayer = pointArray[i];
        pointLayer.cornerRadius = pointSize / 2;
        pointLayer.masksToBounds = YES;
        pointLayer.frame = CGRectMake(pointSize*2*i, 0, pointSize, pointSize);
    }
}



#pragma mark - 初始化

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] init];
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activityIndicator.color = COLOR_M4;
        [self setActivitySize:activityNormal];
        [_activityIndicator startAnimating];
    }
    return _activityIndicator;
}

- (UILabel *)loadingLabel {
    if (!_loadingLabel) {
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.text = @"加载中...";
        _loadingLabel.textColor = COLOR_M4;
        _loadingLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_loadingLabel];
    }
    return _loadingLabel;
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] init];
        //设置进度条风格颜色
        _progress.progressTintColor = COLOR_S5;
        //设置进度条剩余的进度颜色
        _progress.trackTintColor = COLOR_M8;
        //设置进度条的风格特征
        _progress.progressViewStyle = UIProgressViewStyleBar;
        [self addSubview:_progress];
    }
    return _progress;
}

- (UIView *)pointLoading {
    if (!_pointLoading) {
        _pointLoading = [[UIView alloc] init];
        NSArray *pointArray = @[COLOR_S4, COLOR_CYAN_4, COLOR_ORANGE_4];
        for (int i=0; i<pointArray.count; i++) {
            CALayer *pointLayer = [[CALayer alloc] init];
            pointLayer.name = [NSString stringWithFormat:@"point%d", i];
            pointLayer.frame = CGRectMake(pointNormal*2*i, 0, pointNormal, pointNormal);
            UIColor *pointColor = pointArray[i];
            pointLayer.backgroundColor = pointColor.CGColor;
            pointLayer.cornerRadius = pointNormal / 2;
            pointLayer.masksToBounds = YES;
            [_pointLoading.layer addSublayer:pointLayer];
        }
        [self addSubview:_pointLoading];
    }
    return _pointLoading;
}




@end
