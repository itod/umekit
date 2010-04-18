//  Copyright 2010 Todd Ditchendorf
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
    
    
    NSMutableArray *items = [NSMutableArray array];
    UMEBarButtonItem *item = nil;
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemCamera target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemCompose target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemReply target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemRedo target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemRewind target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemRefresh target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemEdit target:nil action:nil] autorelease];
    [items addObject:item];
    
    item = [[[UMEBarButtonItem alloc] initWithBarButtonSystemItem:UMEBarButtonSystemItemDone target:nil action:nil] autorelease];
    [items addObject:item];
    
    toolbar.barStyle = UMEBarStyleBlack;
    toolbar.items = items;
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
