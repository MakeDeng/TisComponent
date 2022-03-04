//
//  TISChooseItem.m
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/3/2.
//

#import "TISChooseItem.h"
#import "TISChooseItemCollectionViewCell.h"
#import "TISAlignCollectionViewFlowLayout.h"

@implementation TISChooseItem

@synthesize dataArray = _dataArray;

#pragma mark - 初始化

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.itemCollection];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self addSubview:self.itemCollection];
    }
    return self;
}

- (void)layoutSubviews {
    self.viewFrame = self.frame;
}



#pragma mark - 懒加载

- (UICollectionView *)itemCollection {
    if (!_itemCollection) {
        TISAlignCollectionViewFlowLayout *flowLayout = [[TISAlignCollectionViewFlowLayout alloc] init];
        _itemCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height) collectionViewLayout:flowLayout];
        _itemCollection.backgroundColor = [UIColor whiteColor];
        _itemCollection.delegate = self;
        _itemCollection.dataSource = self;
    }
    return _itemCollection;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)widthArray {
    if (!_widthArray) {
        _widthArray = [NSMutableArray new];
    }
    return _widthArray;
}

- (NSMutableDictionary *)cellKeyDic {
    if (!_cellKeyDic) {
        _cellKeyDic = [NSMutableDictionary new];
    }
    return _cellKeyDic;
}



#pragma mark - 方法
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.widthArray removeAllObjects];
    for (int i=0; i<_dataArray.count; i++) {
        NSDictionary *dictionary = _dataArray[i];
        NSString *string = [NSString stringWithFormat:@"%@", dictionary[@"name"]];
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
        CGFloat width = rect.size.width + 40 + 10;
        NSString *widthStr = [NSString stringWithFormat:@"%f", width];
        [self.widthArray addObject:widthStr];
    }
    [self.itemCollection reloadData];
}

- (void)setIsMore:(BOOL)isMore {
    _isMore = isMore;
    [self.itemCollection reloadData];
}

- (void)setViewFrame:(CGRect)viewFrame {
    _viewFrame = viewFrame;
    self.itemCollection.frame = CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height);
}



#pragma mark - UICollectionView 代理方法

// 设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"cell%ld", indexPath.row];
    if (![[self.cellKeyDic allKeys] containsObject:identifier])
    {
        [self.cellKeyDic setValue:identifier forKey:identifier];
        [collectionView registerClass:[TISChooseItemCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    }
    TISChooseItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *dictionary = self.dataArray[indexPath.row];
    cell.itemLabel.text = dictionary[@"name"];
    cell.isSelected = [dictionary[@"select"] intValue];
    return cell;
}

// 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TISChooseItemCollectionViewCell *cell = (TISChooseItemCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell layoutIfNeeded];
    return CGSizeMake([self.widthArray[indexPath.row] floatValue], 30);
}

// 定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout {
    return UIEdgeInsetsMake(0, 0, 0 , 0);//（上、左、下、右）
}


// 定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

// 定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isMore) {
        // 多选
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
        if ([dictionary[@"select"] isEqualToString:@"0"]) {
            dictionary[@"select"] = @"1";
        } else {
            dictionary[@"select"] = @"0";
        }
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dictionary];
    } else {
        // 单选
        if (!self.agoIndexPath) {
            self.agoIndexPath = indexPath;
        }
        NSMutableDictionary *agoDictionary = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[self.agoIndexPath.row]];
        [self.dataArray replaceObjectAtIndex:self.agoIndexPath.row withObject:agoDictionary];
        agoDictionary[@"select"] = @"0";
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self.dataArray[indexPath.row]];
        dictionary[@"select"] = @"1";
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:dictionary];
        self.agoIndexPath = indexPath;
    }
    [self.itemCollection reloadData];
}

@end
