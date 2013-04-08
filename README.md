**WARNING**: `presentModalViewController:animated:` and `dismissModalViewController:animated:` are no longer overriden. For existing code, you **must** use `presentComposeModalViewController:animated:` and `dismissComposeModalViewController:animated:` instead.

## Introduction

FLComposeViewController is an [iOS container view controller][containers] that presents modal view controllers. The presentation animations are heavily inspired by the [Gmail iOS app][gmailapp].

[containers]: http://developer.apple.com/library/ios/#featuredarticles/ViewControllerPGforiPhoneOS/CreatingCustomContainerViewControllers/CreatingCustomContainerViewControllers.html
[gmailapp]: https://itunes.apple.com/us/app/gmail-email-from-google/id422689480?mt=8

![FLComposeViewController screenshot](https://raw.github.com/fernandotcl/FLComposeViewController/master/screenshot.png)

## Getting started

To use FLComposeViewController:

1. Add the contents of the `FLComposeViewController` folder to your project.

2. Add the Quartz Core framework to your project.

3. Enable `UIViewEdgeAntialiasing` ("Renders with edge antialiasing") in your `Info.plist` file.

4. Instantiate `FLComposeViewController` and set its root view controller.

If you use storyboards, you might want to manually instantiate the initial view controller in your app delegate  and set it as the root view controller of your `FLComposeViewController` object:

```objective-c
#include "FLComposeViewController.h"

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *initialVC = [storyboard instantiateInitialViewController];
    FLComposeViewController *controller = [[FLComposeViewController alloc]
        initWithRootViewController:initialVC];
    self.window.rootViewController = controller;

    return YES;
}
```

Then you can use `FLComposeViewControllerSegue` as a custom segue in your storyboard.

If you're not using storyboards, you can still use FLComposeViewController. The `FLComposeViewController` category on `UIViewController` can help you present and dismiss modal view controllers through the compose view controller:

```objective-c
#include "UIViewController+FLComposeViewController.h"

- (IBAction)myPresentButtonTouched:(id)sender
{
    UIViewController *controller = [self instantiateMyViewController];
    [self fl_presentComposeModalViewController:controller animated:YES];
}

- (IBAction)myDismissButtonTouched:(id)sender
{
    [self fl_dismissModalViewControllerAnimated:YES];
}
```

You can mix and match storyboards, nibs and programatically created view controllers, of course. You can also use other container view controllers such as `UINavigationViewController` as parents or children of `FLComposeViewController` objects. If you nest container view controllers, though, you may not be able to use container-specific segues directly from the storyboard.

## Requirements

FLComposeViewController requires iOS 5.0 or greater and uses ARC. If you are using FLComposeViewController in a non-ARC project, you will need to set the `-fobjc-arc` compiler flag on all of the FLComposeViewController source files.

## Documentation

FLComposeViewController uses comments in [appledoc][] format. The `appledoc.sh` script can be used to create a `help` folder and populate it with documentation generated from the source comments.

[appledoc]: http://gentlebytes.com/appledoc/

## Credits

FLComposeViewController was created by [Fernando Tarlá Cardoso Lemos](mailto:fernandotcl@gmail.com).

## License

FLComposeViewController is available under the MIT license. See the LICENSE file for more information.
