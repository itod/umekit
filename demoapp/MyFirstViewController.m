//
//  MyViewController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/30/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "MyFirstViewController.h"
#import "MySecondViewController.h"
#import "MyThirdViewController.h"

@implementation MyFirstViewController

- (id)init {
    if (self = [super initWithNibName:@"FirstView" bundle:nil]) {
        self.title = @"First";
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


- (void)viewDidLoad {
//    self.navigationItem.leftBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"1 left" 
//                                                                               style:UMEBarButtonItemStylePlain 
//                                                                              target:self 
//                                                                              action:@selector(back:)] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"BARRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR" 
                                                                                style:UMEBarButtonItemStylePlain 
                                                                               target:self 
                                                                               action:@selector(home:)] autorelease];
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
//    MyFirstViewController *vc = [[[MyFirstViewController alloc] init] autorelease];
//    [self.navigationController pushViewController:vc animated:YES];

    MySecondViewController *vc = [[[MySecondViewController alloc] init] autorelease];
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
