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
