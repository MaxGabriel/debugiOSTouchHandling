//
//  ViewController.m
//  TouchDebug
//
//  Created by Maximilian Tagher on 12/17/12.
//  Copyright (c) 2012 Max. All rights reserved.
//

#import "ViewController.h"
#import "UIView+TouchDebug.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 150, 150)];
//    test.bounds = CGRectMake(10, 10, 40, 40);
    test.backgroundColor = [UIColor blackColor];
    
    NSLog(@"Frame of test = %@",NSStringFromCGRect(test.frame));
    
    UIButton *test2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    NSLog(@"Frame of test2 = %@",NSStringFromCGRect(test2.frame));
    test2.frame = CGRectMake(100, 100, 150, 150);
    [self.view addSubview:test2];
    
    [self.view addSubview:test];
    [test2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [test2 performSelector:@selector(debugTouchHandling) withObject:nil afterDelay:2.0];
    
    
//    UIImageView *testImage = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [test2 addSubview:testImage];
    
//    NSLog(@"All subviews: %@",[self.view allSubviews]);
//    [test2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
//    [test performSelector:@selector(debugTouchHandling) withObject:nil afterDelay:2.0];
//    [test debugTouchHandling];
//    [test2 debugTouchHandling];
    
}

- (void)buttonPressed:(id)sender
{
    NSLog(@"<%@:%@:%d",[self class],NSStringFromSelector(_cmd),__LINE__);
}

@end
