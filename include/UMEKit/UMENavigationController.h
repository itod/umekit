//
//  UMENavigationController.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEViewController.h>
#import <UMEKit/UMEGeometry.h>

@class UMENavigationBar;
@protocol UMENavigationControllerDelegate;

typedef enum {
	UMEModalTransitionStyleCoverVertical = 0,
//	UMEModalTransitionStyleFlipHorizontal = 1,
    UMEModalTransitionStyleCrossDissolve = 2
} UMEModalTransitionStyle;

@interface UMENavigationController : UMEViewController {
    NSView *containerView;
    UMENavigationBar *navigationBar;
    
    UMEEdgeInsets currentScrollContentInsetDelta;
    UMEEdgeInsets previousScrollContentInsetDelta;
    CGFloat previousScrollContentOffsetDelta;
    CGFloat bottomInsetDelta;
    
    NSMutableArray *viewControllers;    
    UMEViewController *modalViewController;
    UMEModalTransitionStyle modalTransitionStyle;
    
    id <UMENavigationControllerDelegate>delegate;
        
    BOOL navigationBarHidden;
    UMEViewController *topViewController;
    
    NSDictionary *pushAnimations;
    NSDictionary *popAnimations;
    
    BOOL hasAppeared;
}

- (id)initWithRootViewController:(UMEViewController *)rootViewController;

- (void)pushViewController:(UMEViewController *)viewController animated:(BOOL)animated;

- (UMEViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray *)popToViewController:(UMEViewController *)viewController animated:(BOOL)animated;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

@property (nonatomic, readonly, retain) UMEViewController *topViewController;
@property (nonatomic, readonly) UMEViewController *visibleViewController;

@property (nonatomic, retain) NSArray *viewControllers;
- (void)setViewControllers:(NSArray *)vcs animated:(BOOL)animated; // If animated is YES, then simulate a push or pop depending on whether the new top view controller was previously in the stack.

@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated; // Hide or show the navigation bar. If animated, it will transition vertically using UMENavigationControllerHideShowBarDuration.
@property (nonatomic, readonly, retain) UMENavigationBar *navigationBar; // The navigation bar managed by the controller. Pushing, popping or setting navigation items on a managed navigation bar is not supported.

@property (nonatomic, assign) id<UMENavigationControllerDelegate> delegate;

- (void)presentModalViewController:(UMEViewController *)vc animated:(BOOL)animated;
- (void)dismissModalViewControllerAnimated:(BOOL)animated;

@property (nonatomic, readonly, retain) UMEViewController *modalViewController;
@property (nonatomic, assign) UMEModalTransitionStyle modalTransitionStyle;
@end

@protocol UMENavigationControllerDelegate <NSObject>
@optional
// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UMENavigationController *)navigationController willShowViewController:(UMEViewController *)viewController animated:(BOOL)animated;
- (void)navigationController:(UMENavigationController *)navigationController didShowViewController:(UMEViewController *)viewController animated:(BOOL)animated;
@end
