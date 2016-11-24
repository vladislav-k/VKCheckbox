//
//  VKCheckbox.swift
//  VKCheckbox
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

typealias CheckboxValueChangedBlock = (isOn: Bool) -> Void

@objc enum VKCheckboxLine: Int
{
    case Normal
    case Thin
}

class VKCheckbox: UIView
{
    // MARK: - Properties
    
    /**
     Private property which indicates current state of checkbox
     Default value is false
     - See: isOn()
     */
    private var on: Bool = false
    {
        didSet
        {
            self.checkboxValueChangedBlock?(isOn: on)
        }
    }
    
    /**
     Closure which called when property 'on' is changed
     */
    var checkboxValueChangedBlock: CheckboxValueChangedBlock?
    
    // MARK: Customization
    
    /**
     Set background color of checkbox
     */
    var bgColor: UIColor = UIColor.clearColor()
    {
        didSet
        {
            if !self.isOn()
            {
                self.backgroundColor = bgColor
            }
        }
    }
    
    /**
     Set background color of checkbox in selected state
     */
    var bgColorSelected = UIColor.clearColor()
    {
        didSet
        {
            if self.isOn()
            {
                self.backgroundColor = bgColorSelected
            }
        }
    }
    
    /**
     Set checkmark color
     */
    var color: UIColor = UIColor.blueColor()
    {
        didSet
        {
            self.checkmark.color = color
        }
    }
    
    /**
     Set checkbox border width
     */
    var borderWidth: CGFloat = 0
    {
        didSet
        {
            self.layer.borderWidth = borderWidth
        }
    }
    
    /**
     Set checkbox border color
     */
    var borderColor: UIColor!
    {
        didSet
        {
            self.layer.borderColor = borderColor.CGColor
        }
    }
    
    /**
     Set checkbox corner radius
     */
    var cornerRadius: CGFloat = 0
    {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    /**
     Set line type
     Default value is Normal
     - See: VKCheckboxLine enum
     */
    var line = VKCheckboxLine.Normal
    
    // MARK: Private properties
    
    private var button    = UIButton()
    private var checkmark = VKCheckmarkView()
    
    // MARK: - Init
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView()
    {
        // Init base properties
        self.backgroundColor        = UIColor.clearColor()
        self.cornerRadius           = 8
        self.borderWidth            = 3
        self.borderColor            = UIColor.darkGrayColor()
        self.color                  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        
        // Setup checkmark
        self.checkmark.frame = self.bounds
        self.checkmark.autoresizingMask = [.FlexibleWidth, .FlexibleHeight];
        self.addSubview(self.checkmark)
        
        // Setup button
        self.button.frame = self.bounds
        self.button.autoresizingMask = [.FlexibleWidth, .FlexibleHeight];
        self.button.addTarget(self, action: #selector(VKCheckbox.buttonDidSelected), forControlEvents: .TouchUpInside)
        self.addSubview(self.button)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.button.bounds    = self.bounds
        self.checkmark.bounds = self.bounds
    }
}

// MARK: - Public
extension VKCheckbox
{
    /**
     Function allows you to set checkbox state
     - Parameter on Checkbox state
     */
    func setOn(on: Bool)
    {
        self.setOn(on, animated: false)
    }
    
    /**
     Function allows you to set checkbox state with animation
     - Parameter on Checkbox state
     - Parameter animated Enable anomation
     */
    func setOn(on: Bool, animated: Bool)
    {
        self.on = on
        self.showCheckmark(on, animated: animated)
        
        if animated
        {
            UIView.animateWithDuration(0.275, animations:
            {
                self.backgroundColor = on ? self.bgColorSelected : self.bgColor
            })
        }
        else
        {
            self.backgroundColor = on ? self.bgColorSelected : self.bgColor
        }
    }
    
    /**
     Function allows to check current checkbox state
     - Returns: State as Bool value
     */
    func isOn() -> Bool
    {
        return self.on
    }
}

// MARK: - Private
extension VKCheckbox
{
    @objc private func buttonDidSelected()
    {
        self.setOn(!self.on, animated: true)
    }
    
    private func showCheckmark(show: Bool, animated: Bool)
    {
        if show == true
        {
            self.checkmark.strokeWidth = CGRectGetWidth(self.bounds) / (self.line == .Normal ? 10 : 20)
            self.checkmark.show(animated)
        }
        else
        {
            self.checkmark.hide(animated)
        }
    }
}

//
//  VKCheckbox.swift
//  VKCheckmarkView
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
private class VKCheckmarkView: UIView
{
    var color: UIColor = UIColor.blueColor()
    
    private var animationDuration: NSTimeInterval = 0.275
    private var strokeWidth: CGFloat = 0
    
    private var checkmarkLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.setupCheckmark()
    }
    
    required override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setupCheckmark()
    }
    
    private func setupCheckmark()
    {
        self.checkmarkLayer             = CAShapeLayer();
        self.checkmarkLayer.fillColor   = nil;
        
        self.backgroundColor = UIColor.clearColor()
    }
}

extension VKCheckmarkView
{
    func show(animated: Bool)
    {
        self.alpha = 1
        
        self.checkmarkLayer.removeAllAnimations()
        
        let checkmarkPath = UIBezierPath();
        checkmarkPath.moveToPoint(CGPointMake(CGRectGetWidth(self.bounds) * 0.28, CGRectGetHeight(self.bounds) * 0.5))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.bounds) * 0.42, CGRectGetHeight(self.bounds) * 0.66))
        checkmarkPath.addLineToPoint(CGPointMake(CGRectGetWidth(self.bounds) * 0.72, CGRectGetHeight(self.bounds) * 0.36))
        checkmarkPath.lineCapStyle  = .Square
        self.checkmarkLayer.path    = checkmarkPath.CGPath;
        
        self.checkmarkLayer.strokeColor = self.color.CGColor;
        self.checkmarkLayer.lineWidth   = self.strokeWidth;
        self.layer.addSublayer(self.checkmarkLayer)
        
        if animated == false
        {
            checkmarkLayer.strokeEnd = 1
        } else {
            let checkmarkAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
            checkmarkAnimation.duration = animationDuration
            checkmarkAnimation.removedOnCompletion = false
            checkmarkAnimation.fillMode = kCAFillModeBoth
            checkmarkAnimation.fromValue = 0
            checkmarkAnimation.toValue = 1
            checkmarkAnimation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseIn)
            self.checkmarkLayer.addAnimation(checkmarkAnimation, forKey:"strokeEnd")
        }
    }
    
    func hide(animated: Bool)
    {
        var duration = self.animationDuration
        
        if animated == false
        {
            duration = 0
        }
        
        UIView.animateWithDuration(duration, animations:
        {
            self.alpha = 0
        })
        {
            (completed) in
            self.checkmarkLayer.removeFromSuperlayer()
        }
    }
}
