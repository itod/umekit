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
//#import <CoreGraphics/CoreGraphics.h>
//#import <UMEKit/UMEKitDefines.h>
#import <UMEKit/UMEViewController.h>

@class UMEBarButtonItem, UMEView;
@protocol UMEPopoverControllerDelegate;

typedef enum NSUInteger {
    UMEPopoverArrowDirectionUp = 1UL << 0,
    UMEPopoverArrowDirectionDown = 1UL << 1,
    UMEPopoverArrowDirectionLeft = 1UL << 2,
    UMEPopoverArrowDirectionRight = 1UL << 3,
    UMEPopoverArrowDirectionAny = UMEPopoverArrowDirectionUp | UMEPopoverArrowDirectionDown | UMEPopoverArrowDirectionLeft | UMEPopoverArrowDirectionRight,
    UMEPopoverArrowDirectionUnknown = NSUIntegerMax
} UMEPopoverArrowDirection;

@interface UMEPopoverController : NSObject {
@private
    id delegate;
    UMEViewController *contentViewController;
    NSView *popoverView;
    NSArray *passthroughViews;
    UMEPopoverArrowDirection popoverArrowDirection;
    NSUInteger popoverBackgroundStyle;
    CGSize popoverContentSize;
    UMEBarButtonItem *targetBarButtonItem;
    NSUInteger toViewAutoResizingMask;
    UMEViewController *modalPresentationFromViewController;
    UMEViewController *modalPresentationToViewController;
    UMEViewController *slidingViewController;
    id target;
    SEL didEndSelector;
    BOOL popoverVisible;
//    struct {
//        unsigned int isPresentingOrDismissing:1;
//        unsigned int isPresentingModalViewController:1;
//        unsigned int isPresentingActionSheet:1;
//        unsigned int needsRepresentAfterRotation:1;
//        unsigned int dimsWhenModal:1;
//    } _popoverControllerFlags;
}

/* The view controller provided becomes the content view controller for the UMEPopoverController. This is the designated initializer for UMEPopoverController.
 */
- (id)initWithContentViewController:(UMEViewController *)viewController;

@property (nonatomic, assign) id <UMEPopoverControllerDelegate> delegate;

/* The content view controller is the `UMEViewController` instance in charge of the content view of the displayed popover. This property can be changed while the popover is displayed to allow different view controllers in the same popover session.
 */
@property (nonatomic, retain) UMEViewController *contentViewController;
- (void)setContentViewController:(UMEViewController *)viewController animated:(BOOL)animated;

/* This property allows direction manipulation of the content size of the popover. Changing the property directly is equivalent to animated=YES. The content size is limited to a minimum width of 320 and a maximum width of 600.
 */
@property (nonatomic) CGSize popoverContentSize;
- (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated;

/* Returns whether the popover is visible (presented) or not.
 */
@property (nonatomic, readonly, getter=isPopoverVisible) BOOL popoverVisible;

/* Returns the direction the arrow is pointing on a presented popover. Before presentation, this returns UMEPopoverArrowDirectionUnknown.
 */
@property (nonatomic, readonly) UMEPopoverArrowDirection popoverArrowDirection;

/* By default, a popover disallows interaction with any view outside of the popover while the popover is presented. This property allows the specification of an array of UMEView instances which the user is allowed to interact with while the popover is up.
 */
@property (nonatomic, copy) NSArray *passthroughViews;

/* -presentPopoverFromRect:inView:permittedArrowDirections:animated: allows you to present a popover from a rect in a particular view. `arrowDirections` is a bitfield which specifies what arrow directions are allowed when laying out the popover; for most uses, `UMEPopoverArrowDirectionAny` is sufficient.
 */
- (void)presentPopoverFromRect:(CGRect)rect inView:(UMEView *)view permittedArrowDirections:(UMEPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

/* Like the above, but is a convenience for presentation from a `UMEBarButtonItem` instance. arrowDirection limited to UMEPopoverArrowDirectionUp/Down
 */
- (void)presentPopoverFromBarButtonItem:(UMEBarButtonItem *)item permittedArrowDirections:(UMEPopoverArrowDirection)arrowDirections animated:(BOOL)animated;

/* Called to dismiss the popover programmatically. The delegate methods for "should" and "did" dismiss are not called when the popover is dismissed in this way.
 */
- (void)dismissPopoverAnimated:(BOOL)animated;

@end

@protocol UMEPopoverControllerDelegate <NSObject>
@optional

/* Called on the delegate when the popover controller will dismiss the popover. Return NO to prevent the dismissal of the view.
 */
- (BOOL)popoverControllerShouldDismissPopover:(UMEPopoverController *)popoverController;

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)popoverControllerDidDismissPopover:(UMEPopoverController *)popoverController;

@end

@interface UMEViewController (UMEPopoverController)

/* contentSizeForViewInPopover allows you to set the size of the content from within the view controller. This property is read/write, and you should generally not override it.
 */
@property (nonatomic,readwrite) CGSize contentSizeForViewInPopover;

/* modalInPopover is set on the view controller when you wish to force the popover hosting the view controller into modal behavior. When this is active, the popover will ignore events outside of its bounds until this is set to NO.
 */
@property (nonatomic,readwrite,getter=isModalInPopover) BOOL modalInPopover;

@end
