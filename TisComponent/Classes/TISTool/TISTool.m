//
//  TISTool.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/23.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISTool.h"
#import <Photos/Photos.h>
#import <CommonCrypto/CommonDigest.h>

@implementation TISTool

#pragma mark - 判断字符串是否为空

/**
 *  判断字符串是否为空
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckIsNull:(NSString *)string {
    if (string==nil || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}



#pragma mark - 正则验证及判断相关

/**
 *  判断是否是手机号(只限制11位总位数和第一位是1)
 *
 *  @param string 传入的手机号
 */
+ (BOOL)tisCheckTelNumber:(NSString *)string {
    NSString *CT_NUM = @"^[1][0-9][0-9]{9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isTel = [predicate evaluateWithObject:string];
    return isTel;
}

/**
 *  判断是否是有效的身份证号
 *
 *  @param string 传入的身份证号
 */
+ (BOOL)tisCheckIDCardNumber:(NSString *)string {
    NSString *value = [string stringByReplacingOccurrencesOfString:@"x" withString:@"X"];
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    } else {
        length = value.length;
        if (length!=15 && length!=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41",@"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue + 1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"  options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if (numberofMatch >0) {
                return YES;
            } else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
            }else {
                return NO;
            }
        default:
            return false;
    }
}

/**
 *  判断是否是有效的邮箱
 *
 *  @param string 传入的邮箱
 */
+ (BOOL)tisCheckEmail:(NSString *)string {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *email = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [email evaluateWithObject:string];
}

/**
 *  判断字符串是否包含另一个字符串
 *
 *  @param string 传入的字符串
 *  @param str    是否包含的字符串
 */
+ (BOOL)tisCheckContainString:(NSString *)string str:(NSString *)str {
    if ([string rangeOfString:str].location != NSNotFound) {
        //包含
        return YES;
    } else {
        //不包含
        return NO;
    }
}

/**
 *  判断是否包含特殊字符
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckContainSpecial:(NSString *)string {
    //数学符号
    NSString *matSym = @" ﹢﹣×÷±/=≌∽≦≧≒﹤﹥≈≡≠=≤≥<>≮≯∷∶∫∮∝∞∧∨∑∏∪∩∈∵∴⊥∥∠⌒⊙√∟⊿㏒㏑%‰⅟½⅓⅕⅙⅛⅔⅖⅚⅜¾⅗⅝⅞⅘≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩⊰⊱⋛⋚∫∬∭∮∯∰∱∲∳%℅‰‱øØπ";
    //标点符号
    NSString *punSym = @"。，、＇：∶；?‘’“”〝〞ˆˇ﹕︰﹔﹖﹑·¨….¸;！´？！～—ˉ｜‖＂〃｀@﹫¡¿﹏﹋﹌︴々﹟#﹩$﹠&﹪%*﹡﹢﹦﹤‐￣¯―﹨ˆ˜﹍﹎+=<＿_-ˇ~﹉﹊（）〈〉‹›﹛﹜『』〖〗［］《》〔〕{}「」【】︵︷︿︹︽_﹁﹃︻︶︸﹀︺︾ˉ﹂﹄︼❝❞!():,'[]｛｝^・.·．•＃＾＊＋＝＼＜＞＆§⋯`－–／—|\"\\";
    //单位符号＊·
    NSString *unitSym = @"°′″＄￥〒￠￡％＠℃℉﹩﹪‰﹫㎡㏕㎜㎝㎞㏎m³㎎㎏㏄º○¤%$º¹²³";
    //货币符号
    NSString *curSym = @"₽€£Ұ₴$₰¢₤¥₳₲₪₵₣₱฿¤₡₮₭₩ރ円₢₥₫₦ł﷼₠₧₯₨Kčर₹ƒ₸￠";
    NSString *allStr =[NSString stringWithFormat:@"%@%@%@%@",matSym,punSym,unitSym,curSym];
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:allStr] invertedSet];
    NSArray *strArray = [string componentsSeparatedByString:@""];
    BOOL contain = NO;
    for (NSString *str in strArray) {
        NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([TISTool tisCheckContainString:string str:filtered]) {
            contain = YES;
        }
    }
    return contain;
}

/**
 *  判断是否是6-20位字母和数字组合
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckContainNumberWithLetter:(NSString *)string {
    if (string.length < 6 || string.length>20) return NO;
    
    //判断是否仅包含数字
    NSString * numberRegex = @"[0-9]*";
    NSPredicate * numberPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    BOOL isAllNumber=[numberPred evaluateWithObject:self];
    if (isAllNumber) {
        return NO;
    }
    
    //判断是否仅包含字母
    NSString * letterRegex = @"[a-zA-Z]*";
    NSPredicate * letterPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",letterRegex];
    BOOL isAllLetter=[letterPred evaluateWithObject:self];
    if (isAllLetter) {
        return NO;
    }
    
    //判断是否仅包含字母和数字
    NSString * bothRegex = @"[a-zA-Z0-9]*";
    NSPredicate * bothPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bothRegex];
    return [bothPred evaluateWithObject:self];
}

/**
 *  判断是否是中文
 *
 *  @param string 传入的字符串
 */
+ (BOOL)tisCheckIsChinese:(NSString *)string {
    if ([string isEqualToString:@""]) {
        return YES;
    } else {
        NSString *match = @"(^[\u4e00-\u9fa5]+$)";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
        return [predicate evaluateWithObject:string];
    }
}



#pragma mark - 字符串实用方法

/**
 *  中间几数位用指定字符加密
 *
 *  @param string   传入的字符串
 *  @param str      指定的字符
 *  @param minIndex 加密起始位置
 *  @param maxIndex 加密结束位置
 */
+ (NSString *)tisSetSecret:(NSString *)string str:(NSString *)str min:(NSInteger)minIndex max:(NSInteger)maxIndex {
    if (string.length < maxIndex) {
        return string;
    }
    NSString * secretStr=[string substringWithRange:NSMakeRange(minIndex,maxIndex)];
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0; i<secretStr.length; i++) {
        [array addObject:str];
    }
    NSString *secret = [array componentsJoinedByString:@""];
    NSString *secretString=[string stringByReplacingOccurrencesOfString:secretStr withString:secret];
    return secretString;
}

/**
 *  获取某个字符串或者汉字的首字母
 */
+ (NSString *)tisFirstCharactor:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}

/**
 *  将汉字转换为拼音
 *  chinese 汉字
 */
+ (NSString *)tisTransformChineseToPinyin:(NSString *)chinese {
    if ([self tisCheckIsNull:chinese]) {
        return @"";
    }
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}



#pragma mark - UILabel相关

/**
 *  获取label所设文字不折行显示宽度(需先设置文字)
 *
 *  @param label 要设置的label
 *  @param size  label可占最大宽高如：(MAXFLOAT,20)
 *
 *  @return 获取的宽度
 */
+ (CGFloat)tisGetLabelWidth:(UILabel *)label size:(CGSize)size {
    //如果所设文字为空直接返回0.00
    if ([TISTool tisCheckIsNull:label.text]) {
        return 0.00;
    }
    CGRect rect = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    return rect.size.width;
}

/**
 *  获取label所设文字高度(需先设置文字)
 *
 *  @param label 要设置的label
 *  @param size  label可占最大宽高如：(80, MAXFLOAT)
 *
 *  @return 获取的高度
 */
+ (CGFloat)tisGetLabelHeight:(UILabel *)label size:(CGSize)size {
    //如果所设文字为空直接返回0.00
    if ([TISTool tisCheckIsNull:label.text]) {
        return 0.00;
    }
    CGSize labelSize = [label sizeThatFits:size];
    return labelSize.height;
}

/**
 *  label文字显示不同颜色
 *
 *  @param string    lable显示的文本
 *  @param str       要改变颜色的文字
 *  @param lable     要设置的lable
 *  @param textColor 要改变的部分文字的颜色
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str theLable:(UILabel *)lable theColor:(UIColor *)textColor {
    NSMutableAttributedString * theStr=[[NSMutableAttributedString alloc]initWithString:string];
    NSRange range = NSMakeRange([[theStr string] rangeOfString:str].location, [[theStr string] rangeOfString:str].length);
    [theStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    [lable setAttributedText:theStr];
}

/**
 *  label文字显示不同字号
 *
 *  @param string   lable显示的文本
 *  @param str      要改变字号的文字
 *  @param lable    要设置的lable
 *  @param textFont 要改变的部分文字的字号
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str lable:(UILabel *)lable theFont:(UIFont *)textFont {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:str].location, [[noteStr string] rangeOfString:str].length);
    [noteStr addAttribute:NSFontAttributeName value:textFont range:redRange];
    [lable setAttributedText:noteStr];
}

/**
 *  label文字显示不同字号及颜色
 *
 *  @param string    lable显示的文本
 *  @param str       要改变字号的文字
 *  @param lable     要设置的lable
 *  @param textFont  要改变的部分文字的字号
 *  @param textColor 要改变的部分文字的颜色
 */
+ (void)tisSetString:(NSString *)string someStr:(NSString *)str lable:(UILabel *)lable theFont:(UIFont *)textFont theColor:(UIColor *)textColor {
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:str].location, [[noteStr string] rangeOfString:str].length);
    [noteStr addAttribute:NSFontAttributeName value:textFont range:redRange];
    [noteStr addAttribute:NSForegroundColorAttributeName value:textColor range:redRange];
    [lable setAttributedText:noteStr];
}

/**
 *  调整行间距(需先设置文字)
 *
 *  @param lable 要设置的lable
 *  @param space 要设置的行间距
 */
+ (void)tisSetLineSpace:(UILabel *)lable space:(CGFloat)space {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lable.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lable.text length])];
    lable.attributedText = attributedString;
}



#pragma mark - 颜色相关

/**
 *  将十六进制颜色转换为UIColor对象
 *
 *  @param hexString 要转换的十六进制字符串
 *
 *  @return 转换的颜色
 */
+ (UIColor *)tisColorWithHex:(NSString *)hexString {
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}



#pragma mark - 网络相关

/**
 *  获得当前外网的IP地址
 */
+ (NSString*)tisGetWlanIpAdress {
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        return dict[@"cip"];
    }
    return @"";
}

/**
 *  判断是否是url
 */
+ (BOOL)tisCheckIsUrl:(NSString *)url {
    NSString *emailRegex = @"[a-zA-z]+://.*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:url];
}

/**
 *  将url地址后拼接的参数转换为NSMutableDictionary对象
 *
 *  @param url 带参数的url地址
 *
 *  @return 获取的参数字典
 */
+ (NSMutableDictionary *)tisGetUrlParams:(NSString*)url {
    // 查找参数
    NSRange range = [url rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 截取参数
    NSString *parametersString = [url substringFromIndex:range.location + 1];
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if (existValue != nil) {
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                } else {
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
            } else {
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        // 设置值
        [params setValue:value forKey:key];
    }
    return params;
}



#pragma mark - 本地存储相关

/**
 *  将数组存入本地
 *
 *  @param array 要存入的数组
 *  @param path 保存的文件名称
 */
+ (void)tisSaveArray:(NSArray *)array path:(NSString *)path {
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [doc objectAtIndex:0];
    NSString *pathName = [NSString stringWithFormat:@"%@.plist",path];
    NSString *multiHomePath = [docPath stringByAppendingPathComponent:pathName];
    [array writeToFile:multiHomePath atomically:YES];
}

/**
 *  根据文件名称将保存的数组从本地取出
 *
 *  @param path 保存文件的名称
 *
 *  @return 取出的数组
 */
+ (NSArray *)tisGetArrayWithPath:(NSString *)path {
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [doc objectAtIndex:0];
    NSString *pathName = [NSString stringWithFormat:@"%@.plist",path];
    NSString *multiHomePath=[docPath   stringByAppendingPathComponent:pathName];
    NSArray * array=[NSArray arrayWithContentsOfFile:multiHomePath];
    return array;
}



#pragma mark - 权限相关

/**
 *  判断是否开启相册权限
 */
+ (BOOL)tisPhotoServiceOpen {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}

/**
 *  判断是否开启相机权限
 */
+ (BOOL)tisCameroServiceOpen {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}



#pragma mark - 图片相关

/**
 *  按图片质量等比例压缩图片
 *
 *  @param image   要压缩的图片
 *  @param quality 压缩质量 0 - 1
 *
 *  @return 压缩完的图片
 */
+ (UIImage *)tisCompressImage:(UIImage *)image quality:(CGFloat)quality {
    UIImage *newImage = [self tisCompressImage:image];
    NSData *imageData = UIImageJPEGRepresentation(newImage, quality);
    return [UIImage imageWithData:imageData];
}

/**
 *  等比例压缩图片
 *
 *  @param image 要压缩的图片
 *
 *  @return 压缩完的图片
 */
+ (UIImage *)tisCompressImage:(UIImage *)image {
    // 宽高比
    CGFloat ratio = image.size.width/image.size.height;
    // 目标大小
    CGFloat targetW = 1280;
    CGFloat targetH = 1280;
    // 宽高均 <= 1280，图片尺寸大小保持不变
    if (image.size.width<1280 && image.size.height<1280) {
        return image;
    } else if (image.size.width>1280 && image.size.height>1280) {
        // 宽高均 > 1280 && 宽高比 > 2，
        if (ratio>1) {
            // 宽大于高 取较小值(高)等于1280，较大值等比例压缩
            targetH = 1280;
            targetW = targetH * ratio;
        } else{
            // 高大于宽 取较小值(宽)等于1280，较大值等比例压缩
            targetW = 1280;
            targetH = targetW / ratio;
        }
    } else {
        // 宽或高 > 1280
        if (ratio>2) {
            // 宽图 图片尺寸大小保持不变
            targetW = image.size.width;
            targetH = image.size.height;
        } else if (ratio<0.5) {
            // 长图 图片尺寸大小保持不变
            targetW = image.size.width;
            targetH = image.size.height;
        } else if (ratio>1) {
            // 宽大于高 取较大值(宽)等于1280，较小值等比例压缩
            targetW = 1280;
            targetH = 1280 / ratio;
        } else {
            // 高大于宽 取较大值(高)等于1280，较小值等比例压缩
            targetH = 1280;
            targetW = 1280 * ratio;
        }
    }
    image = [self imageCompressWithImage:image targetHeight:targetH targetWidth:targetW];
    return image;
}

/**
 *  重绘图片
 */
+ (UIImage *)imageCompressWithImage:(UIImage *)sourceImage targetHeight:(CGFloat)targetHeight targetWidth:(CGFloat)targetWidth {
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 浮点型数据处理

/**
 *  不四舍五入保留指定位数小数
 *
 *  @param number   需要处理的数字
 *  @param position 保留小数点第几位
 */
+ (NSString *)tisNotRounding:(float)number afterPoint:(int)position {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}



#pragma mark - 加密相关

/**
 *  sha1加密
 *
 *  @param string 要加密的字符串
 */
+ (NSString*)tisSha1Secret:(NSString *)string {
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

/**
 *  MD5加密
 *
 *  @param string 要加密的字符串
 */
+ (NSString *)tisMD5Secret:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}

/**
 * base64加密
 *
 * @param string 要加密的字符串
 */
+ (NSString *)tisBase64EncodeString:(NSString *)string {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/**
 *  base64解密
 *
 *  @param string 要解密的字符串
 */
+ (NSString *)tisBase64DecodeString:(NSString *)string {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}



#pragma mark - 时间相关

/**
 *  获取当前日期的 年/月/日/时/分/秒 中的单个数值
 *
 *  @param type 0:年，1:月，2:日，3:时，4:分，5:秒
 *
 *  @return 获取的数值
 */
+ (NSInteger)tisReceiveDateType:(int)type {
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    switch (type) {
        case 0://年
        {
            return [dateComponent year];
        }
            break;
        case 1://月
        {
            return [dateComponent month];
        }
            break;
        case 2://日
        {
            return [dateComponent day];
        }
            break;
        case 3://时
        {
            return [dateComponent hour];
        }
            break;
            
        case 4://分
        {
            return [dateComponent minute];
        }
            break;
        default://秒
        {
            return [dateComponent second];
        }
            break;
    }
}

/**
 *  返回今天的日期 yyyy-MM-dd
 */
+ (NSString *)tisGetToday {
    NSDate * date=[NSDate date];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}

/**
 *  返回某一天明天的日期
 *
 *  @param date 某一天的日期 yyyy-MM-dd
 *
 *  @return 明天的日期
 */
+ (NSString *)tisGetTomorrow:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetDateWithTimeStamp:(NSString *)timeInterval {
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * timeStr=[dateFormatter stringFromDate:date];
    return timeStr;
}

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd HH:mm
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetTimeWithTimeStamp:(NSString *)timeInterval {
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * timeStr=[dateFormatter stringFromDate:date];
    return timeStr;
}

/**
 *  根据时间戳获得时间字符串 yyyy-MM-dd HH:mm:ss
 *
 *  @param timeInterval 要转换的字符串
 *
 *  @return 格式化后的日期字符串
 */
+ (NSString *)tisGetTimeWithTimeStampSecond:(NSString *)timeInterval {
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDateFormatter * dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeStr=[dateFormatter stringFromDate:date];
    return timeStr;
}

/**
 *  获取传入日期所在月份的总天数（如31天，30天，或28天...）
 *
 *  @param date 要传入的日期
 *
 *  @return 格式化后的日期字符串
 */
+ (NSInteger)tisGetNumberOfDaysInMonth:(NSDate *)date {
    // 指定日历的算法
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/**
 *  获取当月中所有天数是周几
 *
 *  @param date 要传入的日期
 *
 *  @return 当月所有周几的数组（1是周日，2是周一，3.以此类推）
 */
+ (NSMutableArray *)tisGetAllDaysWithCalender:(NSDate *)date {
    //一个月的总天数
    NSUInteger dayCount = [self tisGetNumberOfDaysInMonth:date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSDate * currentDate = [NSDate date];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * str = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i <= dayCount; i++) {
        NSString * sr = [NSString stringWithFormat:@"%@-%ld",str,i];
        NSDate *suDate = [formatter dateFromString:sr];
        [allDaysArray addObject:[self tisGetweekDayWithDate:suDate]];
    }
    return allDaysArray;
}

/**
 *  获取指定的日期是星期几 1是周日，2是周一，3.以此类推
 *  @param date 要传入的日期
 *
 *  @return 周几 1是周日，2是周一，3.以此类推
 */
+ (id)tisGetweekDayWithDate:(NSDate *)date {
    // 指定日历的算法
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    return @([comps weekday]);
    
}



@end
