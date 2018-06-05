![ElegantExtensions: Easy & Elegant Extensions for Swift](https://i.imgur.com/95jKT5h.png)

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

#### Separator Line

You can add a separator line to the bottom of any view you like

```swift
textField.addSeparatorLine(color: .lightGray)
```

### TableView & CollectionView

Easily create custom cells that will benefit from the extensions.


#### Register Custom Cells

You can register any tableView or collectionView cell. You can interchange cells by changing the dataSource and using some conditioning with either Booleans or Enums

```swift
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(CustomCellOne.self)
        tv.register(CustomCellTwo.self)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellOneActive {
            let cell = tableView.dequeueReusableCell(CustomCell.self, for: indexPath)
            let model = models[indexPath.row]
            
            cell.configureWithModel(model)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(CustomCell.self, for: indexPath)
            let model = models[indexPath.row]
            
            cell.configureWithModel(model)
            
            return cell
        }
    }       
```

#### Configurable

For improved abstraction, your views can conform to the "Configurable" protocol. It is very useful combined with custom cells

```swift
class CustomCellOne: UITableViewCell, Configurable {
    var model: String?
    
    let titleLabel = Label()
    
    func configureWithModel(_ title: String) {
        self.model = title
        
        titleLabel.text = title
    }
    
    // ... Layout views in initializer
}
```

### ViewController & Alerts

#### Wrapped in NavigationController

Easily wrap your ViewController in a NavigationController

```swift
let viewController = ViewController()
present(viewController.wrapped(), animated: true, completion: nil)
```

#### TopViewController

Returns the TopViewController 

```swift
class ResultsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topViewController = self.topViewController
    }
}

```

#### Alert With Handler

Shows an alert with a completion handler. Set cancelable to false if you don't need a cancel button

```swift
alert(title: "Title", message: "Message", cancelable: true) { (action) in
     // Do something when OK clicked
}
```

#### Alert Error

Shows an error alert in case you get one

```swift
       alert(error: err)
```

### NSAttributedString

#### Creating A Custom String

If you need a specific string to be of a specific font or color, you can use this

```swift
let label = UILabel()
        
let attributedString = NSAttributedString.String("My String", font: .boldSystemFont(ofSize: 20), color: .red)
label.attributedText = attributedString
```

## Author

Giancarlo Buenaflor, giancarlo_buenaflor@yahoo.com

## License

ElegantExtensions is available under the MIT license. See the LICENSE file for more info.

##
