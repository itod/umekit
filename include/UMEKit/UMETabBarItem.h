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
- (void)setSelectedImage:(NSImage *)image;

@property (nonatomic, copy) NSString *badgeValue;    // default is nil
@end
