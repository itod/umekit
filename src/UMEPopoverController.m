//
//  UMEPopoverController.m
//  UMEKit
//
//  Created by Todd Ditchendorf on 4/18/10.
//  Copyright 2010 Todd Ditchendorf. All rights reserved.
//

#import "UMEPopoverController.h"


@implementation UMEPopoverController

- (id)initWithContentViewController:(UMEViewController *)viewController {
    if (self = [super init]) {
        
    }
    return self;
}


- (void)dealloc {
    
    [super dealloc];
}


- (void)setContentViewController:(UMEViewController *)viewController animated:(BOOL)animated {
    
}


- (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated {
    
}


- (void)presentPopoverFromRect:(CGRect)rect inView:(UMEView *)view permittedArrowDirections:(UMEPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    
}


- (void)presentPopoverFromBarButtonItem:(UMEBarButtonItem *)item permittedArrowDirections:(UMEPopoverArrowDirection)arrowDirections animated:(BOOL)animated {
    
}


- (void)dismissPopoverAnimated:(BOOL)animated {
    
}

@synthesize delegate;
@synthesize contentViewController;
@synthesize popoverContentSize;
@synthesize popoverVisible;
@synthesize popoverArrowDirection;
@synthesize passthroughViews;
@end

//@implementation UMEViewController (UMEPopoverController)
//@synthesize contentSizeForViewInPopover;
//@synthesize modalInPopover;
//@end
