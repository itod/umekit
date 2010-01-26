//
//  UMETabBarItem.h
//  UMEKit
//
//  Created by Todd Ditchendorf on 9/27/09.
//  Copyright 2009 Todd Ditchendorf. All rights reserved.
//

#import <UMEKit/UMEBarItem.h>

typedef enum {
    UMETabBarSystemItemMore,
    UMETabBarSystemItemFavorites,
    UMETabBarSystemItemFeatured,
    UMETabBarSystemItemTopRated,
    UMETabBarSystemItemRecents,
    UMETabBarSystemItemContacts,
    UMETabBarSystemItemHistory,
    UMETabBarSystemItemBookmarks,
    UMETabBarSystemItemSearch,
    UMETabBarSystemItemDownloads,
    UMETabBarSystemItemMostRecent,
    UMETabBarSystemItemMostViewed,
} UMETabBarSystemItem;

@interface UMETabBarItem : UMEBarItem {
    NSButton *button;
    NSString *badgeValue;
}

- (id)initWithTabBarSystemItem:(UMETabBarSystemItem)systemItem tag:(NSInteger)tag;
// designated initializer
- (id)initWithTitle:(NSString *)title image:(NSImage *)image tag:(NSInteger)tag;

@property (nonatomic, copy) NSString *badgeValue;    // default is nil
@end
