//
//  UMEViewController.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UMETabBarItem;
@class UMENavigationItem;
@class UMENavigationController;
@class UMETabBarItem;
@class UMETabBarController;

@interface UMEViewController : NSObject {
@package
    NSView *view;
    NSString *title;
    NSString *nibName;
    NSBundle *nibBundle;
    UMEViewController *parentViewController; // Nonretained
    BOOL hidesBottomBarWhenPushed;
    UMENavigationItem *navigationItem;
    UMENavigationController *navigationController;
    UMETabBarItem *tabBarItem;
    UMETabBarController *tabBarController;
}

- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle;

- (void)loadView;
- (void)viewDidLoad;
- (void)viewDidUnload;
- (BOOL)isViewLoaded;

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@property (nonatomic, retain) IBOutlet NSView *view;
@property (nonatomic, readonly, copy) NSString *nibName;
@property (nonatomic, readonly, retain) NSBundle *nibBundle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) UMEViewController *parentViewController; // If this view controller is inside a navigation controller or tab bar controller, or has been presented modally by another view controller, return it.

// UMENavigationController
@property (nonatomic, readonly, retain) UMENavigationItem *navigationItem;
@property (nonatomic) BOOL hidesBottomBarWhenPushed; // If YES, then when this view controller is pushed into a controller hierarchy with a bottom bar (like a tab bar), the bottom bar will slide out. Default is NO.
@property (nonatomic, readonly, retain) UMENavigationController *navigationController; // If this view controller has been pushed onto a navigation controller, return it.

// UMETabBarController
@property (nonatomic, retain) UMETabBarItem *tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.
@property (nonatomic, readonly, retain) UMETabBarController *tabBarController; // If the view controller has a toolbar controller as its ancestor, return it. Returns nil otheriwse.
@end
