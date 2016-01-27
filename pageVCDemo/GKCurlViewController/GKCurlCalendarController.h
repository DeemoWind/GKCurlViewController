//
//  GKCurlCalendarController.h
//  pageVCDemo
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKCurlRootController.h"

@class GKCurlCalendarController;
@protocol  GKCurlCalendarControllerDelegate <GKCurlRootControllerDelegate>

- (void)curlCalendar:(GKCurlCalendarController * __nullable)curlCalendar willTransitionToViewController:(UIViewController * __nullable)viewcontroller;
- (void)curlCalendar:(GKCurlCalendarController * __nullable)curlCalendar didFinishAnimating:(BOOL)finished previousViewController:(UIViewController * __nullable)previousViewController transitionCompleted:(BOOL)completed;

@end

@protocol  GKCurlCalendarControllerDataSource <NSObject>

@required
- (NSInteger)numberOfPageInCurlCalendar:(GKCurlCalendarController * __nullable)curlCalendar;
- (nullable UIViewController *)curlCalendar:(GKCurlCalendarController * __nullable)curlCalendar pageViewControllerAtIndex:(NSInteger)index;

@end

@interface GKCurlCalendarController : GKCurlRootController

@property (nonatomic, weak) id<GKCurlCalendarControllerDataSource> dataSource;
@property (nonatomic, weak) id<GKCurlCalendarControllerDelegate> delegate;

- (void)replaceCalendarPage:(nullable UIViewController *)currentPage animated:(BOOL)animated completion:(void (^__nullable)(BOOL finished))completion;

- (void)curlOverTowardCalendarPageAtIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^__nullable)(BOOL finished))completion;

@end
