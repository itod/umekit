//
//  UMEToolbar.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 2/16/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEKit.h>

@class UMEBarButtonItem;

@interface UMEToolbar : NSView {
    UMEBarStyle barStyle;
    NSMutableArray *items;
    NSColor *tintColor;
    BOOL translucent;
    BOOL layoutDone;
}

@property (nonatomic, assign) UMEBarStyle barStyle;    // default is UMEBarStyleDefault (blue)
@property (nonatomic, copy) NSArray *items;       // get/set visible UMEBarButtonItem. default is nil. changes not animated. shown in order
@property (nonatomic, retain) NSColor *tintColor;   // default is nil
@property (nonatomic, assign, getter=isTranslucent) BOOL translucent; // Default is NO. Always YES if barStyle is set to UIBarStyleBlackTranslucent

- (void)setItems:(NSArray *)a animated:(BOOL)animated;   // will fade in or out or reorder and adjust spacing
@end
