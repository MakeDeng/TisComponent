//
//  TISChooseListTableViewCell.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISChooseListTableViewCell.h"
#import "TISHeader.h"

@implementation TISChooseListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.nameLabel.textColor = COLOR_M1;
}

- (void)setChooseType:(TIS_COOSELIST_TYPE)chooseType {
    _chooseType = chooseType;
    switch (chooseType) {
        case SINGLE:
        {   // 单选
            self.selectImageView.hidden = YES;
            self.nameLeft.constant = -18;
            self.nameLabel.textColor = COLOR_M1;
        }
            break;
        case MORE:
        {   // 多选
            self.selectImageView.hidden = NO;
            self.nameLeft.constant = 10;
            self.nameLabel.textColor = COLOR_M1;
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_choose_un_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_choose_un_selected")];
        }
            break;
        case MORE_SELECT:
        {   // 多选-选中
            self.selectImageView.hidden = NO;
            self.nameLeft.constant = 10;
            self.nameLabel.textColor = COLOR_M1;
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_choose_un_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_choose_selected")];
        }
            break;
        case SINGLE_HIGHTLIGHT:
        {   // 单选搜索关键词高亮
            self.nameLabel.textColor = COLOR_M1;
            [self setCellText:self.nameLabel.text searchText:@[self.keyword] color:COLOR_ORANGE_4];
        }
            break;
        case MORE_HIGHTLIGHT_UNSELECT:
        {   // 多选搜索关键词高亮-未选中
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_choose_un_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_choose_un_selected")];
            self.nameLabel.textColor = COLOR_M1;
            [self setCellText:self.nameLabel.text searchText:@[self.keyword] color:COLOR_ORANGE_4];
        }
            break;
        case MORE_HIGHTLIGHT_SELECT:
        {   // 多选搜索关键词高亮-已选中
            self.selectImageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_choose_selected")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_choose_selected")];
            self.nameLabel.textColor = COLOR_S5;
            [self setCellText:self.nameLabel.text searchText:@[self.keyword] color:COLOR_ORANGE_4];
        }
            break;
        default:
            break;
    }
}

/**
 *  设置显示内容
 *  @param text   全部文字
 *  @param list 高亮搜索词
 *  @param color  高亮颜色
 */
- (void)setCellText:(NSString *)text searchText:(NSArray *)list color:(UIColor *)color {
    BOOL isHave = NO;
    CGFloat width = TIS_Screen_Width - 60;
    if (self.chooseType==SINGLE || self.chooseType==SINGLE_HIGHTLIGHT) {
        width = TIS_Screen_Width - 32;
    }
    CGFloat height = [self getCellHeight:text width:width];
    BOOL isWrap = [self isNeedMultiLineWithStr:text withHeight:24 withWidth:width withFont:16];
//    NSLog(@"ddd:::%@", list);
    if (list.count > 0) {
        NSArray *arr = list;
        
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        if (isWrap) {
            paragraphStyle.lineSpacing = 8;
        } else {
            paragraphStyle.lineSpacing = 0;
        }
        NSMutableAttributedString * theStr = [[NSMutableAttributedString alloc]initWithString:text];
        for (int i=0; i<arr.count; i++) {
            NSString *word = arr[i];
            NSRange range = [text rangeOfString:word];
            if (range.location != NSNotFound) {
                NSArray *array = [self rangesOfSubString:word inString:text];
                for (int i=0; i<array.count; i++) {
                    NSRange range = [array[i] rangeValue];
                    [theStr addAttribute:NSForegroundColorAttributeName value:color range:range];
                    isHave = YES;
                }
            }
        }
        [theStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        [self.nameLabel setAttributedText:theStr];
    }
    if (isHave == NO) {
        self.nameLabel.text = text;
        self.nameLabel.textColor = COLOR_M1;
    }
    self.nameLabelHeight.constant = height;
}

// 根据字符串获取高亮字符数组
- (NSArray *)getHighLightStrList:(NSString *)str {
//    NSString *str = @"搜索所<em>天津</em>肥嘟嘟<em>公司</em>打断点";
    NSString *pattern = @"/./g";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators error:&error];

    NSArray<NSTextCheckingResult *> *result = [regex matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    if (result) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i<result.count; i++) {
            NSTextCheckingResult *res = result[i];
            
            for (NSInteger i = 1; i < [res numberOfRanges]; i++) {
                NSString *matchString;
                
                NSRange range = [res rangeAtIndex:i];
                
                if (range.location != NSNotFound) {
                    matchString = [str substringWithRange:[res rangeAtIndex:i]];
                } else {
                    matchString = @"";
                }
                [arr addObject:matchString];
            }
        }
//        NSLog(@"====%@", arr);
        return arr;
    } else {
        NSLog(@"error == %@",error.description);
        return @[];
    }
}

// 获取字符串所有子串的range数组
- (NSArray*)rangesOfSubString:(NSString*)substring inString:(NSString*)string {

    if (substring.length == 0

        || string.length == 0) {

        return nil;

    }

    NSMutableArray *rangeArray = [[NSMutableArray alloc] init];

    NSRange searchRange = NSMakeRange(0,string.length);

    NSRange foundRange;

    while (searchRange.location < string.length) {

        searchRange.length = string.length - searchRange.location;

        foundRange = [string rangeOfString:substring options:NSCaseInsensitiveSearch range:searchRange];

        if (foundRange.location != NSNotFound) {

            // found an occurrence of the substring! do stuff here

            searchRange.location = foundRange.location+foundRange.length;

            [rangeArray addObject:[NSValue valueWithRange:foundRange]];

        } else {

            // no more substring to find

            break;

        }

    }

    return rangeArray;
}

- (CGFloat)getCellHeight:(NSString *)text width:(CGFloat)width {
    // 内容格式设置
    NSMutableParagraphStyle *contentParagraphStyle = [NSMutableParagraphStyle new];
    // 设置行间距
    contentParagraphStyle.lineSpacing = 10;
    NSMutableDictionary *contentAttributes = [NSMutableDictionary dictionary];
    [contentAttributes setObject:contentParagraphStyle forKey:NSParagraphStyleAttributeName];

    NSMutableAttributedString *contentAttString = [[NSMutableAttributedString alloc] initWithString:text];
    [contentAttString addAttribute:NSParagraphStyleAttributeName value:contentParagraphStyle range:NSMakeRange(0, [text length])];
    [contentAttString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16 weight:UIFontWeightRegular] range:NSMakeRange(0, [text length])];
    float contentHeight = [contentAttString boundingRectWithSize:CGSizeMake (width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    if (contentHeight < 30) { // 如果等于一行那就是一行的高度
        contentHeight = 24;
    }
    return contentHeight;
}

-(BOOL)isNeedMultiLineWithStr:(NSString*)str withHeight:(CGFloat)height withWidth:(CGFloat)width withFont:(CGFloat)font {
    CGFloat myWidth=[str boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}context:nil].size.width;
    if (myWidth <= width) {
        return NO;
    } else {
        return YES;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.contentView.backgroundColor = COLOR_M8;
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - 初始化

- (NSString *)keyword {
    if (!_keyword) {
        _keyword = @"";
    }
    return _keyword;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
