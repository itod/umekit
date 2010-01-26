//
//  MySecondViewController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/14/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "MyFirstViewController.h"
#import "MySecondViewController.h"
#import "MyThirdViewController.h"

@implementation MySecondViewController

- (id)init {
    if (self = [super initWithNibName:@"SecondView" bundle:nil]) {
        self.title = @"Second";
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


- (void)viewDidLoad {
    [button setTitle:@"GOTO Third"];
}


- (void)viewDidUnload {
    
}


- (void)viewWillAppear:(BOOL)animated {
    
}


- (void)viewDidAppear:(BOOL)animated {
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
}


- (void)viewDidDisappear:(BOOL)animated {
    
}


- (IBAction)click:(id)sender {
    MyThirdViewController *vc = [[[MyThirdViewController alloc] init] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)home:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
