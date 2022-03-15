//
//  TISMobilePhone.m
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/3/10.
//

#import "TISPhone.h"

static CGFloat SPACE_WIDTH = 20;

@implementation TISPhone

#pragma mark - 初始化

- (instancetype)init {
    self = [super init];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    return self;
}

- (void)layoutSubviews {
    self.viewFrame = self.frame;
    if (self.isCreatUI == NO) {
        [self creatUI];
    }
    self.isCreatUI = YES;
}



#pragma mark - 懒加载

- (UITextField *)mobileAreaTextFiled {
    if (!_mobileAreaTextFiled) {
        _mobileAreaTextFiled = [UITextField new];
        _mobileAreaTextFiled.keyboardType = UIKeyboardTypePhonePad;
        UIView *rightView = [self textFiledRightView];
        _mobileAreaTextFiled.rightView = rightView;
        _mobileAreaTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _mobileAreaTextFiled.delegate = self;
    }
    return _mobileAreaTextFiled;
}

- (UITextField *)mobileTextFiled {
    if (!_mobileTextFiled) {
        _mobileTextFiled = [UITextField new];
        _mobileTextFiled.keyboardType = UIKeyboardTypePhonePad;
        _mobileTextFiled.delegate = self;
    }
    return _mobileTextFiled;
}

- (UITextField *)landLineOneTextFiled {
    if (!_landLineOneTextFiled) {
        _landLineOneTextFiled = [UITextField new];
        _landLineOneTextFiled.keyboardType = UIKeyboardTypePhonePad;
        UIView *rightView = [self textFiledRightView];
        _landLineOneTextFiled.rightView = rightView;
        _landLineOneTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _landLineOneTextFiled.delegate = self;
    }
    return _landLineOneTextFiled;
}

- (UITextField *)landLineTwoTextFiled {
    if (!_landLineTwoTextFiled) {
        _landLineTwoTextFiled = [UITextField new];
        _landLineTwoTextFiled.keyboardType = UIKeyboardTypePhonePad;
        UIView *rightView = [self textFiledRightView];
        _landLineTwoTextFiled.rightView = rightView;
        _landLineTwoTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _landLineTwoTextFiled.delegate = self;
    }
    return _landLineTwoTextFiled;
}

- (UITextField *)landLineThreeTextFiled {
    if (!_landLineThreeTextFiled) {
        _landLineThreeTextFiled = [UITextField new];
        _landLineThreeTextFiled.keyboardType = UIKeyboardTypePhonePad;
        UIView *rightView = [self textFiledRightView];
        _landLineThreeTextFiled.rightView = rightView;
        _landLineThreeTextFiled.rightViewMode = UITextFieldViewModeAlways;
        _landLineThreeTextFiled.delegate = self;
    }
    return _landLineThreeTextFiled;
}

- (UITextField *)landLineFourTextFiled {
    if (!_landLineFourTextFiled) {
        _landLineFourTextFiled = [UITextField new];
        _landLineFourTextFiled.keyboardType = UIKeyboardTypePhonePad;
        _landLineFourTextFiled.delegate = self;
    }
    return _landLineFourTextFiled;
}

- (UIView *)textFiledRightView {
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SPACE_WIDTH, self.viewFrame.size.height)];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SPACE_WIDTH, self.viewFrame.size.height)];
    lineLabel.text = @"-";
    lineLabel.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:lineLabel];
    return rightView;
}



#pragma mark - 方法

- (void)creatUI {
    if (self.phoneType == MOBILE_PHONE) {
        [self addSubview:self.mobileAreaTextFiled];
        [self addSubview:self.mobileTextFiled];
    } else {
        [self addSubview:self.landLineOneTextFiled];
        [self addSubview:self.landLineTwoTextFiled];
        [self addSubview:self.landLineThreeTextFiled];
        [self addSubview:self.landLineFourTextFiled];
    }
}

- (void)setViewFrame:(CGRect)viewFrame {
    _viewFrame = viewFrame;
    CGFloat height = _viewFrame.size.height;
    // 设置移动手机号位置
    CGFloat width = (_viewFrame.size.width - SPACE_WIDTH) / 4;
    self.mobileAreaTextFiled.frame = CGRectMake(0, 0, width + SPACE_WIDTH, height);
    self.mobileTextFiled.frame = CGRectMake(width + SPACE_WIDTH, 0, width * 3, height);
    // 设置固话输入框位置
    CGFloat landWidth = (_viewFrame.size.width - SPACE_WIDTH * 3) / 22;
    self.landLineOneTextFiled.frame = CGRectMake(0, 0, landWidth * 4 + SPACE_WIDTH, height);
    self.landLineTwoTextFiled.frame = CGRectMake(self.landLineOneTextFiled.frame.size.width, 0, self.landLineOneTextFiled.frame.size.width, height);
    self.landLineThreeTextFiled.frame = CGRectMake(self.landLineTwoTextFiled.frame.size.width + self.landLineTwoTextFiled.frame.origin.x, 0, landWidth * 8 + SPACE_WIDTH, height);
    self.landLineFourTextFiled.frame = CGRectMake(self.landLineThreeTextFiled.frame.size.width + self.landLineThreeTextFiled.frame.origin.x, 0, landWidth * 6 + SPACE_WIDTH, height);
}

- (void)setPhoneType:(PHONE_TYPE)phoneType {
    _phoneType = phoneType;
    if (_phoneType == MOBILE_PHONE) {
        [self.landLineOneTextFiled removeFromSuperview];
        [self.landLineTwoTextFiled removeFromSuperview];
        [self.landLineThreeTextFiled removeFromSuperview];
        [self.landLineFourTextFiled removeFromSuperview];
    } else {
        [self.mobileTextFiled removeFromSuperview];
        [self.mobileAreaTextFiled removeFromSuperview];
        _mobileTextFiled = nil;
        _mobileAreaTextFiled = nil;
    }
}



#pragma mark - UITextfiled 代理方法

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(nonnull NSString *)string {
    // 删除操作
    if ([string isEqualToString:@""]) {
        self.isDeleteStr = YES;
        self.currentTextRange = textField.selectedTextRange;
        return YES;
    }
    NSMutableString *spaceMutableText = [[NSMutableString alloc] initWithString:textField.text];
    [spaceMutableText insertString:string atIndex:range.location];
    
    // 区号
    if (textField==self.mobileAreaTextFiled && spaceMutableText.length>4) {
        return NO;
    }
    
    // 手机号
    if (textField == self.mobileTextFiled) {
        if (spaceMutableText.length > 13) {
            return NO;
        }
    }
    
    // 固话第一区
    if (textField==self.landLineOneTextFiled && spaceMutableText.length>4) {
        return NO;
    }
    
    // 固话第二区
    if (textField==self.landLineTwoTextFiled && spaceMutableText.length>4) {
        return NO;
    }
    
    // 固话第三区
    if (textField==self.landLineThreeTextFiled && spaceMutableText.length>8) {
        return NO;
    }
    
    // 固话第四区
    if (textField==self.landLineFourTextFiled && spaceMutableText.length>6) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
//    if (textField == self.mobileAreaTextFiled) {
//        if (textField.text.length == 4) {
//            [textField resignFirstResponder];
//            [self.mobileTextFiled becomeFirstResponder];
//        }
//    }
    if (textField == self.mobileTextFiled) {
        NSString *noSpaceText = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableString *spaceMutableText = [[NSMutableString alloc] initWithString:noSpaceText];
        if (spaceMutableText.length >= 3) {
            [spaceMutableText insertString:@" " atIndex:3];
        }
        if (spaceMutableText.length >= 8) {
            [spaceMutableText insertString:@" " atIndex:8];
        }
        textField.text = spaceMutableText;
        if (self.isDeleteStr == YES) {
            UITextRange *selectedRange = self.currentTextRange;
            NSInteger currentOffset = [textField offsetFromPosition:textField.endOfDocument toPosition:selectedRange.end];
            currentOffset -= 1;
            UITextPosition *newPos = [textField positionFromPosition:textField.endOfDocument offset:currentOffset];
            textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
        }
        self.isDeleteStr = NO;
    }
}

@end 
