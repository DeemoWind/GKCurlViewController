//
//  testContentViewController.m
//  pageVCDemo
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 zhishu. All rights reserved.
//

#import "testContentViewController.h"

@interface testContentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end

@implementation testContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indexLabel.text = [NSString stringWithFormat:@"%d",self.indexNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
