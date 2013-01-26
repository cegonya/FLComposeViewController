// MainViewController.m
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

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationBar sizeToFit];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [self.navigationBar sizeToFit];
}

- (IBAction)unwindFromModalViewController:(UIStoryboardSegue *)segue
{
    // This is intentionally left blank. The existence of this
    // method tells the storyboard system that it can unwind
    // from a controller deeper in the hierarchy (such as the
    // modal view controller) and end up here.
}

@end
