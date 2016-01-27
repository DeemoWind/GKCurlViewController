//
//  GKCurlRootController.m
//  pageVCDemo
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "GKCurlRootController.h"

@interface GKCurlRootController ()

@property (nonatomic, strong) UIImageView * backgroundImageView;

@property (nonatomic, strong) NSLayoutConstraint * pageTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint * pageLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint * pageBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint * pageRightConstraint;

@end

@implementation GKCurlRootController
@synthesize pageViewController = _pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self commitBackgroundImageConstrains];
    
    [self commitPageViewContorllerConstrains];
    
}


#pragma mark - functionality
- (void)adjustContentInsets:(UIEdgeInsets)edgeInsets {
    CGFloat top = edgeInsets.top;
    CGFloat left = edgeInsets.left;
    CGFloat bottom = edgeInsets.bottom;
    CGFloat right = edgeInsets.right;
    
    [self adjustInsetsWithTop:top leftInset:left bottomInset:bottom rightInset:right];
}

- (void)adjustInsetsWithTop:(CGFloat)topInset leftInset:(CGFloat)leftInset bottomInset:(CGFloat)bottomInset rightInset:(CGFloat)rightInset {
    
    self.pageTopConstraint.constant = topInset;
    self.pageLeftConstraint.constant = leftInset;
    self.pageBottomConstraint.constant = bottomInset;
    self.pageRightConstraint.constant = rightInset;
    
    NSLog(@"changing~~");
    NSLog(@"%@",NSStringFromCGRect(self.pageViewController.view.frame));
    
    [self.view layoutIfNeeded];
}

#pragma mark - private method
- (void)commitBackgroundImageConstrains {
    
    UIImageView * tempPointer = self.backgroundImageView;
    // align _collectionView from the leading and trailing2
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tempPointer]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(self.view, tempPointer)]];
    
    // align _collectionView from the top and bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tempPointer]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(self.view, tempPointer)]];
}

- (void)commitPageViewContorllerConstrains {
    UIView * pageViewControllerView = self.pageViewController.view;
    pageViewControllerView.translatesAutoresizingMaskIntoConstraints = NO;

    // align _collectionView from the leading and trailing
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[pageViewControllerView]-8-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(self.view, pageViewControllerView)]];
//
//    // align _collectionView from the top and bottom
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[pageViewControllerView]-8-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(self.view, pageViewControllerView)]];
    self.pageTopConstraint = [NSLayoutConstraint constraintWithItem:pageViewControllerView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0];
    self.pageLeftConstraint = [NSLayoutConstraint constraintWithItem:pageViewControllerView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1.0
                                                            constant:0];
    self.pageBottomConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:pageViewControllerView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1.0
                                                              constant:0];
    self.pageRightConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:pageViewControllerView
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:0];
    [self.view addConstraints:@[self.pageTopConstraint,
                                self.pageLeftConstraint,
                                self.pageBottomConstraint,
                                self.pageRightConstraint]];
}

#pragma mark - getter & setter
- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];

        _pageViewController.delegate = self;

        _pageViewController.dataSource = self;

        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];

        [_pageViewController didMoveToParentViewController:self];
    }
    return _pageViewController;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _backgroundImageView.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}
#pragma mark datasource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    return nil;
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    

    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
@end
