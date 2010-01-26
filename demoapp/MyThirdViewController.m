//
//  MyThirdViewController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/14/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "MyFirstViewController.h"
#import "MySecondViewController.h"
#import "MyThirdViewController.h"

@implementation MyThirdViewController

- (id)init {
    if (self = [super initWithNibName:@"ThirdView" bundle:nil]) {
        self.title = @"Third";
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


- (void)viewDidLoad {
    [button setTitle:@"Pop to Root"];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
