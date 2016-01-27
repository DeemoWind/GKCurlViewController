//
//  GKCurlCalendarController.m
//  pageVCDemo
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#define PLUS(a, b) (a+b)
#define PRINT_BOOL(A)  ({if(A){ NSLog(@"BOOL is YES"); }else{ NSLog(@"BOOL is NO");}})

#import "GKCurlCalendarController.h"


typedef NS_ENUM(NSInteger, GKCurlCalendarCurlToward) {
    GKCurlCalendarCurlTowardNone = 0,
    GKCurlCalendarCurlTowardForward,
    GKCurlCalendarCurlTowardBackward
};

@interface GKCurlCalendarController ()
{
    NSInteger _numberOfPageInCurlCalendar;
    BOOL _isAnimated;
}

@property (nonatomic) NSInteger pageIndex;

@property (nonatomic) GKCurlCalendarCurlToward curlToward;

- (UIViewController * __nullable)nextContentViewControllerForCurrentIndex;
- (UIViewController * __nullable)previousContentViewControllerForCurrentIndex;

@end

@implementation GKCurlCalendarController
@synthesize pageIndex = _pageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.curlToward = GKCurlCalendarCurlTowardNone;
    
    [self commitNumberOfPageInCurlCalendar];

}

#pragma mark - functionality

- (void)curlOverTowardCalendarPageAtIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    self.pageIndex = index;
    UIViewController * viewController = [self.dataSource curlCalendar:self pageViewControllerAtIndex:self.pageIndex];
    NSArray * array= @[viewController];
    
    [self.pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:completion];
}

- (void)replaceCalendarPage:(UIViewController *)currentPage animated:(BOOL)animated completion:(void (^)(BOOL))completion {
    
    UIViewController * viewController = currentPage;
    NSArray * array = @[viewController];
    
    [self.pageViewController setViewControllers:array direction:UIPageViewControllerNavigationDirectionForward animated:animated completion:completion];
    
}

#pragma mark - private method
- (UIViewController * __nullable)nextContentViewControllerForCurrentIndex {
    
    if ([self pageIndexIncreasedMax]) {
        return nil;
    }
    UIViewController * tempViewController = [self.dataSource curlCalendar:self pageViewControllerAtIndex:self.pageIndex +1];
    
    return tempViewController;
}

- (UIViewController * __nullable)previousContentViewControllerForCurrentIndex {
    
    if ([self pageIndexDecreasedMin]) {
        return nil;
    }
    UIViewController * tempViewController = [self.dataSource curlCalendar:self pageViewControllerAtIndex:self.pageIndex - 1];

    return tempViewController;
}

- (BOOL)pageIndexIncreasedMax {

    NSInteger tempPageIndex = self.pageIndex;
    if ( (tempPageIndex + 1 >= _numberOfPageInCurlCalendar) || (_isAnimated == YES)){
        return YES;
    }
    return NO;
}

- (BOOL)pageIndexDecreasedMin {

    NSInteger tempPageIndex = self.pageIndex;
    if ( (tempPageIndex - 1 < 0) || (_isAnimated == YES)) { //|| (_isAnimated == YES)
        return YES;
    }
    return NO;
}

- (void)commitNumberOfPageInCurlCalendar {
    if (self.dataSource) {
        _numberOfPageInCurlCalendar = [self.dataSource numberOfPageInCurlCalendar:self];
    } else {
        NSLog(@"%@ - > %s",self.dataSource, __func__);
    }
}

#pragma mark - getter & setter

- (void)setPageIndex:(NSInteger)pageIndex {
    _pageIndex = MIN(MAX(0, pageIndex), _numberOfPageInCurlCalendar - 1);

}

- (NSInteger)pageIndex {
    _pageIndex = MIN(MAX(0, _pageIndex), _numberOfPageInCurlCalendar - 1);
    return _pageIndex;
}


#pragma mark - pageVC delegate and datasource
#pragma mark datasource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if (self.dataSource) {
        self.curlToward = GKCurlCalendarCurlTowardBackward;
        return [self previousContentViewControllerForCurrentIndex];;
    }
    return nil;
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    if (self.dataSource) {
        self.curlToward = GKCurlCalendarCurlTowardForward;
        return [self nextContentViewControllerForCurrentIndex];
    }
    return nil;
    
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 5;
//}
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}

#pragma mark delegate
// Sent when a gesture-initiated transition begins.
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
//    self.view.userInteractionEnabled = NO;
    _isAnimated = YES;

    switch (self.curlToward) {
        case GKCurlCalendarCurlTowardNone:
 
            break;
        case GKCurlCalendarCurlTowardForward:

            self.pageIndex += 1;
            break;
        case GKCurlCalendarCurlTowardBackward:

            self.pageIndex -= 1;
            
            break;
            
        default:
            break;
    }
    
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
//    self.view.userInteractionEnabled = YES;
    _isAnimated = NO;

    if (!completed) {
        
        switch (self.curlToward) {
            case GKCurlCalendarCurlTowardNone:

                break;
            case GKCurlCalendarCurlTowardForward:

                self.pageIndex -= 1;
                break;
            case GKCurlCalendarCurlTowardBackward:

                self.pageIndex += 1;
                
                break;
                
            default:
                break;
        }
        
    } else {
        
        _isAnimated = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
