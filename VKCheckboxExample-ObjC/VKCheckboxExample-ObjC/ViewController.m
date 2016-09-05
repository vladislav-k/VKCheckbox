//
//  ViewController.m
//  VKCheckboxExample-ObjC
//
//  Created by Vladislav Kovalyov on 9/1/16.
//  Copyright © 2016 WOOPSS.com http://woopss.com/ All rights reserved.
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
//

#import "ViewController.h"
#import "VKCheckboxExample_ObjC-Swift.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet VKCheckbox *checkbox;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Customized checkbox
    self.checkbox.line             = VKCheckboxLineThin;
    self.checkbox.bgColorSelected  = [[UIColor alloc] initWithRed: 46.0f/255.0f green: 119.0f/255.0f blue: 217.0f/255.0f alpha: 1];
    self.checkbox.bgColor          = [UIColor grayColor];
    self.checkbox.color            = [UIColor whiteColor];
    self.checkbox.borderColor      = [UIColor whiteColor];
    self.checkbox.borderWidth      = 2;
    self.checkbox.cornerRadius     = CGRectGetHeight(self.checkbox.frame) / 2;

    // Handle custom checkbox callback
    self.checkbox.checkboxValueChangedBlock = ^(BOOL isOn) {
        NSLog(@"Custom checkbox is %@", isOn ? @"ON" : @"OFF");
    };
}

- (IBAction)buttonReset:(id)sender
{
    [self.checkbox setOn:false animated:true];
}


@end
