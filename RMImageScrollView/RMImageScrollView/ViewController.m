//
//  ViewController.m
//  RMImageScrollView
//
//  Created by JianRongCao on 1/6/16.
//  Copyright © 2016 JianRongCao. All rights reserved.
//

#import "ViewController.h"
#import "RMImageScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RMImageScrollView *scroller = [[RMImageScrollView alloc] init];
    scroller.image = [UIImage imageNamed:@"1"];
    [self.view addSubview:scroller];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
