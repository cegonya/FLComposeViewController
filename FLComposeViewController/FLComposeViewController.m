// FLComposeViewController.m
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

#import <QuartzCore/QuartzCore.h>

#import "FLComposeViewController.h"
#import "FLComposeViewControllerSegue.h"

@interface FLComposeViewController ()

@property (readonly, nonatomic, assign) UIViewController *presentedModalViewController;

@property (readonly, nonatomic, assign) UIViewController *topModalViewController;

@end

@implementation FLComposeViewController {
    UIView *_rootViewContainer;
    UIView *_modalViewContainer;

    UIView *_rootViewContainerMask;

    BOOL _animating;
}

#pragma mark - Initializers

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.animationDuration = 0.4f;
        self.obscuredViewOpacity = 0.4f;
        self.obscuredViewRotation = 8.0f * M_PI / 180.0f;
    }
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        self.rootViewController = rootViewController;
    }
    return self;
}

#pragma mark - View controller life cycle

- (void)loadView
{
    NSAssert(self.rootViewController, @"The rootViewController property must be set");

    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view = [[UIView alloc] initWithFrame:frame];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // Allow perspective effects on rotation
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0f / -500.0f;
    self.view.layer.sublayerTransform = transform;

    // Set the anchor point before we set the frame, so
    // we don't have to offset the frame
    _rootViewContainer = [UIView new];
    _rootViewContainer.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
    _rootViewContainer.frame = self.view.bounds;
    _rootViewContainer.backgroundColor = [UIColor blackColor];
    _rootViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_rootViewContainer];

    [self addChildViewController:self.rootViewController];
    UIView *rootView = self.rootViewController.view;
    rootView.frame = _rootViewContainer.bounds;
    rootView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_rootViewContainer addSubview:rootView];

    [self.rootViewController didMoveToParentViewController:self];

    _modalViewContainer = [UIView new];
    _modalViewContainer.backgroundColor = [UIColor blackColor];
    _modalViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.topModalViewController beginAppearanceTransition:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.topModalViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.topModalViewController beginAppearanceTransition:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.topModalViewController endAppearanceTransition];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    for (UIViewController *controller in self.childViewControllers) {
        [controller willRotateToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    for (UIViewController *controller in self.childViewControllers) {
        [controller willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                                     duration:duration];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    for (UIViewController *controller in self.childViewControllers) {
        [controller didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    }
}

#pragma mark - Presenting the compose view controller

- (void)presentComposeModalViewController:(UIViewController *)controller
                                 animated:(BOOL)animated
{
    NSAssert(!self.isPresentingComposeModalViewController, @"A compose view controller is already being presented");

    if (!self.isViewLoaded) {
        [self loadView];
    }

    CGRect frame = self.view.bounds;
    frame.origin.y = frame.size.height;
    _modalViewContainer.frame = frame;

    UIView *modalView = controller.view;
    modalView.frame = _modalViewContainer.bounds;
    modalView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [_modalViewContainer addSubview:modalView];

    _rootViewContainerMask = [[UIView alloc] initWithFrame:self.view.bounds];
    _rootViewContainerMask.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _rootViewContainerMask.backgroundColor = [UIColor blackColor];
    _rootViewContainerMask.alpha = 0;
    [self.view addSubview:_rootViewContainerMask];

    [self.view addSubview:_modalViewContainer];

    [self.rootViewController beginAppearanceTransition:NO animated:animated];
    [controller beginAppearanceTransition:YES animated:animated];

    [self addChildViewController:controller];

    void (^animations)(void) = ^{
        [self performRootViewContainerEffect];

        _rootViewContainerMask.alpha = self.obscuredViewOpacity;

        _modalViewContainer.frame = self.view.bounds;
    };

    void (^completion)(BOOL) = ^(BOOL finished) {
        [controller endAppearanceTransition];
        [self.rootViewController endAppearanceTransition];

        [controller didMoveToParentViewController:self];

        _animating = NO;
        [self resetRootViewContainerEffect];
    };

    if (animated) {
        _animating = YES;
        [UIView animateWithDuration:self.animationDuration animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

- (void)dismissComposeModalViewControllerAnimated:(BOOL)animated
{
    NSAssert(self.isPresentingComposeModalViewController, @"No compose view controller is being presented");

    UIViewController *composeViewController = self.presentedModalViewController;

    [composeViewController beginAppearanceTransition:NO animated:animated];
    [self.rootViewController beginAppearanceTransition:YES animated:animated];

    [composeViewController willMoveToParentViewController:nil];

    void (^animations)(void) = ^{
        [self undoRootViewContainerEffect];

        _rootViewContainerMask.alpha = 0.0f;

        CGRect frame = self.view.bounds;
        frame.origin.y = frame.size.height;
        _modalViewContainer.frame = frame;
    };

    void (^completion)(BOOL) = ^(BOOL finished) {
        [_rootViewContainerMask removeFromSuperview];
        _rootViewContainerMask = nil;

        [_modalViewContainer removeFromSuperview];

        [self.rootViewController endAppearanceTransition];
        [composeViewController endAppearanceTransition];

        [composeViewController.view removeFromSuperview];
        [composeViewController removeFromParentViewController];

        _animating = NO;
    };

    if (animated) {
        _animating = YES;
        [UIView animateWithDuration:self.animationDuration animations:animations completion:completion];
    } else {
        animations();
        completion(YES);
    }
}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    if (!_animating) {
        [self resetRootViewContainerEffect];
    }
}

#pragma mark - Helper methods

- (void)performRootViewContainerEffect
{
    _rootViewContainer.layer.transform = CATransform3DMakeRotation(self.obscuredViewRotation, 1.0f, 0.0f, 0.0f);
}

- (void)undoRootViewContainerEffect
{
    _rootViewContainer.layer.transform = CATransform3DIdentity;
}

- (void)resetRootViewContainerEffect
{
    [self undoRootViewContainerEffect];
    _rootViewContainer.frame = self.view.bounds;

    if (self.isPresentingComposeModalViewController) {
        [self performRootViewContainerEffect];
    }
}

#pragma mark - Properties

- (void)setRootViewController:(UIViewController *)rootViewController
{
    NSAssert(!_rootViewController, @"The rootViewController property can't be changed once it has been set");
    _rootViewController = rootViewController;
}

- (BOOL)isPresentingComposeModalViewController
{
    return self.childViewControllers.count == 2;
}

- (UIViewController *)presentedModalViewController
{
    return self.childViewControllers[1];
}

- (UIViewController *)topModalViewController
{
    if (self.isPresentingComposeModalViewController) {
        return self.presentedModalViewController;
    } else {
        return self.rootViewController;
    }
}

#pragma mark - Storyboard support

- (UIViewController *)viewControllerForUnwindSegueAction:(SEL)action
                                      fromViewController:(UIViewController *)fromViewController
                                              withSender:(id)sender
{
    for (UIViewController *child in self.childViewControllers) {
        if ([child canPerformUnwindSegueAction:action fromViewController:fromViewController withSender:sender]) {
            return child;
        }
    }

    return [super viewControllerForUnwindSegueAction:action
                                  fromViewController:fromViewController
                                          withSender:sender];
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController
                                      fromViewController:(UIViewController *)fromViewController
                                              identifier:(NSString *)identifier
{
    FLComposeViewController *parent = (FLComposeViewController *)fromViewController.parentViewController;
    if ([parent isKindOfClass:[FLComposeViewController class]] && parent.isPresentingComposeModalViewController) {
        return [FLComposeViewControllerSegue segueWithIdentifier:identifier
                                                          source:fromViewController
                                                     destination:toViewController
                                                       unwinding:YES];
    } else {
        return [super segueForUnwindingToViewController:toViewController
                                     fromViewController:fromViewController
                                             identifier:identifier];
    }
}

@end
