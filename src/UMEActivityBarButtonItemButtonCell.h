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

#import "UMEBarButtonItemButtonCell.h"

@interface UMEActivityBarButtonItemButtonCell : UMEBarButtonItemButtonCell {
	NSTimer *timer;
	NSControl *parentControl;

	double doubleValue;
	NSTimeInterval animationDelay;
	BOOL spinning;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSControl *parentControl;

@property (nonatomic) double doubleValue;
@property (nonatomic) NSTimeInterval animationDelay;
@property (nonatomic, getter=isSpinning) BOOL spinning;
@end
