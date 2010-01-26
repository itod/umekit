//
//  DemoAppDelegate.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/30/09.
//  Copyright 2009 Yahoo! Inc.. All rights reserved.
//

#import "DemoAppDelegate.h"
#import "MyRootViewController.h"
#import "MyFirstViewController.h"
#import "MySecondViewController.h"
#import <UMEKit/UMEKit.h>

@implementation DemoAppDelegate

- (void)dealloc {
    self.tabBarController = nil;
    [super dealloc];
}


- (void)awakeFromNib {
    UMEViewController *vc1 = [[[MyRootViewController alloc] init] autorelease];
    UMENavigationController *nc1 = [[[UMENavigationController alloc] initWithRootViewController:vc1] autorelease];
    nc1.title = @"One";
    nc1.tabBarItem = [[[UMETabBarItem alloc] initWithTabBarSystemItem:UMETabBarSystemItemMostRecent tag:1] autorelease];
    
    UMEViewController *vc2 = [[[MyRootViewController alloc] init] autorelease];
    UMENavigationController *nc2 = [[[UMENavigationController alloc] initWithRootViewController:vc2] autorelease];
    nc2.title = @"Two";
    nc2.tabBarItem = [[[UMETabBarItem alloc] initWithTabBarSystemItem:UMETabBarSystemItemFavorites tag:2] autorelease];

    UMEViewController *vc3 = [[[MyRootViewController alloc] init] autorelease];
    UMENavigationController *nc3 = [[[UMENavigationController alloc] initWithRootViewController:vc3] autorelease];
    nc3.title = @"Three";
    nc3.tabBarItem = [[[UMETabBarItem alloc] initWithTabBarSystemItem:UMETabBarSystemItemMostViewed tag:3] autorelease];
    
    UMEViewController *vc4 = [[[MyRootViewController alloc] init] autorelease];
    UMENavigationController *nc4 = [[[UMENavigationController alloc] initWithRootViewController:vc4] autorelease];
    nc4.title = @"Four";
    nc4.tabBarItem = [[[UMETabBarItem alloc] initWithTabBarSystemItem:UMETabBarSystemItemRecents tag:4] autorelease];
    
    UMEViewController *vc5 = [[[MyRootViewController alloc] init] autorelease];
    UMENavigationController *nc5 = [[[UMENavigationController alloc] initWithRootViewController:vc5] autorelease];
    nc5.title = @"Three";
    nc5.tabBarItem = [[[UMETabBarItem alloc] initWithTabBarSystemItem:UMETabBarSystemItemContacts tag:5] autorelease];
    
    self.tabBarController= [[[UMETabBarController alloc] init] autorelease];
    tabBarController.viewControllers = [NSArray arrayWithObjects:nc1, nc2, nc3, nc4, nc5, nil];

    NSView *view = tabBarController.view;
    [view setFrame:[[window contentView] bounds]];
    
    [tabBarController viewWillAppear:NO];
    [[window contentView] addSubview:view];
    [tabBarController viewDidAppear:NO];
}

@synthesize tabBarController;
@end
