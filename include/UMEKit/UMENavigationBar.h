//
//  UMENavigationBar.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEKit.h>

@class UMEBarButtonItem;

@interface UMENavigationBar : NSView {
    NSView *containerView;
    
    NSMutableArray *items;
    UMEBarStyle barStyle;
    CGFloat rightMargin;
    id delegate;
    
    UMENavigationItem *topItem;
    UMENavigationItem *backItem;
    
    NSTextField *label;

    UMEBarButtonItem *leftBarButtonItem;
    UMEBarButtonItem *rightBarButtonItem;
    BOOL layoutDone;

    NSDictionary *pushAnimations;
    NSDictionary *popAnimations;
}

- (void)pushNavigationItem:(UMENavigationItem *)item animated:(BOOL)animated;
- (UMENavigationItem *)popNavigationItemAnimated:(BOOL)animated;
- (void)setItems:(NSArray *)items animated:(BOOL)animated; // If animated is YES, then simulate a push or pop depending on whether the new top item was previously in the stack.

@property (nonatomic, readonly, retain) UMENavigationItem *topItem;
@property (nonatomic, readonly, retain) UMENavigationItem *backItem;
@property (nonatomic, assign) UMEBarStyle barStyle;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) NSArray *items;
@end

@protocol UMENavigationBarDelegate <NSObject>
@optional
- (BOOL)navigationBar:(UMENavigationBar *)navigationBar shouldPushItem:(UMENavigationItem *)item;
- (void)navigationBar:(UMENavigationBar *)navigationBar didPushItem:(UMENavigationItem *)item;    // called at end of animation of push or immediately if not animated
- (BOOL)navigationBar:(UMENavigationBar *)navigationBar shouldPopItem:(UMENavigationItem *)item;
- (void)navigationBar:(UMENavigationBar *)navigationBar didPopItem:(UMENavigationItem *)item;
@end
