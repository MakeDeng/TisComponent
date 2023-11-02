//
//  TISChooseListRequestView.m
//  TisComponent
//
//  Created by tanikawa on 2023/10/31.
//

#import "TISChooseListRequestView.h"
#import "TISHeader.h"

@implementation TISChooseListRequestView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.viewFrame = frame;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.emptyView];
        [self addSubview:self.loadingView];
    }
    return self;
}

- (void)setViewType:(TIS_COOSELIST_REQUEST_TYPE)viewType {
    _viewType = viewType;
    switch (viewType) {
        case NORMAL:
        { // 正常状态
            self.loadingView.hidden = YES;
            self.emptyView.hidden = YES;
            [self.loadingView endLoading];
            self.hidden = YES;
        }
            break;
        case EMPTY:
        { // 空视图
            self.loadingView.hidden = YES;
            self.emptyView.hidden = NO;
            [self.loadingView endLoading];
            self.hidden = NO;
        }
            break;
        case LOADING:
        { // 加载
            self.emptyView.hidden = YES;
            self.loadingView.hidden = NO;
            [self.loadingView startLoading];
            self.hidden = NO;
        }
            break;
        default:
            break;
    }
}

/// 更新子组件frame
- (void)resizeSubview {
    self.emptyView.frame = CGRectMake(0, (self.frame.size.height - self.emptyView.frame.size.height) / 2, self.viewFrame.size.width, self.emptyView.frame.size.height);
    self.loadingView.frame = CGRectMake(0, (self.frame.size.height - self.loadingView.frame.size.height) / 2, self.viewFrame.size.width, self.viewFrame.size.height);
}



#pragma mark - 懒加载

- (UIView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height)];
        _emptyView.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.viewFrame.size.width - 160) / 2, (self.viewFrame.size.height - 160) / 2, 160, 160)];
        imageView.image = [UIImage imageNamed:TISCommonSrcName(@"tis_no_search_result")]?:[UIImage imageNamed:TISCommonFrameworkSrcName(@"tis_no_search_result")];
        [_emptyView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.origin.y + imageView.frame.size.height + 16, self.viewFrame.size.width, 22)];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"没有相关的搜索结果";
        label.textColor = COLOR_M4;
        label.textAlignment = NSTextAlignmentCenter;
        [_emptyView addSubview:label];
        
    }
    return _emptyView;
}

- (TISLoading *)loadingView {
    if (!_loadingView) {
        _loadingView = [[TISLoading alloc] initWithFrame:CGRectMake(0, 0, self.viewFrame.size.width, self.viewFrame.size.height)];
        _loadingView.loadingType = LOADING_POINT;
        _loadingView.hidden = YES;
        [_loadingView endLoading];
    }
    return _loadingView;
}

@end
