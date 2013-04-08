// FLComposeViewControllerSegue.m
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

#import "FLComposeViewControllerSegue.h"
#import "UIViewController+FLComposeViewController.h"

@implementation FLComposeViewControllerSegue

+ (instancetype)segueWithIdentifier:(NSString *)identifier
                             source:(UIViewController *)source
                        destination:(UIViewController *)destination
                          unwinding:(BOOL)unwinding
{
    return [[self alloc] initWithIdentifier:identifier
                                     source:source
                                destination:destination
                                  unwinding:unwinding];
}

- (id)initWithIdentifier:(NSString *)identifier
                  source:(UIViewController *)source
             destination:(UIViewController *)destination
               unwinding:(BOOL)unwinding
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        self.unwinding = unwinding;
    }
    return self;
}

- (void)perform
{
    UIViewController *source = (UIViewController *)self.sourceViewController;
    UIViewController *destination = (UIViewController *)self.destinationViewController;

    if (self.unwinding) {
        [source.fl_parentComposeViewController dismissComposeModalViewControllerAnimated:YES];
    } else {
        [source.fl_parentComposeViewController presentComposeModalViewController:destination animated:YES];
    }
}

@end
