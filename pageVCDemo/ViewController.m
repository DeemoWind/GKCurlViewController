//
//  ViewController.m
//  pageVCDemo
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "ViewController.h"
#import "GKCurlOverPageController.h"

@interface ViewController ()<GKCurlOverPageControllerDelegate, GKCurlOverPageControllerDataSource>
{
    int pageIndex;
    int directionForward;
}
@property (nonatomic, strong) GKCurlOverPageController * pageViewController;
@property (nonatomic, strong) NSMutableArray * contentVC;

@end

enum DirectionForward {
    DirectionForwardBefore = 1,
    DirectionForwardAfter
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageIndex = 0;

    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.pageViewController.delegate = self;
    
    self.pageViewController.dataSource = self;
    
    UIView * pageViewControllerView = self.pageViewController.view;
    pageViewControllerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[pageViewControllerView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view, pageViewControllerView)]];
    
    // align _collectionView from the top and bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[pageViewControllerView]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view, pageViewControllerView)]];
    
    NSLog(@"%@",NSStringFromCGRect(self.pageViewController.view.frame));

    
    UIViewController * vc = [self.contentVC firstObject];
    NSLog(@"%@",vc);
    NSArray * content1VCs = @[self.contentVC[0]];
    
    [self.pageViewController setCalendarPage:vc animated:YES completion:^(BOOL finished) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GKCurlOverPageController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[GKCurlOverPageController alloc] init];;

//        _pageViewController.delegate = self;
//        _pageViewController.dataSource = self;
        
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
//        _pageViewController.view.frame = CGRectMake(50, 50, self.view.frame.size.width - 100, self.view.frame.size.height - 100);
        
        _pageViewController.view.backgroundColor = [UIColor cyanColor];
        
        [_pageViewController didMoveToParentViewController:self];
    }
    return _pageViewController;
}

- (NSMutableArray *)contentVC {
    if (!_contentVC) {
        _contentVC = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 4; ++i) {
            UIViewController * tempVC = [self.storyboard instantiateViewControllerWithIdentifier:@"imageVC"];
            [_contentVC addObject:tempVC];
            switch (i%3) {
                case 0:
                    tempVC.view.backgroundColor = [UIColor redColor];
                    break;
                case 1:
                    tempVC.view.backgroundColor = [UIColor greenColor];
                    break;
                case 2:
                    tempVC.view.backgroundColor = [UIColor yellowColor];
                    break;
                default:
                    break;
            }
            
            
        }
        
    }
    return _contentVC;
}

#pragma mark - pageVC delegate and datesource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    pageIndex--;
    if (pageIndex < 0) {
        pageIndex = 0;
        return nil;
    }
    
    return [self contentVCAtIndex:pageIndex];
    
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    pageIndex++;
    if (pageIndex >= self.contentVC.count) {
        pageIndex = (int)self.contentVC.count - 1;
        return nil;
    }
  
    return [self contentVCAtIndex:pageIndex];
}
- (nullable UIViewController *)curlOverPage:(GKCurlOverPageController * __nullable)calendarPage previousViewControllerForViewController:(UIViewController * __nullable)viewcontroller {
    NSLog(@"%s - > %d",__func__,pageIndex);
    pageIndex--;
    if (pageIndex < 0) {
        pageIndex = 0;
        return nil;
    }
    NSLog(@"%s - > %d",__func__,pageIndex);
    return [self contentVCAtIndex:pageIndex];
}
- (nullable UIViewController *)curlOverPage:(GKCurlOverPageController * __nullable)calendarPage nextViewControllerForViewController:(UIViewController * __nullable)viewcontroller {
    NSLog(@"%s - > %d",__func__,pageIndex);
    pageIndex++;
    if (pageIndex > self.contentVC.count) {
        pageIndex = (int)self.contentVC.count;
        return nil;
    }
    NSLog(@"%s - > %d",__func__,pageIndex);
    return [self contentVCAtIndex:pageIndex];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return self.contentVC.count;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {

    return UIPageViewControllerSpineLocationMin;
}


- (UIViewController *)contentVCAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.contentVC.count) {
        return nil;
    }
    
    return self.contentVC[index];
}

- (IBAction)next:(UIButton *)sender {
    
    UIViewController * vc = [self.contentVC objectAtIndex:pageIndex];
    NSLog(@"%@",vc);
    
    
    [self.pageViewController setCalendarPage:vc animated:YES completion:^(BOOL finished) {
        
    }];
    pageIndex++;

}
- (IBAction)pre:(UIButton *)sender {
}

@end
