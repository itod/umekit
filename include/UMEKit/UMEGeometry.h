/*
 *  UMEGeometry.h
 *  UMEKit
 *
 *  Created by Todd Ditchendorf on 9/30/09.
 *  Copyright 2009 Yahoo! Inc.. All rights reserved.
 *
 */

#import <Cocoa/Cocoa.h>

typedef struct UMEEdgeInsets {
    CGFloat top, left, bottom, right;  // specify amount to inset (positive) for each of the edges. values can be negative to 'outset'
} UMEEdgeInsets;

static inline UMEEdgeInsets UMEEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    UMEEdgeInsets insets = {top, left, bottom, right};
    return insets;
}

static inline CGRect UMEEdgeInsetsInsetRect(CGRect rect, UMEEdgeInsets insets) {
    rect.origin.x    += insets.left;
    rect.origin.y    += insets.top;
    rect.size.width  -= (insets.left + insets.right);
    rect.size.height -= (insets.top  + insets.bottom);
    return rect;
}

static inline BOOL UMEEdgeInsetsEqualToEdgeInsets(UMEEdgeInsets insets1, UMEEdgeInsets insets2) {
    return insets1.left == insets2.left && insets1.top == insets2.top && insets1.right == insets2.right && insets1.bottom == insets2.bottom;
}

extern const UMEEdgeInsets UMEEdgeInsetsZero;
