//
//  TISMobilePhone.h
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PHONE_TYPE) {
    MOBILE_PHONE,   // 移动手机号（默认）
    LAND_LINE,      // 座机
};

@interface TISPhone : UIView <UITextFieldDelegate>

@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, assign) BOOL isCreatUI; // 是否已经创建过视图了
@property (nonatomic, assign) PHONE_TYPE phoneType; // 号码类型

@property (nonatomic, strong) UITextField *mobileAreaTextFiled; // 区号
@property (nonatomic, strong) UITextField *mobileTextFiled; // 手机号
@property (nonatomic, strong) UITextRange *currentTextRange; // 当前光标range
@property (nonatomic, assign) BOOL isDeleteStr; // 是否是删除字符

@property (nonatomic, strong) UITextField *landLineOneTextFiled; // 座机第一部分
@property (nonatomic, strong) UITextField *landLineTwoTextFiled; // 座机第二部分
@property (nonatomic, strong) UITextField *landLineThreeTextFiled; // 座机第三部分
@property (nonatomic, strong) UITextField *landLineFourTextFiled; // 座机第四部分

@end

NS_ASSUME_NONNULL_END
