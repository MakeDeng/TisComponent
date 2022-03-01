//
//  TISHorButtonScroll.m
//  TisComponent_Example
//
//  Created by tanikawa on 2022/2/24.
//  Copyright © 2022 dengchaoyun. All rights reserved.
//

#import "TISHorButtonScroll.h"
#import "TISHorButtonCollectionViewCell.h"
#import "TISHeader.h"

@implementation TISHorButtonScroll

@synthesize dataArray = _dataArray;

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        [self addSubview:self.buttonCollection];
        [self addSubview:self.noneLabel];
    }
    return self;
}



#pragma mark - 懒加载

- (UILabel *)noneLabel {
    if (!_noneLabel) {
        _noneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height)];
        _noneLabel.text = @"暂未选择内容";
        _noneLabel.font = [UIFont systemFontOfSize:14];
        _noneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _noneLabel;
}

- (UICollectionView *)buttonCollection {
    if (!_buttonCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _buttonCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height) collectionViewLayout:flowLayout];
        _buttonCollection.showsHorizontalScrollIndicator = NO;
        _buttonCollection.backgroundColor = [UIColor whiteColor];
        _buttonCollection.delegate = self;
        _buttonCollection.dataSource = self;
        [_buttonCollection registerNib:[UINib nibWithNibName:@"TISHorButtonCollectionViewCell" bundle:[NSBundle bundleForClass:[self class]]] forCellWithReuseIdentifier:@"TISHorButtonCollectionViewCell"];
    }
    return _buttonCollection;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray new];
    }
    return _dataArray;
}

- (NSMutableArray *)widthArray {
    if (!_widthArray) {
        _widthArray = [NSMutableArray new];
    }
    return _widthArray;
}


#pragma mark - 方法
- (void)setDataArray:(NSArray *)dataArray {
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
    if (_dataArray.count == 0) {
        self.noneLabel.hidden = NO;
    } else {
        self.noneLabel.hidden = YES;
    }
    [self.buttonCollection reloadData];
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
    TISHorButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TISHorButtonCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.dataArray[indexPath.row];
    cell.nameLabel.text = dictionary[@"name"];
    return cell;
}

// 定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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
    return 0;
}

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = self.dataArray[indexPath.row];
    self.closeData(dictionary);
}


@end
