//
//  MyRootViewController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 10/11/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEViewController.h>
#import "MyRootViewController.h"
#import "MyFirstViewController.h"
#import "UMERedView.h"

@interface MyRootViewController ()
- (void)stop:(id)sender;
@end

@implementation MyRootViewController

- (id)init {
    if (self = [super initWithNibName:@"RootView" bundle:nil]) {
        self.title = @"Root";
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


//- (void)loadView {
//    self.view = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
//    [self.view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
//
//    NSButton *b = [[[NSButton alloc] initWithFrame:NSMakeRect(100, 200, 50, 20)] autorelease];
//    [b setButtonType:NSMomentaryChangeButton];
//    [b setTarget:self];
//    [b setAction:@selector(click:)];
//    [b setTitle:@"GOTO First"];
//    [self.view addSubview:b];


- (void)viewDidLoad {
    //    self.navigationItem.leftBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"Root Left" 
    //                                                                               style:UMEBarButtonItemStylePlain 
    //                                                                              target:self 
    //                                                                              action:@selector(home:)] autorelease];
    //    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    //    self.navigationItem.leftBarButtonItem = [[[UMEBarButtonItem alloc] initWithImage:[NSImage imageNamed:NSImageNameRefreshTemplate]
    //                                                                               style:UMEBarButtonItemStylePlain 
    //                                                                              target:nil 
    //                                                                              action:nil] autorelease];

    self.navigationItem.backBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"FOOOOOOOOOOOOOOOOOOOO"
                                                                               style:UMEBarButtonItemStyleBack 
                                                                              target:self 
                                                                              action:@selector(pop:)] autorelease];
    
    [self stop:nil];
    
    if (!self.navigationItem.rightBarButtonItem) {
        //        self.navigationItem.rightBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"Accounts" 
        //                                                                                    style:UMEBarButtonItemStylePlain 
        //                                                                                   target:self 
        //                                                                                   action:@selector(home:)] autorelease];
        self.navigationItem.rightBarButtonItem = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemUser
                                                                                                 target:self
                                                                                                 action:@selector(stop:)] autorelease];
    }
    
}


- (void)refresh:(id)sender {
    //self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.leftBarButtonItem = [[[UMEActivityBarButtonItem alloc] initWithTitle:nil style:UMEBarButtonItemStylePlain target:self action:@selector(stop:)] autorelease];
    self.title = @"fooooo";
}


- (void)stop:(id)sender {
    self.navigationItem.leftBarButtonItem = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemRefresh
                                                                                            target:self
                                                                                            action:@selector(refresh:)] autorelease];
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
    MyFirstViewController *vc = [[[MyFirstViewController alloc] init] autorelease];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)home:(id)sender {
    UMEViewController *vc = [[[MyRootViewController alloc] init] autorelease];
    
    vc.navigationItem.rightBarButtonItem = [[[UMEBarButtonItem alloc] initWithTitle:@"Dismiss" 
                                                                              style:UMEBarButtonItemStyleDone 
                                                                             target:self 
                                                                             action:@selector(dismiss:)] autorelease];
    
    UMENavigationController *nc = [[[UMENavigationController alloc] initWithRootViewController:vc] autorelease];
    
    [self.navigationController presentModalViewController:nc animated:YES];
}


- (IBAction)dismiss:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
