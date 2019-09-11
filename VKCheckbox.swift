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

typealias CheckboxValueChangedBlock = (_ isOn: Bool) -> Void

@objc enum VKCheckboxLine: Int
{
    case normal
    case thin
}

class VKCheckbox: UIView
{
    // MARK: - Properties
    
    /**
     Private property which indicates current state of checkbox
     Default value is false
     - See: isOn()
     */
    fileprivate var on: Bool = false
    {
        didSet
        {
            self.checkboxValueChangedBlock?(on)
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
    var bgColor: UIColor = UIColor.clear
    {
        didSet
        {
            if !self.isOn
            {
                self.setBackground(bgColor)
            }
        }
    }
    
    /**
     Set background color of checkbox in selected state
     */
    var bgColorSelected = UIColor.clear
    {
        didSet
        {
            if self.isOn
            {
                self.setBackground(bgColorSelected)
            }
        }
    }
    
    /**
     Set checkmark color
     */
    var color: UIColor = UIColor.blue
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
            self.layer.borderColor = borderColor.cgColor
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
            self.backgroundView.layer.cornerRadius = cornerRadius
        }
    }
    
    /**
     Set line type
     Default value is Normal
     - See: VKCheckboxLine enum
     */
    var line = VKCheckboxLine.normal
    
    // MARK: Private properties
    
    fileprivate var button      = UIButton()
    fileprivate var checkmark   = VKCheckmarkView()
    internal var backgroundView = UIImageView()
    
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
    
    fileprivate func setupView()
    {
        // Init base properties
        self.cornerRadius           = 8
        self.borderWidth            = 3
        self.borderColor            = UIColor.darkGray
        self.color                  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
        
        self.setBackground(UIColor.clear)
        self.backgroundView.frame = self.bounds
        self.backgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.backgroundView.layer.masksToBounds = true
        self.addSubview(self.backgroundView)
        
        // Setup checkmark
        self.checkmark.frame = self.bounds
        self.checkmark.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.addSubview(self.checkmark)
        
        // Setup button
        self.button.frame = self.bounds
        self.button.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        self.button.addTarget(self, action: #selector(VKCheckbox.buttonDidSelected), for: .touchUpInside)
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
    func setOn(_ on: Bool)
    {
        self.setOn(on, animated: false)
    }
    
    /**
     Function allows you to set checkbox state with animation
     - Parameter on Checkbox state
     - Parameter animated Enable anomation
     */
    func setOn(_ on: Bool, animated: Bool)
    {
        self.on = on
        self.showCheckmark(on, animated: animated)
        
        if animated
        {
            UIView.animate(withDuration: 0.275, animations:
            {
                self.setBackground(on ? self.bgColorSelected : self.bgColor)
            })
        }
        else
        {
            self.setBackground(on ? self.bgColorSelected : self.bgColor)
        }
    }
    
    /**
     Function allows to check current checkbox state
     - Returns: State as Bool value
     */
    var isOn: Bool
    {
        return self.on
    }
    
    /// Set checkbox background color
    ///
    /// - Parameter backgroundColor: New color
    internal func setBackground(_ backgroundColor: UIColor)
    {
        self.backgroundView.image = UIImage.from(color: backgroundColor)
    }
}

// MARK: - Private
extension VKCheckbox
{
    @objc fileprivate func buttonDidSelected()
    {
        self.setOn(!self.on, animated: true)
    }
    
    fileprivate func showCheckmark(_ show: Bool, animated: Bool)
    {
        if show == true
        {
            self.checkmark.strokeWidth = self.bounds.width / (self.line == .normal ? 10 : 20)
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
    var color: UIColor = UIColor.blue
    
    fileprivate var animationDuration: TimeInterval = 0.275
    fileprivate var strokeWidth: CGFloat = 0
    
    fileprivate var checkmarkLayer: CAShapeLayer!
    
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
    
    fileprivate func setupCheckmark()
    {
        self.checkmarkLayer             = CAShapeLayer()
        self.checkmarkLayer.fillColor   = nil
    }
}

extension VKCheckmarkView
{
    func show(_ animated: Bool = true)
    {
        self.alpha = 1
        
        self.checkmarkLayer.removeAllAnimations()
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.move(to: CGPoint(x: self.bounds.width * 0.28, y: self.bounds.height * 0.5))
        checkmarkPath.addLine(to: CGPoint(x: self.bounds.width * 0.42, y: self.bounds.height * 0.66))
        checkmarkPath.addLine(to: CGPoint(x: self.bounds.width * 0.72, y: self.bounds.height * 0.36))
        checkmarkPath.lineCapStyle  = .square
        self.checkmarkLayer.path    = checkmarkPath.cgPath
        
        self.checkmarkLayer.strokeColor = self.color.cgColor
        self.checkmarkLayer.lineWidth   = self.strokeWidth
        self.layer.addSublayer(self.checkmarkLayer)
        
        if animated == false
        {
            checkmarkLayer.strokeEnd = 1
        }
        else
        {
            let checkmarkAnimation: CABasicAnimation = CABasicAnimation(keyPath:"strokeEnd")
            checkmarkAnimation.duration = animationDuration
            checkmarkAnimation.isRemovedOnCompletion = false
            checkmarkAnimation.fillMode = CAMediaTimingFillMode.forwards
            checkmarkAnimation.fromValue = 0
            checkmarkAnimation.toValue = 1
            checkmarkAnimation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
            self.checkmarkLayer.add(checkmarkAnimation, forKey:"strokeEnd")
        }
    }
    
    func hide(_ animated: Bool = true)
    {
        var duration = self.animationDuration
        
        if animated == false
        {
            duration = 0
        }
        
        UIView.animate(withDuration: duration, animations:
        {
            self.alpha = 0
        }, completion: {
            (completed) in
            self.checkmarkLayer.removeFromSuperlayer()
        })
        
    }
}

extension UIImage
{
    static func from(color: UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
