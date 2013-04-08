// UIViewController+FLComposeViewController.h
//
// Copyright (c) 2013 Fernando Tarlá Cardoso Lemos <fernandotcl@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

#import "FLComposeViewController.h"

/**
 This category adds methods to the UIKit framework's `UIViewController` class. The methods in this category provide easier access to a parent compose view controller.
 */

@interface UIViewController (FLComposeViewController)

///---------------------------------------------------
/// @name Accessing the Parent Compose View Controller
///---------------------------------------------------

/**
 Returns the receiver's parent view controller, cast as a FLComposeViewController object.

 The receiver's parent view controller must be an instance of the FLComposeViewController class.

 @return The receiver's parent view controller, cast as a FLComposeViewController object.
 */
@property (readonly, nonatomic, assign) FLComposeViewController *fl_parentComposeViewController;

///----------------------------------------
/// @name Presenting Modal View Controllers
///----------------------------------------

/**
 Presents a modal view controller through the receiver's parent view controller.

 The receiver's parent view controller must be an instance of the FLComposeViewController class.

 @param controller The modal controller to be presented.

 @param animated Pass `YES` to animate the presentation; otherwise, pass `NO`.

 @see [FLComposeViewController presentComposeModalViewController:animated:]
 */
- (void)fl_presentComposeModalViewController:(UIViewController *)controller
                                    animated:(BOOL)animated;

/**
 Dismisses the modal view controller that was presented by the receiver's parent view controller.

 The receiver's parent view controller must be an instance of the FLComposeViewController class.

 @param animated Pass `YES` to animate the presentation; otherwise, pass `NO`.

 @see [FLComposeViewController dismissComposeModalViewControllerAnimated:]
 */
- (void)fl_dismissComposeModalViewControllerAnimated:(BOOL)animated;

@end
