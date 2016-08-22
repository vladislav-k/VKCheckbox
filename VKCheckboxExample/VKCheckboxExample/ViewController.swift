//
//  ViewController.swift
//  VKCheckboxExample
//
//  Created by Vladislav Kovalyov on 8/22/16.
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

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var checkbox: VKCheckbox!
    @IBOutlet weak var customCheckbox: VKCheckbox!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Simple checkbox callback
        checkbox.checkboxValueChangedBlock = {
            isOn in
            print("Basic checkbox is \(isOn ? "ON" : "OFF")")
        }
        
        // Customized checkbox
        customCheckbox.line             = .Thin
        customCheckbox.bgColorSelected  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        customCheckbox.bgColor          = UIColor.grayColor()
        customCheckbox.color            = UIColor.whiteColor()
        customCheckbox.borderColor      = UIColor.whiteColor()
        customCheckbox.borderWidth      = 2
        customCheckbox.cornerRadius     = CGRectGetHeight(customCheckbox.frame) / 2
        
        // Handle custom checkbox callback
        customCheckbox.checkboxValueChangedBlock = {
            isOn in
            print("Custom checkbox is \(isOn ? "ON" : "OFF")")
        }
    }
}

// MARK: - Actions
extension ViewController
{
    @IBAction func onReset(sender: AnyObject)
    {
        self.checkbox.setOn(false)
        self.customCheckbox.setOn(false, animated: true)
    }
    
}