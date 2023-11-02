//
//  TISRadio.m
//  TisComponent
//
//  Created by tanikawa on 2022/6/20.
//

#import "TISRadio.h"
#import "TISHeader.h"

@implementation TISRadio

@synthesize normal_image = _normal_image;
@synthesize selected_image = _selected_image;
@synthesize disable_normal_image = _disable_normal_image;
@synthesize disable_selected_image = _disable_selected_image;

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


- (void)setUpView {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.radioButton];
}

- (void)layoutSubviews {
    CGFloat space = 10; // radio图标和文字之间的间距
    if (self.textWidth + self.imageView.frame.size.width + space > TIS_Screen_Width - 20) {
        // 超出屏幕
        self.frame = CGRectMake(10, self.frame.origin.y, TIS_Screen_Width - 20, self.frame.size.height);
        self.textWidth = TIS_Screen_Width - 20 - self.imageView.frame.size.width - space;
    } else {
        // 未超出屏幕
        if (self.textWidth + self.imageView.frame.size.width + space > self.frame.size.width) {
            // 超出父组件
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.textWidth + self.imageView.frame.size.width + space, self.frame.size.height);
        } else {
            // 未超出父组件
            CGFloat aroundSpace = (self.frame.size.width - self.imageView.frame.size.width - space - self.textWidth) / 2;
            self.imageView.frame = CGRectMake(aroundSpace, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
            self.titleLabel.frame = CGRectMake(self.frame.size.width - self.textWidth - aroundSpace, 0, self.textWidth, 20);
            self.imageView.center = CGPointMake(self.imageView.center.x, self.frame.size.height / 2);
            self.titleLabel.center = CGPointMake(self.titleLabel.center.x, self.frame.size.height / 2);
            self.radioButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
    }
}

- (void)setText:(NSString *)text {
    _text = text;
    self.titleLabel.text = text;
    self.textWidth = [TISTool tisGetLabelWidth:self.titleLabel size:CGSizeMake(MAXFLOAT,20)];
    [self layoutSubviews];
}

- (void)setStatus:(RADIO_STATE)status {
    _status = status;
    switch (status) {
        case RADIO_NORMAL:
            self.imageView.image = self.normal_image;
            self.titleLabel.textColor = COLOR_M2;
            self.radioButton.enabled = YES;
            break;
        case RADIO_SELECTED:
            self.imageView.image = self.selected_image;
            self.titleLabel.textColor = COLOR_M2;
            self.radioButton.enabled = YES;
            break;
        case RADIO_DISABLE_NORMAL:
            self.imageView.image = self.disable_normal_image;
            self.titleLabel.textColor = COLOR_M5;
            self.radioButton.enabled = NO;
            break;
        case RADIO_DISABLE_SELECTED:
            self.imageView.image = self.disable_selected_image;
            self.titleLabel.textColor = COLOR_M5;
            self.radioButton.enabled = NO;
            break;
        default:
            self.imageView.image = self.normal_image;
            self.titleLabel.textColor = COLOR_M2;
            self.radioButton.enabled = YES;
            break;
    }
}

- (void)setRadioSize:(RADIO_SIZE)radioSize {
    _radioSize = radioSize;
    if (radioSize == RADIO_LARGE) {
        self.imageView.bounds = CGRectMake(0, 0, 18, 18);
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    } else {
        self.imageView.bounds = CGRectMake(0, 0, 16, 16);
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    self.textWidth = [TISTool tisGetLabelWidth:self.titleLabel size:CGSizeMake(MAXFLOAT,20)];
    [self layoutSubviews];
}

- (void)setNormal_image:(UIImage *)normal_image {
    _normal_image = normal_image;
    self.status = self.status;
}

- (void)setSelected_image:(UIImage *)selected_image {
    _selected_image = selected_image;
    self.status = self.status;
}

- (void)setDisable_normal_image:(UIImage *)disable_normal_image {
    _disable_normal_image = disable_normal_image;
    self.status = self.status;
}

- (void)setDisable_selected_image:(UIImage *)disable_selected_image {
    _disable_selected_image = disable_selected_image;
    self.status = self.status;
}

/**
 *  按钮点击事件
 */
- (void)readioButtonClicked {
    if (self.status == RADIO_NORMAL) {
        self.status = RADIO_SELECTED;
        self.imageView.image = self.selected_image;
    }else if (self.status == RADIO_SELECTED) {
        self.status = RADIO_NORMAL;
        self.imageView.image = self.normal_image;
    }
}

#pragma mark - 初始化

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = self.normal_image;
        _imageView.bounds = CGRectMake(0, 0, 18, 18);
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = COLOR_M2;
    }
    return _titleLabel;
}

- (UIButton *)radioButton {
    if (!_radioButton) {
        _radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_radioButton addTarget:self action:@selector(readioButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _radioButton;
}

- (UIImage *)normal_image {
    if (!_normal_image) {
        _normal_image = [UIImage imageNamed:TISCommonSrcName(@"tis_checkbox_normal")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_checkbox_normal")];
    }
    return _normal_image;
}

- (UIImage *)selected_image {
    if (!_selected_image) {
        _selected_image = [UIImage imageNamed:TISCommonSrcName(@"tis_checkbox_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_checkbox_selected")];
    }
    return _selected_image;
}

- (UIImage *)disable_normal_image {
    if (!_disable_normal_image) {
        _disable_normal_image = [UIImage imageNamed:TISCommonSrcName(@"tis_checkbox_normal_disable")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_checkbox_normal_disable")];
    }
    return _disable_normal_image;
}

- (UIImage *)disable_selected_image {
    if (!_disable_selected_image) {
        _disable_selected_image = [UIImage imageNamed:TISCommonSrcName(@"tis_checkbox_selected_disable")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_checkbox_selected_disable")];
    }
    return _disable_selected_image;
}

@end
