//
//  GKCurlRootController.h
//  pageVCDemo
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class GKCurlRootController;

@protocol GKCurlRootControllerDelegate <NSObject>

@end

@protocol GKCurlRootControllerDataSource <NSObject>


@end

@interface GKCurlRootController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    @protected
    UIPageViewController * _pageViewController;
}
@property (nonatomic, readonly) UIPageViewController * pageViewController;

- (void)adjustContentInsets:(UIEdgeInsets)edgeInsets;
- (void)adjustInsetsWithTop:(CGFloat)topInset
                  leftInset:(CGFloat)leftInset
                bottomInset:(CGFloat)bottomInset
                 rightInset:(CGFloat)rightInset;

@end
