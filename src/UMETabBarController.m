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

#import <UMEKit/UMETabBarController.h>
#import <UMEKit/UMENavigationController.h>
#import <UMEKit/UMETabBar.h>
#import <UMEKit/UMETabBarItem.h>
#import "UMEFlippedView.h"

#define TABBAR_HEIGHT 50.0
#define NAVBAR_HEIGHT 44.0
#define TABBAR_ITEM_MARGIN_X 1.5

@interface UMETabBarItem ()
@property (nonatomic, retain) NSButton *button;
@end

@interface UMENavigationController ()
@property (nonatomic, readonly, retain) NSView *containerView;
@end

@interface UMETabBarController ()
- (void)resizeViewsForTabBarUpDownChangeAnimated:(BOOL)animated;
- (void)resizeViewsForTabBarLeftRightChangeAnimated:(BOOL)animated;
- (void)tabBarLeftRightAnimationDidStop:(NSString *)s finished:(NSNumber *)n context:(void *)ctx;
- (void)tabBarUpDownAnimationDidStop:(NSString *)s finished:(NSNumber *)n context:(void *)ctx;
- (void)layoutSubviews;
- (void)layoutTabBarItems;
- (void)setUpTabBarItems;
- (void)highlightButtonAtIndex:(NSInteger)i;

@property (nonatomic, readwrite, retain) UMETabBar *tabBar;
@property (nonatomic, retain) NSArray *tabBarItems;
@property (nonatomic, retain) UMETabBarItem *selectedTabBarItem;
@end

@implementation UMETabBarController

- (id)init {
    if (self = [super init]) {
        selectedIndex = -1;
    }
    return self;
}


- (void)dealloc {
    [tabBar removeFromSuperview];
    [containerView removeFromSuperview];
    
    for (UMETabBarItem *item in tabBarItems) {
        [item.button removeFromSuperview];
    }

    self.tabBar = nil;
    self.containerView = nil;
    self.delegate = nil;
    self.viewControllers = nil;
    self.selectedViewController = nil;
    self.tabBarItems = nil;
    self.selectedTabBarItem = nil;
    [super dealloc];
}


- (void)loadView {
    self.view = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
    [self.view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [self.view setWantsLayer:YES];
    
    self.tabBar = [[[UMETabBar alloc] initWithFrame:NSMakeRect(0, 0, 0, TABBAR_HEIGHT)] autorelease];
    [tabBar setAutoresizingMask:NSViewWidthSizable|NSViewMinYMargin];
    [self.view addSubview:tabBar];
    
    self.containerView = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
    [self.containerView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [self.view addSubview:containerView];
    
    [self highlightButtonAtIndex:0];
    [self viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self layoutSubviews];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.selectedViewController = nil; // this will trigger -viewWillDisappear: & -viewDidDisappear on the selectedView controller when this tabbarcontroller is popped. 
                                       // this is desireable.
}


- (IBAction)tabBarItemClick:(id)sender {
    //NSParameterAssert([tabBarItems containsObject:sender]);
    NSInteger i = -1;
    for (UMETabBarItem *item in tabBarItems) {
        i++;
        if (item.button == sender) break;
    }
    self.selectedIndex = i;
    [self highlightButtonAtIndex:i]; // force
}


- (void)hideTabBarBySlidingDown:(BOOL)animated {
    if (tabBarHidden) return;
    
    tabBarHidden = YES;
    [self resizeViewsForTabBarUpDownChangeAnimated:animated];
}


- (void)showTabBarBySlidingUp:(BOOL)animated {
    if (!tabBarHidden) return;
    
    tabBarHidden = NO;
    [self resizeViewsForTabBarUpDownChangeAnimated:animated];
}


- (void)hideTabBarBySlidingLeft:(BOOL)animated {
    if (tabBarHidden) return;
    
    tabBarHidden = YES;
    [self resizeViewsForTabBarLeftRightChangeAnimated:animated];
}


- (void)showTabBarBySlidingRight:(BOOL)animated {
    if (!tabBarHidden) return;
    
    tabBarHidden = NO;
    [self resizeViewsForTabBarLeftRightChangeAnimated:animated];
}


- (void)resizeViewsForTabBarUpDownChangeAnimated:(BOOL)animated {
    CGFloat delta = TABBAR_HEIGHT; //tabBar.frame.size.height;
    NSRect appFrame = [self.view bounds];
    
    NSRect tabBarStartFrame, tabBarEndFrame;
    if (tabBarHidden) {
        tabBarStartFrame = tabBar.frame;
        tabBarEndFrame = NSOffsetRect(tabBarStartFrame, 0, delta);
    } else {
        tabBarStartFrame = NSMakeRect(0, appFrame.size.height, appFrame.size.width, tabBar.frame.size.height);
        tabBarEndFrame = NSOffsetRect(tabBarStartFrame, 0, -delta);
        if (animated) {
            tabBar.frame = tabBarStartFrame;
        }
    }
    
        // if hiding, resize the viewController's viewFrame BEFORE the animation.
    if (tabBarHidden) {
        [self layoutSubviews];
    }
    
    if (animated) {

    }
    
    tabBar.frame = tabBarEndFrame;
    
    if (animated) {

    }
}


- (void)resizeViewsForTabBarLeftRightChangeAnimated:(BOOL)animated {
    CGFloat delta = tabBar.frame.size.width;
    NSRect appFrame = [self.view bounds];
    
    NSRect tabBarStartFrame, tabBarEndFrame;
    
    if (tabBarHidden) {
        tabBarStartFrame = tabBar.frame;
        tabBarEndFrame = NSOffsetRect(tabBarStartFrame, -delta, 0);
    } else {
        tabBarStartFrame = NSMakeRect(-appFrame.size.width, appFrame.size.height - tabBar.frame.size.height, appFrame.size.width, tabBar.frame.size.height);
        tabBarEndFrame = NSOffsetRect(tabBarStartFrame, delta, 0);
        if (animated) {
            tabBar.frame = tabBarStartFrame;
        }
    }
    
        // if hiding, resize the viewController's viewFrame BEFORE the animation.
    if (tabBarHidden) {
        [self layoutSubviews];
    }
    
    if (animated) {

    }
    
    tabBar.frame = tabBarEndFrame;
    
    if (animated) {

    }
}


- (void)tabBarLeftRightAnimationDidStop:(NSString *)s finished:(NSNumber *)n context:(void *)ctx {
        // if showing, resize the viewController's viewFrame AFTER the animation.
    if (!tabBarHidden) {
        [self layoutSubviews];
    }
}


- (void)tabBarUpDownAnimationDidStop:(NSString *)s finished:(NSNumber *)n context:(void *)ctx {
    if (!tabBarHidden) {
        [self layoutSubviews];
    }
}


- (void)layoutSubviews {
    NSRect r = [self.view bounds];
    
    if (!tabBarHidden) {
        r.size.height -= TABBAR_HEIGHT;
    }
    
    [containerView setFrame:r];
    [selectedViewController.view setFrame:[containerView bounds]];
    
    UMENavigationController *nc = nil;
    if ([selectedViewController isKindOfClass:[UMENavigationController class]]) {
        NSRect r2 = NSOffsetRect(r, 0, NAVBAR_HEIGHT);
        r2.size.height -= NAVBAR_HEIGHT;
        nc = (UMENavigationController *)selectedViewController;
        [nc.containerView setFrame:r2];
        [nc.topViewController.view setFrame:[nc.containerView bounds]];
    }
    
    [tabBar setFrame:NSMakeRect(0, r.size.height, r.size.width, TABBAR_HEIGHT)];
    [self layoutTabBarItems];
}


#pragma mark -
#pragma mark Properties

- (void)setSelectedIndex:(NSUInteger)i {
    NSParameterAssert(0 == i || i < [viewControllers count]);
    if (i == selectedIndex) return;
    
    selectedIndex = i;
    self.selectedViewController = [viewControllers objectAtIndex:i];
}


- (void)setSelectedViewController:(UMEViewController *)vc {
    NSParameterAssert(nil == vc || [viewControllers containsObject:vc]);
    
    if (selectedViewController && vc == selectedViewController) {
        return; // Dont re-show the same view controller
    }
    
    if (delegate && [delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![delegate tabBarController:self shouldSelectViewController:selectedViewController]) {
            return;
        }
    }
    
    if (selectedViewController) {
        [selectedViewController viewWillDisappear:NO];
        [selectedViewController.view removeFromSuperview];
        [selectedViewController viewDidDisappear:NO];
    }
    
    selectedIndex = [viewControllers indexOfObject:vc];
    selectedViewController = vc;
        
    if (delegate && [delegate respondsToSelector:@selector(tabBarController:willSelectViewController:)]) {
        [delegate tabBarController:self willSelectViewController:selectedViewController];
    }
    
    [self view]; // trigger view load if necessary

    [selectedViewController.view setFrame:[containerView bounds]];
    
    [selectedViewController viewWillAppear:NO];
    [containerView addSubview:selectedViewController.view];
    [selectedViewController viewDidAppear:NO];
    
    [self highlightButtonAtIndex:selectedIndex];
    
    if (delegate && [delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [delegate tabBarController:self didSelectViewController:selectedViewController]; // TODO NO?
    }
}


- (void)setViewControllers:(NSArray *)vcs animated:(BOOL)animated {
    self.viewControllers = (id)vcs;
}


- (void)setViewControllers:(NSArray *)vcs {
    if (viewControllers != vcs) {
        [viewControllers release];
        viewControllers = [vcs copy];
        self.selectedIndex = 0;
        
        for (UMEViewController *vc in vcs) {
            if ([vc isKindOfClass:[UMENavigationController class]]) {
                UMENavigationController *nc = (UMENavigationController *)vc;
                [nc setDelegate:self];
            }
        }
        
        [self setUpTabBarItems];
    }
}


#pragma mark -
#pragma mark UMENavigationControllerDelegate

- (void)navigationController:(UMENavigationController *)nc willShowViewController:(UMEViewController *)vc animated:(BOOL)animated {
    if (vc.hidesBottomBarWhenPushed) {
        [self hideTabBarBySlidingLeft:YES];
    } else {
        [self showTabBarBySlidingRight:YES];
    }

    [self layoutSubviews];
}


- (void)navigationController:(UMENavigationController *)nc didShowViewController:(UMEViewController *)vc animated:(BOOL)animated {
    [self layoutSubviews];
}


- (void)setUpTabBarItems {
    NSInteger c = [viewControllers count];
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:c];
    
    if (c > 0) {
        NSInteger tag = 0;
        for (UMEViewController *vc in viewControllers) {
            
            UMETabBarItem *item = [vc tabBarItem];
            if (!item) {
                item = [[[UMETabBarItem alloc] initWithTitle:vc.title image:nil tag:tag++] autorelease];
            }

            [item.button setAutoresizingMask:NSViewWidthSizable|NSViewMinXMargin|NSViewMaxXMargin];
            [item.button setTarget:self];
            [item.button setAction:@selector(tabBarItemClick:)];
            
            [tabBar addSubview:item.button];
            [items addObject:item];
        }
    }
    
    self.tabBarItems = [[items copy] autorelease];
}


- (void)layoutTabBarItems {
    NSInteger c = [tabBarItems count];
    
    if (c > 0) {
        NSInteger i = 0;
        CGFloat x = TABBAR_ITEM_MARGIN_X;
        CGFloat totalWidth = NSWidth([tabBar bounds]) - (TABBAR_ITEM_MARGIN_X * 2);
        CGFloat w = totalWidth / c;
        CGFloat h = NSHeight([tabBar bounds]);
        for (UMETabBarItem *item in tabBarItems) {
            if (selectedIndex == i) {
                [self highlightButtonAtIndex:i];
            }
            i++;
            [item.button setFrame:NSMakeRect(x, 0, w, h)];
            x += w;
        }
    }
}


- (void)highlightButtonAtIndex:(NSInteger)i {
    if (i < 0 || i > [tabBarItems count] - 1) {
        return;
    }

    UMETabBarItem *newItem = [tabBarItems objectAtIndex:i];
    
    if (selectedTabBarItem != newItem) {
        [selectedTabBarItem.button setState:NSOffState];
        self.selectedTabBarItem = newItem;
    }
    [selectedTabBarItem.button setState:NSOnState];
}


@synthesize tabBar;
@synthesize containerView;
@synthesize delegate;
@synthesize viewControllers;
@synthesize selectedViewController;
@synthesize selectedIndex;
@synthesize tabBarItems;
@synthesize selectedTabBarItem;
@end
