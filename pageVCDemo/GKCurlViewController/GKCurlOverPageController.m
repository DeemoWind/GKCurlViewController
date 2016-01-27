//
//  GKPageCalendarControllerViewController.m
//  pageVCDemo
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKCurlOverPageController.h"

@interface GKCurlOverPageController ()

@end

@implementation GKCurlOverPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - functionality
- (void)setCalendarPage:(UIViewController *)currentPage animated:(BOOL)animated completion:(void (^__nullable)(BOOL finished))completion {
    
    NSArray * tempArray = nil;
    if (currentPage) {
        tempArray = @[currentPage];
    }
    [self.pageViewController setViewControllers:tempArray direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:completion];
}

#pragma mark - private method 


#pragma mark - getter & setter


#pragma mark - pageVC delegate and datasource
#pragma mark datasource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    if (self.dataSource && [self.dataSource respondsToSelector:@selector(curlOverPage:previousViewControllerForViewController:)]) {
        return [self.dataSource curlOverPage:self previousViewControllerForViewController:viewController];
    }
    return nil;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    if (self.dataSource && [self.dataSource respondsToSelector:@selector(curlOverPage:nextViewControllerForViewController:)]) {
        return [self.dataSource curlOverPage:self nextViewControllerForViewController:viewController];
    }
    return nil;
}


#pragma mark delegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController * viewController = pendingViewControllers.count >= 1 ? [pendingViewControllers firstObject] : nil;

    if (self.delegate &&[self.delegate respondsToSelector:@selector(curlOverPage:willTransitionToViewController:)]) {
        [self.delegate curlOverPage:self willTransitionToViewController:viewController];
    }
}
 
// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {

    UIViewController * viewController = previousViewControllers.count >= 1 ? [previousViewControllers firstObject] : nil;
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(curlOverPage:didFinishAnimating:previousViewController:transitionCompleted:)]) {
        [self.delegate curlOverPage:self didFinishAnimating:finished previousViewController:viewController transitionCompleted:completed];
    }
    
}

// Delegate may specify a different spine location for after the interface orientation change. Only sent for transition style 'UIPageViewControllerTransitionStylePageCurl'.
// Delegate may set new view controllers or update double-sided state within this method's implementation as well.
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    return UIPageViewControllerSpineLocationMin;
}

//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
//    
//}
//- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
//    
//}

#pragma mark - memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
