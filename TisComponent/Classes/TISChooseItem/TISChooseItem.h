//
//  TISChooseItem.h
//  FBSnapshotTestCase
//
//  Created by tanikawa on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseItem : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGRect viewFrame; // 视图的fram
@property (nonatomic, strong) UICollectionView *itemCollection; // 选项collection
/**
 *  数据列表  每个字典对象必须包含name和select这两个字段 例如@[@{@"name": @"北京大学", @"select": @"0"}], 若有其他字段选中回调方法会原样返回其他字段
 */
@property (nonatomic, strong) NSMutableArray *dataArray; // 数据列表
@property (nonatomic, strong) NSMutableArray *widthArray; // cell宽度列表
@property (nonatomic, assign) BOOL isMore; // 是否是多选（默认为单选）
@property (nonatomic, strong) NSMutableDictionary *cellKeyDic; // cellId字典
@property (nonatomic, strong) NSIndexPath *agoIndexPath; // 上一个操作的indexPath

@end

NS_ASSUME_NONNULL_END
