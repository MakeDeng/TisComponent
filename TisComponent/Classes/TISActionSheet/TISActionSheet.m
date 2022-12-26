//
//  TISActionSheet.m
//  Pods
//
//  Created by tanikawa on 2022/12/26.
//

#import "TISActionSheet.h"
#import "TISHeader.h"
#import "TISActionSheetTableViewCell.h"

@implementation TISActionSheet

@synthesize dataDictionary = _dataDictionary;

- (void)setDataDictionary:(NSMutableDictionary *)dataDictionary {
    _dataDictionary = dataDictionary;
    [self.actionSheetTableView reloadData];
    
    // 计算高度
    CGFloat height = 60 + 8;
    if (dataDictionary[@"desc"]!=nil && ![dataDictionary[@"desc"] isEqualToString:@""]) {
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = [NSString stringWithFormat:@"%@", dataDictionary[@"desc"]];
        descLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        descLabel.numberOfLines = 0;
        
        // 设置高度
        CGFloat theHeight = 0;
        theHeight = [TISTool tisGetLabelHeight:descLabel size:CGSizeMake(TIS_Screen_Width - 20 * 2, MAXFLOAT)] + 18 * 2;
        height += theHeight;
    }
    NSArray *array = dataDictionary[@"list"];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dic = array[i];
        if ([dic[@"type"] isEqualToString:@"desc"]) {
            height += 88;
        } else {
            height += 60;
        }
    }
    self.actionSheetTableView.frame = CGRectMake(0, TIS_Screen_Height - height - TIS_BOTTOM_SAFE_HEIGHT, TIS_Screen_Width, height + TIS_BOTTOM_SAFE_HEIGHT);
    [self setCorners: self.actionSheetTableView];
}

#pragma mark - UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        NSArray *array = self.dataDictionary[@"list"];
        return array.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"desc"]];
        descLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        descLabel.numberOfLines = 0;
        
        // 设置高度
        CGFloat height = 0;
        height = [TISTool tisGetLabelHeight:descLabel size:CGSizeMake(TIS_Screen_Width - 20 * 2, MAXFLOAT)];
        return height + 18 * 2;
    } else {
        return 8;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [UIColor whiteColor];
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"desc"]];
        descLabel.textColor = COLOR_M4;
        descLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        descLabel.text = [NSString stringWithFormat:@"%@", self.dataDictionary[@"desc"]];
        descLabel.numberOfLines = 0;
        [headerView addSubview:descLabel];
        
        // 设置高度
        CGFloat height = 0;
        height = [TISTool tisGetLabelHeight:descLabel size:CGSizeMake(TIS_Screen_Width - 20 * 2, MAXFLOAT)];
        headerView.frame = CGRectMake(0, 0, TIS_Screen_Width, height + 18 * 2);
        descLabel.frame = CGRectMake(20, 18, TIS_Screen_Width - 20 * 2, height);
        
        return headerView;
    } else {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TIS_Screen_Width, 8)];
        headerView.backgroundColor = COLOR_M9;
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TIS_Screen_Width, CGFLOAT_MIN)];
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TISActionSheetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TISActionSheetTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        NSArray *array = self.dataDictionary[@"list"];
        NSDictionary *dictionary = array[indexPath.row];
        cell.contentLabel.text = [NSString stringWithFormat:@"%@", dictionary[@"title"]];
        if ([dictionary[@"type"] isEqualToString:@"desc"]) {
            // 带描述类型
            cell.cellType = ACTION_SHEET_CELL_DESC;
            cell.descLabel.text = [NSString stringWithFormat:@"%@", dictionary[@"desc"]];
        } else if ([dictionary[@"type"] isEqualToString:@"alert"]) {
            // 警示类型
            cell.cellType = ACTION_SHEET_CELL_ALERT;
        } else if ([dictionary[@"type"] isEqualToString:@"disable"]) {
            // 禁用类型
            cell.cellType = ACTION_SHEET_CELL_DISABLE;
        } else if ([dictionary[@"type"] isEqualToString:@"loading"]) {
            // loading类型
            cell.cellType = ACTION_SHEET_CELL_LOADING;
        } else if ([dictionary[@"type"] isEqualToString:@"icon"]) {
            // 带icon类型
            cell.cellType = ACTION_SHEET_CELL_ICON;
            cell.iconImageView.image = dictionary[@"image"];
        } else {
            // 默认类型
            cell.cellType = ACTION_SHEET_CELL_NORMAL;
        }
    } else {
        cell.cellType = ACTION_SHEET_CELL_NORMAL;
        cell.contentLabel.textColor = COLOR_M4;
        cell.contentLabel.text = @"取消";
    }
//    if (indexPath.row % 2 == 0) {
//        cell.backgroundColor = [UIColor orangeColor];
//    } else {
//        cell.backgroundColor = [UIColor blueColor];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSArray *array = self.dataDictionary[@"list"];
        NSDictionary *dictionary = array[indexPath.row];
        if (![dictionary[@"type"] isEqualToString:@"disable"]) {
            self.TISActionSheetBlock(dictionary);
            [self dismiss];
        }
    } else {
        [self dismiss];
    }
}

- (void)show {
    self.frame = CGRectMake(0, 0, TIS_Screen_Width, TIS_Screen_Height);
    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetTableView.frame = CGRectMake(0, TIS_Screen_Height - self.actionSheetTableView.frame.size.height, TIS_Screen_Width, self.actionSheetTableView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.actionSheetTableView.frame = CGRectMake(0, TIS_Screen_Height, TIS_Screen_Width, self.actionSheetTableView.frame.size.height);
    } completion:^(BOOL finished) {
        self.frame = CGRectMake(TIS_Screen_Width, 0, TIS_Screen_Width, TIS_Screen_Height);
    }];
}



#pragma mark - 初始化
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [COLOR_M1 colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.actionSheetTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [COLOR_M1 colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.actionSheetTableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        self.backgroundColor = [COLOR_M1 colorWithAlphaComponent:0.5];
        [self addSubview:self.bgButton];
        [self addSubview:self.actionSheetTableView];
    }
    return self;
}

- (UIButton *)bgButton {
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [_bgButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgButton;
}

- (NSMutableDictionary *)dataDictionary {
    if (!_dataDictionary) {
        _dataDictionary = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"desc": @"",
            @"list": @[],
        }];
    }
    return _dataDictionary;
}

- (UITableView *)actionSheetTableView {
    if (!_actionSheetTableView) {
        _actionSheetTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TIS_Screen_Width, 200) style:UITableViewStyleGrouped];
        _actionSheetTableView.backgroundColor = [UIColor whiteColor];
        _actionSheetTableView.scrollEnabled = NO;
        _actionSheetTableView.delegate = self;
        _actionSheetTableView.dataSource = self;
        _actionSheetTableView.estimatedRowHeight = 60;
        _actionSheetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_actionSheetTableView registerNib:[UINib nibWithNibName:@"TISActionSheetTableViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellReuseIdentifier:@"TISActionSheetTableViewCell"];
    }
    return _actionSheetTableView;
}

- (void)setCorners:(UITableView *)tableView {
    // 设置圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tableView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = tableView.bounds;
    maskLayer.path = maskPath.CGPath;
    tableView.layer.mask = maskLayer;
}

@end
