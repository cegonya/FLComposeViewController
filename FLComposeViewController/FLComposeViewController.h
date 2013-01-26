// FLComposeViewController.h
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

/**
 The `FLComposeViewController` class implements a view controller container that can present modal view controllers. The modal view controllers are presented with an animation style that resembles the message composition animation in the Gmail app for iOS.

 In its initial state, the compose view controller presents its root view controller. A modal view controller may be presented on top of the root view controller at any time by calling presentModalViewController:animated:. When presented, the modal view completely obscures the root view. Both the root view and the modal view are resized to fill the entire screen.

 When using storyboards, the presentation and dismissal of the modal view controller may be performed by a FLComposeViewControllerSegue object.
 */

@interface FLComposeViewController : UIViewController

///----------------------------------------
/// @name Creating Compose View Controllers
///----------------------------------------

/**
 Returns a newly initialized compose view controller with the specified root view controller.

 This is the designated initializer for this class.

 @param rootViewController The root view controller to be used. If you specify `nil`, the rootViewController property is set to `nil`.

 @return The newly initialized compose view controller.
 */
- (id)initWithRootViewController:(UIViewController *)rootViewController;

///-------------------------------------------
/// @name Configuring Compose View Controllers
///-------------------------------------------

/**
 The root view controller.

 In its initial state, the compose view controller presents the root view controller.

 This property must be set before the compose view controller loads its view, and it can't be changed once it has been set to anything other than `nil`.
 */
@property (nonatomic, strong) UIViewController *rootViewController;

/**
 The duration of the present and dismiss animations, measured in seconds.
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 The opacity to be assigned to a black mask laid out on top of the root view after the presentation animation.

 During the presentation animation, a black mask is laid out on top of the root view to give the illusion of lighting and depth. This property controls the opacity of the black mask when the animation is complete.
 */
@property (nonatomic, assign) CGFloat obscuredViewOpacity;

/**
 The rotation angle of the root view after the presentation animation, measured in radians.

 During the presentation animation, the root view is rotated along its X axis. The rotation is anchored at the bottom of the view. This property controls the rotation angle of the root view when the animation is complete.
 */
@property (nonatomic, assign) CGFloat obscuredViewRotation;

///----------------------------------------
/// @name Presenting Modal View Controllers
///----------------------------------------

/**
 Presents a modal view controller.

 Only a single modal view controller may be presented at the same time. This method is should not be called if the receiver is already presenting a modal view controller.

 @param controller The modal controller to be presented.

 @param animated Pass `YES` to animate the presentation; otherwise, pass `NO`.
 */
- (void)presentModalViewController:(UIViewController *)controller
                          animated:(BOOL)animated;

/**
 Dismisses the modal view controller that was presented by the receiver.

 This method should not be called if the receiver is not presenting a modal view controller.

 @param animated Pass `YES` to animate the presentation; otherwise, pass `NO`.
 */
- (void)dismissModalViewControllerAnimated:(BOOL)animated;

/**
 Returns a Boolean value that indicates that the receiver is presenting a modal view controller.

 @return `YES` if the receiver is presenting a modal view controller, otherwise `NO`.
 */
@property (readonly, getter = isPresentingModalViewController, nonatomic, assign) BOOL presentingModalViewController;

@end
