//
//  TISTool.h
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/23.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISTool : NSObject

#pragma mark - 判断字符串是否为空

/**
 *  判断字符串是否为空
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckIsNull:(NSString *)string;



#pragma mark - 正则验证及判断相关

/**
 *  判断是否是手机号(只限制11位总位数和第一位是1)
 *
 *  @param string 传入的手机号
 */
+ (BOOL)tisCheckTelNumber:(NSString *)string;

/**
 *  判断是否是有效的身份证号
 *
 *  @param string 传入的身份证号
 */
+ (BOOL)tisCheckIDCardNumber:(NSString *)string;

/**
 *  判断是否是有效的邮箱
 *
 *  @param string 传入的邮箱
 */
+ (BOOL)tisCheckEmail:(NSString *)string;

/**
 *  判断字符串是否包含另一个字符串
 *
 *  @param string 传入的字符串
 *  @param str    是否包含的字符串
 */
+ (BOOL)tisCheckContainString:(NSString *)string str:(NSString *)str;

/**
 *  判断是否包含特殊字符
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckContainSpecial:(NSString *)string;

/**
 *  判断是否是6-20位字母和数字组合
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckContainNumberWithLetter:(NSString *)string;

/**
 *  判断是否是中文
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckIsChinese:(NSString *)string;



#pragma mark - 字符串实用方法

/**
 *  中间几数位用指定字符加密
 *
 *  @param string   传入的字符串
 *  @param str      指定的字符
 *  @param minIndex 加密起始位置
 *  @param maxIndex 加密结束位置
 */
+ (NSString *)tisSetSecret:(NSString *)string str:(NSString *)str min:(NSInteger)minIndex max:(NSInteger)maxIndex;

/**
 *  获取某个字符串或者汉字的首字母
 */
+ (NSString *)tisFirstCharactor:(NSString *)string;

/**
 *  将汉字转换为拼音
 *  chinese 汉字
 */
+ (NSString *)tisTransformChineseToPinyin:(NSString *)chinese;



#pragma mark - UILabel相关

/**
 *  获取label所设文字不折行显示宽度(需先设置文字)
 *
 *  @param label 要设置的label
 *  @param size  label可占最大宽高如：(MAXFLOAT,20)
 *
 *  @return 获取的宽度
 */
+ (CGFloat)tisGetLabelWidth:(UILabel *)label size:(CGSize)size;

/**
 *  获取label所设文字高度(需先设置文字)
 *
 *  @param label 要设置的label
 *  @param size  label可占最大宽高如：(80, MAXFLOAT)
 *
 *  @return 获取的高度
 */
+ (CGFloat)tisGetLabelHeight:(UILabel *)label size:(CGSize)size;

/**
 *  label文字显示不同颜色
 *
 *  @param string    lable显示的文本
 *  @param str       要改变颜色的文字
 *  @param lable     要设置的lable
 *  @param textColor 要改变的部分文字的颜色
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str theLable:(UILabel *)lable theColor:(UIColor *)textColor;

/**
 *  label文字显示不同字号
 *
 *  @param string   lable显示的文本
 *  @param str      要改变字号的文字
 *  @param lable    要设置的lable
 *  @param textFont 要改变的部分文字的字号
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str lable:(UILabel *)lable theFont:(UIFont *)textFont;

/**
 *  label文字显示不同字号及颜色
 *
 *  @param string    lable显示的文本
 *  @param str       要改变字号的文字
 *  @param lable     要设置的lable
 *  @param textFont  要改变的部分文字的字号
 *  @param textColor 要改变的部分文字的颜色
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str lable:(UILabel *)lable theFont:(UIFont *)textFont theColor:(UIColor *)textColor;

/**
 *  调整行间距(需先设置文字)
 *
 *  @param lable 要设置的lable
 *  @param space 要设置的行间距
 */
+ (void)tisSetLineSpace:(UILabel *)lable space:(CGFloat)space;



#pragma mark - 颜色相关

/**
 *  将十六进制颜色转换为UIColor对象
 *
 *  @param color 要转换的十六进制字符串
 *
 *  @return 转换的颜色
 */
+ (UIColor *)tisColorWithHex:(NSString *)hexString;



#pragma mark - 网络相关

/**
 *  获得当前外网的IP地址
 */
+ (NSString*)tisGetWlanIpAdress;

/**
 *  判断是否是url
 */
+ (BOOL)tisCheckIsUrl:(NSString *)url;

/**
 *  将url地址后拼接的参数转换为NSMutableDictionary对象
 *
 *  @param url 带参数的url地址
 *
 *  @return 获取的参数字典
 */
+ (NSMutableDictionary *)tisGetUrlParams:(NSString*)url;



#pragma mark - 本地存储相关

/**
 *  将数组存入本地
 
 *  @param array 要存入的数组
 *  @param path 保存的文件名称
 */
+ (void)tisSaveArray:(NSArray *)array path:(NSString *)path;

/**
 *  根据文件名称将保存的数组从本地取出
 *
 *  @param path 保存文件的名称
 *
 *  @return 取出的数组
 */
+ (NSArray *)tisGetArrayWithPath:(NSString *)path;



#pragma mark - 权限相关

/**
 *  判断是否开启相册权限
 */
+ (BOOL)tisPhotoServiceOpen;

/**
 *  判断是否开启相机权限
 */
+ (BOOL)tisCameroServiceOpen;



#pragma mark - 图片相关

/**
 *  按图片质量等比例压缩图片
 *
 *  @param image   要压缩的图片
 *  @param quality 压缩质量 0 - 1
 *
 *  @return 取出的数组
 */
+ (UIImage *)tisCompressImage:(UIImage *)image quality:(CGFloat)quality;

/**
 *  等比例压缩图片
 *
 *  @param image 要压缩的图片
 */
+ (UIImage *)tisCompressImage:(UIImage *)image;



#pragma mark - 浮点型数据处理

/**
 *  不四舍五入保留指定位数小数
 *
 *  @param number   需要处理的数字
 *  @param position 保留小数点第几位
 */
+ (NSString *)tisNotRounding:(float)number afterPoint:(int)position;



#pragma mark - 加密相关

/**
 *  sha1加密
 *
 *  @param string 要加密的字符串
 */
+ (NSString*)tisSha1Secret:(NSString *)string;

/**
 *  MD5加密
 *
 *  @param string 要加密的字符串
 */
+ (NSString *)tisMD5Secret:(NSString *)string;

/**
 *  base64加密
 *
 *  @param string 要加密的字符串
 */
+ (NSString *)tisBase64EncodeString:(NSString *)string;

/**
 *  base64解密
 *
 *  @param string 要解密的字符串
 */
+ (NSString *)tisBase64DecodeString:(NSString *)string;



#pragma mark - 时间相关

/**
 *  获取当前日期的 年/月/日/时/分/秒 中的单个数值
 *
 *  @param type 0:年，1:月，2:日，3:时，4:分，5:秒
 *
 *  @return 获取的数值
 */
+ (NSInteger)tisReceiveDateType:(int)type;

/**
 *  返回今天的日期 yyyy-MM-dd
 */
+ (NSString *)tisGetToday;

/**
 *  返回某一天明天的日期
 *
 *  @param date 某一天的日期 yyyy-MM-dd
 *
 *  @return 明天的日期
 */
+ (NSString *)tisGetTomorrow:(NSDate *)date;

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetDateWithTimeStamp:(NSString *)timeInterval;

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd HH:mm
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetTimeWithTimeStamp:(NSString *)timeInterval;

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd HH:mm:ss
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetTimeWithTimeStampSecond:(NSString *)timeInterval;

/**
 *  获取传入日期所在月份的总天数（如31天，30天，或28天...）
 *
 *  @param date 要传入的日期
 *
 *  @return 格式化后的日期字符串
 */
+ (NSInteger)tisGetNumberOfDaysInMonth:(NSDate *)date;

/**
 *  获取当月中所有天数是周几
 *
 *  @param date 要传入的日期
 *
 *  @return 当月所有周几的数组（1是周日，2是周一，3.以此类推）
 */
+ (NSMutableArray *)tisGetAllDaysWithCalender:(NSDate *)date;

/**
 *  获取指定的日期是星期几 1是周日，2是周一，3.以此类推
 *  @param date 要传入的日期
 *
 *  @return 周几 1是周日，2是周一，3.以此类推
 */
+ (id)tisGetweekDayWithDate:(NSDate *)date;



@end

NS_ASSUME_NONNULL_END
