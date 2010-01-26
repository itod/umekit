//
//  UMEBarButtonItem.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEBarItem.h>

typedef enum {
    UMEBarButtonItemStylePlain,    // shows glow when pressed
    UMEBarButtonItemStyleBack,
    UMEBarButtonItemStyleDone,
} UMEBarButtonItemStyle;

typedef enum {
    UMEBarButtonSystemItemDone,
    UMEBarButtonSystemItemCancel,
    UMEBarButtonSystemItemEdit,  
    UMEBarButtonSystemItemSave,  
    UMEBarButtonSystemItemAdd,
    UMEBarButtonSystemItemFlexibleSpace,
    UMEBarButtonSystemItemFixedSpace,
    UMEBarButtonSystemItemCompose,
    UMEBarButtonSystemItemReply,
    UMEBarButtonSystemItemAction,
    UMEBarButtonSystemItemOrganize,
    UMEBarButtonSystemItemBookmarks,
    UMEBarButtonSystemItemSearch,
    UMEBarButtonSystemItemRefresh,
    UMEBarButtonSystemItemStop,
    UMEBarButtonSystemItemCamera,
    UMEBarButtonSystemItemTrash,
    UMEBarButtonSystemItemPlay,
    UMEBarButtonSystemItemPause,
    UMEBarButtonSystemItemRewind,
    UMEBarButtonSystemItemFastForward,
    UMEBarButtonSystemItemUndo,
    UMEBarButtonSystemItemRedo,
    UMEBarButtonSystemItemUser,
    UMEBarButtonSystemItemEveryone,
} UMEBarButtonSystemItem;

@interface UMEBarButtonItem : UMEBarItem {
    NSView *customView;
    NSButton *button;
    UMEBarButtonItemStyle style;
    CGFloat width;
}

- (id)initWithBarButtonSystemItem:(UMEBarButtonSystemItem)systemItem target:(id)target action:(SEL)action;
- (id)initWithCustomView:(NSView *)customView;
- (id)initWithImage:(NSImage *)image style:(UMEBarButtonItemStyle)style target:(id)target action:(SEL)action;
- (id)initWithTitle:(NSString *)title style:(UMEBarButtonItemStyle)style target:(id)target action:(SEL)action;

@property (nonatomic, retain) NSView *customView;
@property (nonatomic) UMEBarButtonItemStyle style;            // default is UMEBarButtonItemStylePlain
@property (nonatomic) CGFloat width;            // default is 0.0
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, assign) id target;
@property (nonatomic) SEL action;
@end
