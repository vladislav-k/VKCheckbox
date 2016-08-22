# VKCheckbox
## Description
**VKCheckbox** is a simple customizable closure-based checkbox control written on Swift<br>

![VKCheckbox Demo](https://github.com/vladislav-k/VKCheckbox/blob/master/Demo.gif?raw=true)

## Installation
For now you can install **VKCheckbox** manually only. Just add class `VKCheckbox.swift` folder into your project.

## Example project
Example project shows how you can create both basic and custom **VKCheckbox** in one controller.
To test it it, clone the repo and run it from the VKCheckboxExample directory. 

## Usage
Here is an example of custom round checkbox initialization:
```swift
// Customized checkbox
customCheckbox.line             = .Thin
customCheckbox.bgColorSelected  = UIColor(red: 46/255, green: 119/255, blue: 217/255, alpha: 1)
customCheckbox.bgColor          = UIColor.grayColor()
customCheckbox.color            = UIColor.whiteColor()
customCheckbox.borderColor      = UIColor.whiteColor()
customCheckbox.borderWidth      = 2
customCheckbox.cornerRadius     = CGRectGetHeight(customCheckbox.frame) / 2

// Handle state update
customCheckbox.checkboxValueChangedBlock = {
	isOn in
	print("Custom checkbox is \(isOn ? "ON" : "OFF")")
}
```
Work of **VKCheckbox** is similliar to `UISwitch`. You can make it selected using next functions:

```swift
// Change state
func setOn(on: Bool)
func setOn(on: Bool, animated: Bool)

// Also you can check current state with new function
func isOn() -> Bool
```

## Author
Vladislav Kovalyov, http://woopss.com/

## License
**VKCheckbox** is available under the MIT License. See the LICENSE file for more info.