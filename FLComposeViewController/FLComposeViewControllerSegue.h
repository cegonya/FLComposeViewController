// FLComposeViewControllerSegue.h
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

/**
 A `FLComposeViewControllerSegue` is responsible for performing the transition between view controllers that are children of a FLComposeViewController object. This segue can only be used if both the source and destination view controllers are children of the same compose view controller object.

 Compose view controller segues are rarely instantiated directly. In the most common case, the compose view controller segue can be used as a custom segue between two children of a compose view controller object in a storyboard.
 */

@interface FLComposeViewControllerSegue : UIStoryboardSegue

///----------------------------------------------
/// @name Creating Compose View Controller Segues
///----------------------------------------------

/**
 Creates and initializes a compose view controller segue object for use in a performing segue.

 @param identifier The identifier you want to associate with this particular instance of the segue. You can use this identifier to differentiate one type of segue from another at runtime.

 @param source The view controller visible at the start of the segue.

 @param destination The view controller to display after the completion of the segue.

 @param unwinding Pass `YES` if this segue should be unwinding; otherwise, pass `NO`.

 @return The newly initialized compose view controller segue.
 */
+ (instancetype)segueWithIdentifier:(NSString *)identifier
                             source:(UIViewController *)source
                        destination:(UIViewController *)destination
                          unwinding:(BOOL)unwinding;

/**
 Initializes and returns a compose view controller segue object for use in a performing segue.

 This is the designated initializer for this class.

 @param identifier The identifier you want to associate with this particular instance of the segue. You can use this identifier to differentiate one type of segue from another at runtime.

 @param source The view controller visible at the start of the segue.

 @param destination The view controller to display after the completion of the segue.

 @param unwinding Pass `YES` if this segue should unwind; otherwise, pass `NO`.

 @return The newly initialized compose view controller segue.
 */
- (id)initWithIdentifier:(NSString *)identifier
                  source:(UIViewController *)source
             destination:(UIViewController *)destination
               unwinding:(BOOL)unwinding;

///-------------------------------------------------
/// @name Configuring Compose View Controller Segues
///-------------------------------------------------

/**
 A Boolean value indicating whether the receiver is unwinding.

 If `YES`, the receiver will dismiss the destination modal view controller when the segue is performed. If `NO`, the receiver will present the destination modal view controller when the segue is performed.
 */
@property (getter=isUnwinding, nonatomic, assign) BOOL unwinding;

@end
