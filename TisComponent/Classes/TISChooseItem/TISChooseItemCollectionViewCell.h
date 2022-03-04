//
//  TISChooseItemCollectionViewCell.h
//  TisComponent
//
//  Created by tanikawa on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TISChooseItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, assign) BOOL isSelected; // 是否选中

@end

NS_ASSUME_NONNULL_END
