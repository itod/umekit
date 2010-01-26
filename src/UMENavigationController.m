//
//  UMENavigationController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMENavigationController.h>
#import <UMEKit/UMENavigationBar.h>
#import <UMEKit/UMEBarItem.h>
#import <UMEKit/UMEBarButtonItem.h>
#import <QuartzCore/QuartzCore.h>
#import "UMEFlippedView.h"

#define NAVBAR_HEIGHT 44

@interface UMEViewController ()
@property (nonatomic, readwrite, assign) UMEViewController *parentViewController;
@property (nonatomic, readwrite, retain) UMENavigationController *navigationController;
@end

@interface UMENavigationController ()
- (void)addBackBarButtonItemTo:(UMEViewController *)vc;

- (void)setLastViewControllerAsTop;
- (UMEViewController *)unsetLastViewControllerAsTop;

- (void)replaceViewController:(UMEViewController *)oldvc with:(UMEViewController *)newvc isPush:(BOOL)isPush animated:(BOOL)animated;
- (CAAnimation *)pushAnimation;
- (CAAnimation *)popAnimation;    

- (void)modalParentView:(NSView *)parentView transitionIn:(BOOL)transitionIn from:(NSView *)oldView to:(NSView *)newView animated:(BOOL)animated;
- (CAAnimation *)coverVerticalInAnimation;
- (CAAnimation *)coverVerticalOutAnimation;
- (CAAnimation *)crossDissolveAnimation;

@property (nonatomic, retain) NSView *containerView;
@property (nonatomic, readwrite, retain) UMEViewController *topViewController;
@property (nonatomic, readwrite, retain) UMENavigationBar *navigationBar;
@property (nonatomic, readwrite, retain) UMEViewController *modalViewController;

@property (nonatomic, retain) NSDictionary *pushAnimations;
@property (nonatomic, retain) NSDictionary *popAnimations;
@end

@implementation UMENavigationController

- (id)init {
    return [self initWithRootViewController:nil];
}


- (id)initWithRootViewController:(UMEViewController *)rootViewController {
    NSParameterAssert(rootViewController);
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewControllers = [NSMutableArray array];
        
        self.pushAnimations = [NSDictionary dictionaryWithObject:[self pushAnimation] forKey:@"subviews"];
        self.popAnimations  = [NSDictionary dictionaryWithObject:[self popAnimation]  forKey:@"subviews"];
        
        self.modalTransitionStyle = UMEModalTransitionStyleCoverVertical;

        [self pushViewController:rootViewController animated:NO];
    }
    return self;    
}


- (void)dealloc {
    [containerView removeFromSuperview];
    [navigationBar removeFromSuperview];
    self.containerView = nil;
    self.navigationBar = nil;
    self.viewControllers = nil;
    self.modalViewController = nil;
    self.delegate = nil;
    self.topViewController = nil;
    self.pushAnimations = nil;
    self.popAnimations = nil;
    [super dealloc];
}


- (void)loadView {
    self.view = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
    [self.view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [self.view setWantsLayer:YES];

    self.navigationBar = [[[UMENavigationBar alloc] initWithFrame:NSMakeRect(0, 0, 0, NAVBAR_HEIGHT)] autorelease];
    [navigationBar setAutoresizingMask:NSViewWidthSizable];
    [self.view addSubview:navigationBar];
    
    self.containerView = [[[UMEFlippedView alloc] initWithFrame:NSMakeRect(0, NAVBAR_HEIGHT, 0, 0)] autorelease];
    [self.containerView setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
    [self.view addSubview:containerView];
    
    [self viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    hasAppeared = YES;
    [[self visibleViewController] viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [[self visibleViewController] viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [[self visibleViewController] viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
    [[self visibleViewController] viewDidDisappear:animated];
}


- (CAAnimation *)pushAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionPush;
    trans.subtype = kCATransitionFromRight;
    return trans;
}


- (CAAnimation *)popAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionPush;
    trans.subtype = kCATransitionFromLeft;
    return trans;
}


- (void)pushViewController:(UMEViewController *)vc animated:(BOOL)animated {
    NSParameterAssert(vc);

    if ([viewControllers containsObject:vc]) return;

    vc.navigationController = self;

    [self addBackBarButtonItemTo:vc];
    [viewControllers addObject:vc];

    UMEViewController *oldTopViewController = topViewController;
    [self setLastViewControllerAsTop];
    
    UMEViewController *oldvc = oldTopViewController;
    UMEViewController *newvc = topViewController;
    
    if (delegate && [delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [delegate navigationController:self willShowViewController:newvc animated:animated];
    }

    [self replaceViewController:oldvc with:newvc isPush:YES animated:animated];

    [navigationBar pushNavigationItem:vc.navigationItem animated:animated];

    if (delegate && [delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [delegate navigationController:self didShowViewController:newvc animated:animated];
    }
}


- (void)addBackBarButtonItemTo:(UMEViewController *)vc {
    NSParameterAssert(vc);
        
    UMEBarButtonItem *backItem = vc.navigationItem.backBarButtonItem;
    if (backItem) {
        [backItem setTarget:self];
        [backItem setAction:@selector(UMEBackItemClick:)];
    } else {
        NSString *backTitle = vc.title;
        if (!backTitle) {
            backTitle = NSLocalizedString(@"Back", @"");
        }
        backItem = [[[UMEBarButtonItem alloc] initWithTitle:backTitle 
                                                      style:UMEBarButtonItemStyleBack 
                                                     target:self 
                                                     action:@selector(UMEBackItemClick:)] autorelease];
        vc.navigationItem.backBarButtonItem = backItem;
    }
}


- (IBAction)UMEBackItemClick:(id)sender {
    [self popViewControllerAnimated:YES];
}


- (void)setLastViewControllerAsTop {
    if ([viewControllers count]) {
        UMEViewController *vc = [viewControllers lastObject];
        self.topViewController = vc;
    }
}


- (UMEViewController *)unsetLastViewControllerAsTop {
    UMEViewController *vc = nil;

    if ([viewControllers count]) {
        vc = [[[viewControllers lastObject] retain] autorelease];
        [viewControllers removeLastObject];
        self.topViewController = nil;
    }
    
    return vc;
}


- (UMEViewController *)popViewControllerAnimated:(BOOL)animated {
    NSParameterAssert([viewControllers count]);
    
    UMEViewController *oldTopViewController = [self unsetLastViewControllerAsTop];
    
    [self setLastViewControllerAsTop];
    
    UMEViewController *oldvc = oldTopViewController;
    UMEViewController *newvc = topViewController;

    if (delegate && [delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [delegate navigationController:self willShowViewController:newvc animated:animated];
    }
        
    [self replaceViewController:oldvc with:newvc isPush:NO animated:animated];

    [navigationBar popNavigationItemAnimated:animated];
    
    if (delegate && [delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [delegate navigationController:self didShowViewController:newvc animated:animated];
    }
    
    return oldTopViewController;
}


- (void)replaceViewController:(UMEViewController *)oldvc with:(UMEViewController *)newvc isPush:(BOOL)isPush animated:(BOOL)animated {
    NSParameterAssert(newvc);
    
    NSView *oldView = oldvc.view;
    NSView *newView = newvc.view;

    [newView setFrame:[self.containerView bounds]];

    if (hasAppeared) {
        [oldvc viewWillDisappear:animated];
        [newvc viewWillAppear:animated];
    }
    
    if (oldView) {
        if (animated) {
            [self.containerView setAnimations:isPush ? pushAnimations : popAnimations];
            [[self.containerView animator] replaceSubview:oldView with:newView];
            [self.containerView setAnimations:nil];
        } else {
            [self.containerView replaceSubview:oldView with:newView];
        }
    } else {
        [self.containerView addSubview:newView];
    }

    if (hasAppeared) {
        [oldvc viewDidDisappear:animated];
        [newvc viewDidAppear:animated];
    }
}


- (NSArray *)popToViewController:(UMEViewController *)targetViewController animated:(BOOL)animated {
    NSParameterAssert(targetViewController);

    if (![viewControllers containsObject:targetViewController]) return nil;
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[viewControllers count]];
        
    while ([viewControllers lastObject] != targetViewController) {
        BOOL nextIsTarget = ([viewControllers objectAtIndex:[viewControllers count] - 2] == targetViewController);
        [result addObject:[self popViewControllerAnimated:(animated && nextIsTarget)]];
    }
        
    return [[result copy] autorelease];
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    NSParameterAssert([viewControllers count]);
    
    UMEViewController *targetViewController = [viewControllers objectAtIndex:0];
    return [self popToViewController:targetViewController animated:animated];
}


- (void)setViewControllers:(NSArray *)vcs animated:(BOOL)animated {
    self.viewControllers = vcs;
    [self setLastViewControllerAsTop];
}


- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    self.navigationBarHidden = hidden;
}


- (CAAnimation *)coverVerticalInAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionMoveIn;
    trans.subtype = kCATransitionFromBottom;
    return trans;
}


- (CAAnimation *)coverVerticalOutAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionReveal;
    trans.subtype = kCATransitionFromTop;
    return trans;
}


- (CAAnimation *)crossDissolveAnimation {
    CATransition *trans = [CATransition animation];
    trans.duration = 0.25;
    trans.type = kCATransitionFade;
    return trans;
}


- (void)presentModalViewController:(UMEViewController *)vc animated:(BOOL)animated {
    NSParameterAssert(vc);
    
    UMENavigationController *nc = nil;
    if ([self isKindOfClass:[UMENavigationController class]]) {
        nc = (UMENavigationController *)self;
    } else {
        nc = navigationController;
    }
    
    nc.modalViewController = vc;
    vc.parentViewController = nc;
    
    NSView *parentView = nc.view;
    NSView *oldView = nc.containerView;
    NSView *newView = vc.view;
    
    [self modalParentView:parentView transitionIn:YES from:oldView to:newView animated:animated];
}


- (void)dismissModalViewControllerAnimated:(BOOL)animated {
    UMENavigationController *nc = nil;
    UMENavigationController *current = self;
    while (1) {
        if (!current) break;
        
        if (current.modalViewController) {
            nc = current;
            break;
        }
        
        if (current.parentViewController) {
            nc = (UMENavigationController *)current.parentViewController;
            break;
        }
        
        current = current.navigationController;
    }
    
    if (!nc) return;
    
    NSView *parentView = nc.view;
    NSView *oldView = nc.modalViewController.view;
    NSView *newView = nc.containerView;
    
    [self modalParentView:parentView transitionIn:NO from:oldView to:newView animated:animated];
}


- (void)modalParentView:(NSView *)parentView transitionIn:(BOOL)transitionIn from:(NSView *)oldView to:(NSView *)newView animated:(BOOL)animated {
//    NSLog(@"modalParentView: %@, oldView: %@, newView: %@", parentView, oldView, newView);
    
    if (transitionIn) {
        [newView setFrame:[parentView bounds]];
    }
    
    if (animated) {
        CAAnimation *anime = nil;
        if (modalTransitionStyle == UMEModalTransitionStyleCoverVertical) {
            anime = transitionIn ? [self coverVerticalInAnimation] : [self coverVerticalOutAnimation];
        } else {
            anime = [self crossDissolveAnimation];
        }
        
        [parentView setAnimations:[NSDictionary dictionaryWithObject:anime forKey:@"subviews"]];
        
        if (oldView) {
            [[parentView animator] replaceSubview:oldView with:newView];
        } else {
            [parentView addSubview:newView];
        }
        
        [parentView setAnimations:nil];
        
    } else {
        if (oldView) {
            [parentView replaceSubview:oldView with:newView];
        } else {
            [parentView addSubview:newView];
        }
    }
}


- (NSView *)containerView {
    if (![self isViewLoaded]) {
        [self loadView];
    }
    return [[containerView retain] autorelease];
}


- (UMEViewController *)visibleViewController {
    return modalViewController ? modalViewController : topViewController;
}

@synthesize containerView;
@synthesize topViewController;
@synthesize viewControllers;
@synthesize modalViewController;
@synthesize modalTransitionStyle;
@synthesize navigationBarHidden;
@synthesize navigationBar;
@synthesize delegate;
@synthesize pushAnimations;
@synthesize popAnimations;
@end
