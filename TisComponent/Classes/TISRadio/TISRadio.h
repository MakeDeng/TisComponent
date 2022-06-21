//
//  TISRadio.h
//  TisComponent
//
//  Created by tanikawa on 2022/6/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RADIO_STATE) {
    RADIO_NORMAL,            // 正常显示状态
    RADIO_SELECTED,          // 选中状态
    RADIO_DISABLE_NORMAL,    // 正常失效状态
    RADIO_DISABLE_SELECTED,  // 选中失效状态
};

typedef NS_ENUM(NSInteger, RADIO_SIZE) {
    RADIO_LARGE,    // 大尺寸
    RADIO_SMALL,    // 小尺寸
};

@interface TISRadio : UIView

@property (nonatomic, assign) RADIO_STATE status; // 选择框当前状态
@property (nonatomic, assign) RADIO_SIZE radioSize; // radio尺寸，大或小，默认大尺寸
@property (nonatomic, copy) void (^TISRadioBlock)(TISRadio *);
@property (nonatomic, strong) UIImageView *imageView; // radio图标
@property (nonatomic, strong) UILabel *titleLabel; // radio标题label
@property (nonatomic, strong) UIButton *radioButton; // 整个radio点击button
@property (nonatomic, copy) NSString *text; // radio标题
@property (nonatomic, assign) CGFloat textWidth; // radio标题宽度
@property (nonatomic, strong) UIImage *normal_image; // 未选中icon图片
@property (nonatomic, strong) UIImage *selected_image; // 已选中icon图片
@property (nonatomic, strong) UIImage *disable_normal_image; // 未选中失效状态icon图片
@property (nonatomic, strong) UIImage *disable_selected_image; // 已选中失效状态icon图片

@end

NS_ASSUME_NONNULL_END
