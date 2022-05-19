//
//  TISButtonActivity.m
//  TisComponent
//
//  Created by tanikawa on 2022/5/19.
//

#import "TISButtonActivity.h"
#import "TISButton.h"

@implementation TISButtonActivity

- (void)startAnimating {
    if ([NSStringFromClass([self.superview class]) isEqualToString:@"TISButton"]) {
        TISButton *button = (TISButton *)self.superview;
        [button refreshImage:YES];
    }
    [super startAnimating];
}

- (void)stopAnimating {
    if ([NSStringFromClass([self.superview class]) isEqualToString:@"TISButton"]) {
        TISButton *button = (TISButton *)self.superview;
        [button refreshImage:NO];
    }
    [super stopAnimating];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [self superview];
}

@end
