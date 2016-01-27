//
//  GKPageCalendarControllerViewController.h
//  pageVCDemo
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKCurlRootController.h"

@class GKCurlOverPageController;
@protocol  GKCurlOverPageControllerDelegate <GKCurlRootControllerDelegate>

- (void)curlOverPage:(GKCurlOverPageController * __nullable)curlOverPage willTransitionToViewController:(UIViewController * __nullable)viewcontroller;
- (void)curlOverPage:(GKCurlOverPageController * __nullable)curlOverPage didFinishAnimating:(BOOL)finished previousViewController:(UIViewController * __nullable)previousViewController transitionCompleted:(BOOL)completed;

@end

@protocol  GKCurlOverPageControllerDataSource <NSObject>

- (nullable UIViewController *)curlOverPage:(GKCurlOverPageController * __nullable)curlOverPage previousViewControllerForViewController:(UIViewController * __nullable)viewcontroller;
- (nullable UIViewController *)curlOverPage:(GKCurlOverPageController * __nullable)curlOverPage nextViewControllerForViewController:(UIViewController * __nullable)viewcontroller;

@end

/**
 *  Just decorate the UIPageViewController, you can use this class as same as UIPAgeViewController but more readability.
 *  When your content UIViewController should be displayed as an curly calendar.
 */
@interface GKCurlOverPageController : GKCurlRootController

@property (nonatomic, weak) id<GKCurlOverPageControllerDataSource> dataSource;
@property (nonatomic, weak) id<GKCurlOverPageControllerDelegate> delegate;

- (void)setCalendarPage:(nullable UIViewController *)currentPage animated:(BOOL)animated completion:(void (^__nullable)(BOOL finished))completion;

@end


