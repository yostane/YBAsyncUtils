//
//  ViewController.m
//  YBAsyncUtilsTestAppObjC
//
//  Created by yassine benabbas on 20/03/2016.
//  Copyright © 2016 yostane. All rights reserved.
//

#import "ViewController.h"
#import "YBAsyncUtilsTestAppObjC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [YBDispatchUtils runAsync:^{
        NSLog(@"start 1");
        sleep(1);
        NSLog(@"end 1");
    }];
    
    [YBDispatchUtils runAsync:^{
        NSLog(@"start 2");
        sleep(1);
        NSLog(@"end 2");
    } uiCompletionBlock:^{
        NSLog(@"i am on ui thread 2");
    }];

    
    [YBDispatchUtils runAsync:^{
        NSLog(@"start 3");
        sleep(1);
        NSLog(@"end 3");
        [YBDispatchUtils runOnUIAsync:^{
            NSLog(@"i am on ui thread 3");
        }];
        NSLog(@"Done 3");
    }];
    
    [YBDispatchUtils runAsync:^{
        NSLog(@"start 4");
        sleep(1);
        NSLog(@"end 4");
        [YBDispatchUtils runOnUISync:^{
            NSLog(@"i am on ui thread 4");
        }];
        NSLog(@"Done 4");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
