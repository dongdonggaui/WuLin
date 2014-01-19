//
//  WLSelectorViewController.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLSelectorViewController.h"

@interface WLSelectorViewController ()

@end

@implementation WLSelectorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"x" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.rightBarButtonItem = closeItem;
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage *image = [UIImage imageNamed:@"nav_close"];
//    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = closeItem;
//    [self.navigationController.navigationBar sizeThatFits:self.view.frame.size];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)dismiss
{
    [self.view.superview removeFromSuperview];
}

@end
