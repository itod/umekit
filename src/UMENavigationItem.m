//
//  UMENavigationItem.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMENavigationItem.h>
#import <UMEKit/UMENavigationBar.h>

@interface UMEBarButtonItem ()
- (void)layout;
@end

@interface UMENavigationItem ()
@property (nonatomic, assign) UMENavigationBar *navigationBar;
@end

@interface UMENavigationBar ()
- (void)layout;
- (void)setTopItem:(UMENavigationItem *)newTopItem backItem:(UMENavigationItem *)newBackItem isPush:(BOOL)isPush animated:(BOOL)animated;

@property (nonatomic, retain) NSView *containerView;
@property (nonatomic, retain) UMEBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UMEBarButtonItem *rightBarButtonItem;
@end

@implementation UMENavigationItem

- (id)initWithTitle:(NSString *)s {
    if (self = [super init]) {
        self.title = s;
    }
    return self;
}


- (void)dealloc {
    [titleView removeFromSuperview];
    [customLeftView removeFromSuperview];
    [customRightView removeFromSuperview];
    self.navigationBar = nil;
    self.title = nil;
    self.backBarButtonItem = nil;
    self.navigationBar = nil;
    self.titleView = nil;
    self.leftBarButtonItem = nil;
    self.rightBarButtonItem = nil;
    self.customLeftView = nil;
    self.customRightView = nil;
    [super dealloc];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ %p '%@'>", [self className], self, title];
}


- (void)setTitle:(NSString *)s {
    if (s != title) {
        [title autorelease];
        title = [s retain];
        
        [navigationBar layout];
    }
}


- (void)setHidesBackButton:(BOOL)yn animated:(BOOL)animated {
    self.hidesBackButton = yn;
    [navigationBar layout];
}


- (void)setLeftBarButtonItem:(UMEBarButtonItem *)item animated:(BOOL)animated {
    self.leftBarButtonItem = item;
    
}


- (void)setRightBarButtonItem:(UMEBarButtonItem *)item animated:(BOOL)animated {
    self.rightBarButtonItem = item;
    
}


- (void)setRightBarButtonItem:(UMEBarButtonItem *)item {
    if (item != rightBarButtonItem) {
        [rightBarButtonItem autorelease];
        rightBarButtonItem = [item retain];
        
        [rightBarButtonItem layout];
        [navigationBar setTopItem:self backItem:navigationBar.backItem isPush:YES animated:NO];
        //        navigationBar.rightBarButtonItem = rightBarButtonItem;
        //        [navigationBar.containerView addSubview:rightBarButtonItem.customView];
        //        [navigationBar layoutBarButtonItems];
    }
}


- (void)setLeftBarButtonItem:(UMEBarButtonItem *)item {
    if (item != leftBarButtonItem) {
        [leftBarButtonItem autorelease];
        leftBarButtonItem = [item retain];
        
        [leftBarButtonItem layout];
        [navigationBar setTopItem:self backItem:navigationBar.backItem isPush:YES animated:NO];
        //        navigationBar.leftBarButtonItem = leftBarButtonItem;
        //        [navigationBar.containerView addSubview:leftBarButtonItem.customView];
        //        [navigationBar layoutBarButtonItems];
    }
}

@synthesize title;
@synthesize backBarButtonItem;
@synthesize titleView;
@synthesize hidesBackButton;
@synthesize leftBarButtonItem;
@synthesize rightBarButtonItem;
@synthesize navigationBar;
@synthesize customLeftView;
@synthesize customRightView;
@end
