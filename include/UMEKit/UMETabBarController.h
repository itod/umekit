//
//  UMETabBarController.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEViewController.h>
#import <UMEKit/UMENavigationController.h>

@class UMETabBar;
@protocol UMETabBarControllerDelegate;

@interface UMETabBarController : UMEViewController <UMENavigationControllerDelegate> {
    UMETabBar *tabBar;
    NSView *containerView;
    
    id <UMETabBarControllerDelegate>delegate;

    NSArray *viewControllers;
    UMEViewController *selectedViewController;
    NSUInteger selectedIndex;

    BOOL tabBarHiddenBottom;
    BOOL tabBarHiddenLeft;
    BOOL tabBarHidden;
    
    NSArray *tabBarItems;
    UMETabBarItem *selectedTabBarItem;
}

- (void)setViewControllers:(NSArray *)vcs animated:(BOOL)animated;

@property (nonatomic, readonly, retain) UMETabBar *tabBar; // Provided for -[UIActionSheet showFromTabBar:]. Attempting to modify the contents of the tab bar directly will throw an exception.
@property (nonatomic, retain) NSView *containerView;
@property (nonatomic, assign) id <UMETabBarControllerDelegate>delegate;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) UMEViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;
@end

@protocol UMETabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(UMETabBarController *)tabBarController shouldSelectViewController:(UMEViewController *)viewController;
- (void)tabBarController:(UMETabBarController *)tabBarController willSelectViewController:(UMEViewController *)viewController;
- (void)tabBarController:(UMETabBarController *)tabBarController didSelectViewController:(UMEViewController *)viewController;
@end
