# ElegantExtensions

[![Version](https://img.shields.io/cocoapods/v/ElegantExtensions.svg?style=flat)](https://cocoapods.org/pods/ElegantExtensions)
[![License](https://img.shields.io/cocoapods/l/ElegantExtensions.svg?style=flat)](https://cocoapods.org/pods/ElegantExtensions)
[![Platform](https://img.shields.io/cocoapods/p/ElegantExtensions.svg?style=flat)](https://cocoapods.org/pods/ElegantExtensions)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11.0+
- Xcode 9.0+
- Swift 4.0+

## Installation

ElegantExtensions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ElegantExtensions'
```

## Features

- [x] Easy AutoLayout
- [x] Configurable Cells
- [x] Flexible TableView & CollectionView
- [x] NavigationController Wrapper
- [x] Alerts
- [x] Attributed Strings

## Usage

### AutoLayout Constraints

Using AutoLayout can be very tedious and tiring. The integrated and easy-to-use extensions can give you a helping hand in creating complicated layouts.

Things to consider when layouting:

- Correct usage of AutoLayout means that you need 4 constraints
- Exceptions are some views such as UILabel, UITextView, UIActivityIndicatorView

#### Superview Layouting

Layouting a subview to the entire view. This might be useful if you want to create a wrapper for specific backgrounds.

```swift
// Constraints the subview to all anchors of the parent view
view.fillToSuperview(tableView)
```

#### Custom Constraints

We can easily use custom constraints by adding the subview to the parent view

```swift
// Constraints the subview with custom constraints to the parent view 
view.add(subview: tableView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
            v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
            v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
```


Constraining the view based on another view's anchor is also possible. In this case, the label only needs two constraints because the label automatically calculates width and height.

WARNING: Only use two constraints if you are absolutely sure that the label width will not exceed the parent view width or else it will expand.

```swift
// Constraints the subview with custom constraints to the parent view 
view.add(subview: imageView) { (v, p) in [
            v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor),
            v.widthAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5),
            v.heightAnchor.constraint(equalTo: p.heightAnchor, multiplier: 0.5)
            ]}
            
view.add(subview: label) { (v, p) in [
            v.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            v.centerXAnchor.constraint(equalTo: p.centerXAnchor)
            ]}
```

#### Deactivating Constraints

If you store the constraints outside of your AutoLayouting configurations, you can disable them anytime.

```swift
let buttonWidthConstraint: NSLayoutConstraint?
let buttonHeightConstraint: NSLayoutConstraint?
let buttonTopAnchorConstraint: NSLayoutConstraint?
let buttonCenterXAnchorConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCenterXAnchorConstraint = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        buttonTopAnchorConstraint = button.topAnchor.constraint(equalTo: view.topAnchor)
        buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 80)
        buttonWidthConstraint = button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        
        guard 
            let buttonWidthConstraint = buttonWidthConstraint,
            let buttonHeightConstraint = buttonHeightConstraint,
            let buttonCenterXAnchorConstraint = buttonCenterXAnchorConstraint,
            let buttonTopAnchorConstraint = buttonTopAnchorConstraint
            else { return }
            
        view.add(subview: button) { (v, p) in [
            buttonCenterXAnchorConstraint,
            buttonTopAnchorConstraint,
            buttonHeightConstraint,
            buttonWidthConstraint
            ]}
            
        // Deactivate Constraints
        view.deactivate(constraints: [
            buttonCenterXAnchorConstraint,
            buttonTopAnchorConstraint,
            buttonHeightConstraint,
            buttonWidthConstraint
        ])
    }
```

## Author

Giancarlo Buenaflor, giancarlo_buenaflor@yahoo.com

## License

ElegantExtensions is available under the MIT license. See the LICENSE file for more info.

##
