//
//  UMEBarButtonItem.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEBarButtonItem.h>
#import "UMEBarButtonItemButton.h"
#import "UMEFlippedView.h"

#define CUSTOM_VIEW_FLAG 500
#define MIN_HEIGHT 44
#define MIN_WIDTH 40

@interface UMEBarButtonItem ()
- (void)sizeToFit;
- (void)layout;
@property (nonatomic, retain) NSButton *button;
@end

@implementation UMEBarButtonItem

- (id)initWithBarButtonSystemItem:(UMEBarButtonSystemItem)systemItem target:(id)t action:(SEL)sel {
    NSString *aTitle = nil;
    NSString *imgPath = nil;
    NSString *imgHiPath = nil;
    NSBundle *b = [NSBundle bundleForClass:[UMEBarButtonItem class]];
    UMEBarButtonItemStyle aStyle = UMEBarButtonItemStylePlain;
    NSCellImagePosition imgPos = NSNoImage;
    
    switch (systemItem) {
        case UMEBarButtonSystemItemDone:
            aTitle = NSLocalizedString(@"Done", @"");
            aStyle = UMEBarButtonItemStyleDone;
            break;
        case UMEBarButtonSystemItemCancel:
            aTitle = NSLocalizedString(@"Cancel", @"");
            break;
        case UMEBarButtonSystemItemEdit:  
            aTitle = NSLocalizedString(@"Edit", @"");
            break;
        case UMEBarButtonSystemItemSave:  
            aTitle = NSLocalizedString(@"Save", @"");
            aStyle = UMEBarButtonItemStyleDone;
            break;
        case UMEBarButtonSystemItemAdd:
            aTitle = NSLocalizedString(@"Add", @"");
            break;
        case UMEBarButtonSystemItemFlexibleSpace:
            imgPath = [b pathForImageResource:@""];
            imgHiPath = [b pathForImageResource:@""];
            break;
        case UMEBarButtonSystemItemFixedSpace:
            imgPath = [b pathForImageResource:@""];
            imgHiPath = [b pathForImageResource:@""];
            break;
        case UMEBarButtonSystemItemCompose:
            imgPath = [b pathForImageResource:@"barbutton_system_item_compose"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_compose_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemReply:
            imgPath = [b pathForImageResource:@"barbutton_system_item_reply"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_reply_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemAction:
            imgPath = [b pathForImageResource:@"barbutton_system_item_action"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_action_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemOrganize:
            imgPath = [b pathForImageResource:@"barbutton_system_item_organize"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_organize_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemBookmarks:
            imgPath = [b pathForImageResource:@"barbutton_system_item_bookmarks"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_bookmarks_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemSearch:
            imgPath = [b pathForImageResource:@"barbutton_system_item_search"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_search_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemRefresh:
            imgPath = [b pathForImageResource:@"barbutton_system_item_refresh"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_refresh_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemStop:
            imgPath = [b pathForImageResource:@"barbutton_system_item_stop"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_stop_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemCamera:
            imgPath = [b pathForImageResource:@"barbutton_system_item_camera"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_camera_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemTrash:
            imgPath = [b pathForImageResource:@"barbutton_system_item_trash"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_trash_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemPlay:
            imgPath = [b pathForImageResource:@"barbutton_system_item_play"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_play_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemPause:
            imgPath = [b pathForImageResource:@"barbutton_system_item_pause"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_pause_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemRewind:
            imgPath = [b pathForImageResource:@"barbutton_system_item_rewind"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_rewind_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemFastForward:
            imgPath = [b pathForImageResource:@"barbutton_system_item_fastforward"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_fastforward_hi"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemUndo:
            aTitle = NSLocalizedString(@"Undo", @"");
            break;
        case UMEBarButtonSystemItemRedo:
            aTitle = NSLocalizedString(@"Redo", @"");
        case UMEBarButtonSystemItemUser:
            imgPath = [b pathForImageResource:@"barbutton_system_item_user"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_user"];
            imgPos = NSImageOnly;
            break;
        case UMEBarButtonSystemItemEveryone:
            imgPath = [b pathForImageResource:@"barbutton_system_item_everyone"];
            imgHiPath = [b pathForImageResource:@"barbutton_system_item_everyone"];
            imgPos = NSImageOnly;
            break;
        default:
            NSAssert(0, @"Unknown UMEBarButtonSystemItem");
            break;
    }
    
    self = [self initWithTitle:aTitle style:aStyle target:t action:sel];
    if ([imgPath length]) {
        self.image = [[[NSImage alloc] initWithContentsOfFile:imgPath] autorelease];
    }
    [button setImagePosition:imgPos];
    if ([imgHiPath length]) {
        [button setAlternateImage:[[[NSImage alloc] initWithContentsOfFile:imgHiPath] autorelease]];
    }
    return self;
}


- (id)initWithCustomView:(NSView *)v {
    self = [self initWithTitle:nil style:CUSTOM_VIEW_FLAG target:nil action:nil];
    self.customView = v;
    return self;
}


- (id)initWithImage:(NSImage *)img style:(UMEBarButtonItemStyle)s target:(id)t action:(SEL)sel {
    self = [self initWithTitle:nil style:s target:t action:sel];
    self.image = img;
    [button setImagePosition:NSImageOnly];
    return self;
}


- (id)initWithTitle:(NSString *)aTitle style:(UMEBarButtonItemStyle)aStyle target:(id)aTarget action:(SEL)sel {
    if (self = [super init]) {
        
        if (CUSTOM_VIEW_FLAG == aStyle) {
            self.style = UMEBarButtonItemStylePlain;
        } else {
            self.button = [[[UMEBarButtonItemButton alloc] initWithFrame:NSZeroRect] autorelease];
            [button setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
            [(UMEBarButtonItemButton *)button setItem:self];
            self.style = aStyle;
        }
        
        self.title = aTitle;
        self.target = aTarget;
        self.action = sel;
        
        if (CUSTOM_VIEW_FLAG != aStyle) {
            self.customView = [[[UMEFlippedView alloc] initWithFrame:NSZeroRect] autorelease];
        }
    }
    return self;
}


- (void)dealloc {
    [button removeFromSuperview];
    [customView removeFromSuperview];
    self.customView = nil;
    self.button = nil;
    self.target = nil;
    self.action = nil;
    [super dealloc];
}


- (void)sizeToFit {
    if (button) {
        [button sizeToFit];
        //[button setFrameOrigin:NSZeroPoint];
        [customView setFrameSize:[button frame].size];
    } else {        
        if ([customView respondsToSelector:@selector(sizeToFit)]) {
            [customView performSelector:@selector(sizeToFit)];
        } else {
            NSRect frame = [customView frame];
            if (frame.size.height < MIN_HEIGHT) {
                frame.size.height = MIN_HEIGHT;
            }
            if (frame.size.width < MIN_WIDTH) {
                frame.size.width = MIN_WIDTH;
            }
            [customView setFrame:frame];
        }
    }
}


- (void)layout {
    if (button) {
        [button setFrame:[customView bounds]];
    } else {
    }
}


- (void)setEnabled:(BOOL)yn {
    [super setEnabled:yn];
    [button setEnabled:yn];
}


- (id)target {
    return [button target];
}


- (void)setTarget:(id)t {
    [button setTarget:t];
}


- (SEL)action {
    return [button action];
}


- (void)setAction:(SEL)sel {
    [button setAction:sel];
}


- (void)setTitle:(NSString *)aTitle {
    [super setTitle:aTitle];
    [button setTitle:aTitle];
}


- (void)setImage:(NSImage *)img {
    [super setImage:img];
    [button setImage:img];
}


- (void)setCustomView:(NSView *)v {
    if (customView != v) {
        [customView autorelease];
        customView = [v retain];
        
        [customView addSubview:button];
    }
}

@synthesize customView;
@synthesize button;
@synthesize style;
@synthesize width;
@end
