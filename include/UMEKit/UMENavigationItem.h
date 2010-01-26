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
