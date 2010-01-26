//
//  UMETabBarItem.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMETabBarItem.h>
#import "UMETabBarItemButton.h"

@interface UMETabBarItem ()
@property (nonatomic, retain) NSButton *button;
@end

@implementation UMETabBarItem

- (id)initWithTabBarSystemItem:(UMETabBarSystemItem)systemItem tag:(NSInteger)aTag {
    NSString *aTitle = nil;
    NSString *imgPath = nil;
    NSString *imgHiPath = nil;
    
    NSBundle *b = [NSBundle bundleForClass:[UMETabBarItem class]];
    
    switch (systemItem) {
        case UMETabBarSystemItemMore:
            aTitle = NSLocalizedString(@"More", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_more.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_more_hi.png"];
            break;
        case UMETabBarSystemItemFavorites:
            aTitle = NSLocalizedString(@"Favorites", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_favorites.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_favorites_hi.png"];
            break;
        case UMETabBarSystemItemFeatured:
            aTitle = NSLocalizedString(@"Featured", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_featured.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_featured_hi.png"];
            break;
        case UMETabBarSystemItemTopRated:
            aTitle = NSLocalizedString(@"Top Rated", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_toprated.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_toprated_hi.png"];
            break;
        case UMETabBarSystemItemRecents:
            aTitle = NSLocalizedString(@"Recents", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_recents.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_recents_hi.png"];
            break;
        case UMETabBarSystemItemContacts:
            aTitle = NSLocalizedString(@"Contacts", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_contacts.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_contacts_hi.png"];
            break;
        case UMETabBarSystemItemHistory:
            aTitle = NSLocalizedString(@"History", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_history.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_history_hi.png"];
            break;
        case UMETabBarSystemItemBookmarks:
            aTitle = NSLocalizedString(@"Bookmarks", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_bookmarks.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_bookmarks_hi.png"];
            break;
        case UMETabBarSystemItemSearch:
            aTitle = NSLocalizedString(@"Search", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_search.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_search_hi.png"];
            break;
        case UMETabBarSystemItemDownloads:
            aTitle = NSLocalizedString(@"Downloads", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_downloads.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_downloads_hi.png"];
            break;
        case UMETabBarSystemItemMostRecent:
            aTitle = NSLocalizedString(@"Most Recent", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_mostrecent.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_mostrecent_hi.png"];
            break;
        case UMETabBarSystemItemMostViewed:
            aTitle = NSLocalizedString(@"Most Viewed", @"");
            imgPath = [b pathForImageResource:@"tabbar_system_item_mostviewed.png"];
            imgHiPath = [b pathForImageResource:@"tabbar_system_item_mostviewed_hi.png"];
            break;
        default:
            break;
    }
    
    NSImage *img = [[[NSImage alloc] initWithContentsOfFile:imgPath] autorelease];
    NSImage *imgHi = [[[NSImage alloc] initWithContentsOfFile:imgHiPath] autorelease];

    self = [self initWithTitle:aTitle image:img tag:aTag];
    [button setAlternateImage:imgHi];
    return self;
}



- (id)initWithTitle:(NSString *)aTitle image:(NSImage *)img tag:(NSInteger)aTag {
    if (self = [super init]) {
        self.button = [[[UMETabBarItemButton alloc] initWithFrame:NSZeroRect] autorelease];
        
        self.title = aTitle;
        self.image = img;
        self.tag = aTag;
    }
    return self;
}


- (void)dealloc {
    [button removeFromSuperview];
    self.button = nil;
    self.badgeValue = nil;
    [super dealloc];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"<UMETabBarItem: %p '%@'>", self, [self title]];
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


- (void)setTag:(NSInteger)aTag {
    [super setTag:aTag];
    [button setTag:aTag];
}

@synthesize button;
@synthesize badgeValue;
@end
