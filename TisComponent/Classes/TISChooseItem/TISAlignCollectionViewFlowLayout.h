//
//  TISAlignCollectionViewFlowLayout.h
//  TisComponent
//
//  Created by tanikawa on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AlignType) {
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

@interface TISAlignCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) CGFloat betweenOfCell; // 两个Cell之间的距离
@property (nonatomic, assign) AlignType alignType; // cell对齐方式

- (instancetype)initWthType:(AlignType)alignType;

@end

NS_ASSUME_NONNULL_END
