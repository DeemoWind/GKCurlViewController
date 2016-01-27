//
//  ViewControllerTwo.m
//  pageVCDemo
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "GKCurlCalendarController.h"
#import "testContentViewController.h"

@interface ViewControllerTwo ()<GKCurlCalendarControllerDataSource, GKCurlCalendarControllerDelegate>

@property (nonatomic, strong) GKCurlCalendarController * curlCalendarController;
@property (nonatomic, strong) NSMutableArray * contentVC;
@property (weak, nonatomic) IBOutlet UISlider *adjustPageInsetsSlider;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *testConstraint;

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView * curlCalendarControllerView = self.curlCalendarController.view;
    curlCalendarControllerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[curlCalendarControllerView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view, curlCalendarControllerView)]];
    
    // align _collectionView from the top and bottom
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[curlCalendarControllerView]-70-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view, curlCalendarControllerView)]];
    
    [self.curlCalendarController curlOverTowardCalendarPageAtIndex:1 animated:YES completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (GKCurlCalendarController *)curlCalendarController {
    if (!_curlCalendarController) {
        _curlCalendarController = [[GKCurlCalendarController alloc] init];
        self.curlCalendarController.delegate = self;
        self.curlCalendarController.dataSource = self;
        
        [self addChildViewController:_curlCalendarController];
        [self.view addSubview:_curlCalendarController.view];
        
        _curlCalendarController.view.backgroundColor = [UIColor cyanColor];
        
        [_curlCalendarController didMoveToParentViewController:self];
    }
    return _curlCalendarController;
}

- (NSMutableArray *)contentVC {
    if (!_contentVC) {
        _contentVC = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; ++i) {
            testContentViewController * tempVC = [self.storyboard instantiateViewControllerWithIdentifier:@"imageVC"];
            
            tempVC.indexNumber = i;
            
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
- (IBAction)slidering:(UISlider *)sender {
//    NSLog(@"%lf",sender.value);
    CGFloat insetValue = 150*sender.value;
    
    self.testConstraint.constant = insetValue * 2;
    
    [self.curlCalendarController adjustContentInsets:UIEdgeInsetsMake(insetValue,
                                                                       insetValue,
                                                                       insetValue,
                                                                       insetValue)];
}

#pragma mark - GKCurlCalendar delegate & dataSource
- (NSInteger)numberOfPageInCurlCalendar:(GKCurlCalendarController *)curlCalendar {
    NSLog(@"two contentVC count %ld",self.contentVC.count);
    return self.contentVC.count;
    
}

- (UIViewController *)curlCalendar:(GKCurlCalendarController *)curlCalendar pageViewControllerAtIndex:(NSInteger)index {
    return self.contentVC[index];
}

@end
