//
//  ViewController.m
//  LoopView
//
//  Created by cnsue on 2017/3/21.
//  Copyright © 2017年 cnsue. All rights reserved.
//

#import "ViewController.h"
#import "LoopView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    LoopView *loopView = [[LoopView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    loopView.imageArr = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self.view addSubview:loopView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
