//
//  SecondViewController.m
//  eye_test
//
//  Created by lam hung fat on 4/7/2017.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"
#import "ColorTextViewController.h"
#import "InformationViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gameStart:(id)sender {
    
    ViewController * vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (IBAction)textStart:(id)sender {
    ColorTextViewController * vc = [[ColorTextViewController alloc] initWithNibName:@"ColorTextViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)informationStart:(id)sender {
    InformationViewController * vc = [[InformationViewController alloc] initWithNibName:@"InformationViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
