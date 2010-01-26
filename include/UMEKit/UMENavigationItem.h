//
//  UMENavigationItem.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UMEBarButtonItem;
@class UMENavigationBar;

@interface UMENavigationItem : NSObject {
@private
    NSString *title;
    UMEBarButtonItem *backBarButtonItem;
    UMENavigationBar *navigationBar;
    NSView *titleView;
    UMEBarButtonItem *leftBarButtonItem;
    UMEBarButtonItem *rightBarButtonItem;
    NSView *customLeftView;
    NSView *customRightView;
    BOOL hidesBackButton;
}

- (id)initWithTitle:(NSString *)s;

- (void)setHidesBackButton:(BOOL)yn animated:(BOOL)animated;
- (void)setLeftBarButtonItem:(UMEBarButtonItem *)item animated:(BOOL)animated;
- (void)setRightBarButtonItem:(UMEBarButtonItem *)item animated:(BOOL)animated;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UMEBarButtonItem *backBarButtonItem;
@property (nonatomic, retain) NSView *titleView;         // Custom view to use in lieu of a title. May be sized horizontally. Only used when item is topmost on the stack.
@property (nonatomic, assign) BOOL hidesBackButton;

@property (nonatomic, retain) UMEBarButtonItem *leftBarButtonItem;
@property (nonatomic, retain) UMEBarButtonItem *rightBarButtonItem;

@property (nonatomic, retain) NSView *customLeftView;
@property (nonatomic, retain) NSView *customRightView;
@end
