//
//  GMViewController.m
//  GMEnvirSwitch
//
//  Created by ioszhanghui@163.com on 09/26/2019.
//  Copyright (c) 2019 ioszhanghui@163.com. All rights reserved.
//

#import "GMViewController.h"
#import "GMEnvirHeader.h"


@interface GMViewController ()

@end

@implementation GMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"currentEnvirType**%@",[GMEnvirSwitch currentEnvirType]);
    NSLog(@"currentEnvirConfig**%@",[GMEnvirSwitch currentEnvirConfig]);
    NSLog(@"getURLForModule**%@",[GMEnvirSwitch getURLForModule:@"首页"]);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
