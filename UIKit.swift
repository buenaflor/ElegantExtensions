//
//  UIKit.swift
//  ElegantExtensions
//
//  Created by Giancarlo on 05.06.18.
//


import UIKit


// MARK: - UIView Extensions

public extension UIView {
    
    /// Adds the selected view to the superview and create constraints through the closure block
    public func add(subview: UIView, createConstraints: (_ view: UIView, _ parent: UIView) -> ([NSLayoutConstraint])) {
        addSubview(subview)
        
        subview.activate(constraints: createConstraints(subview, self))
    }
    
    /// Removes specified views in the array
    public func remove(subviews: [UIView]) {
        subviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
    /// Activates the given constraints
    public func activate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Deactivates the give constraints
    public func deactivate(constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.deactivate(constraints)
    }
    
    /// Lays out the view to fill the superview
    public func fillToSuperview(_ subview: UIView) {
        if #available(iOS 11.0, *) {
            self.add(subview: subview) { (v, p) in [
                v.topAnchor.constraint(equalTo: p.safeAreaLayoutGuide.topAnchor),
                v.leadingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: p.safeAreaLayoutGuide.trailingAnchor),
                v.bottomAnchor.constraint(equalTo: p.safeAreaLayoutGuide.bottomAnchor)
                ]}
        }
    }
    
    /// Adds a separator line at the bottom of a view
    public func addSeparatorLine(color: UIColor) {
        let view = UIView()
        view.backgroundColor = color
        if #available(iOS 9.0, *) {
            add(subview: view) { (v, p) in [
                v.bottomAnchor.constraint(equalTo: p.bottomAnchor),
                v.leadingAnchor.constraint(equalTo: p.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: p.trailingAnchor),
                v.heightAnchor.constraint(equalToConstant: 0.5)
                ]}
        }
    }
    
}


// MARK: - ReusableView Protocol & Configurable

/// Protocol for making dataSourcing a cell easier
public protocol Configurable {
    associatedtype T
    var model: T? { get set }
    func configureWithModel(_: T)
}

/// Protocol for setting the defaultReuseIdentifier
public protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    
    /// Grabs the defaultReuseIdentifier through the class name
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}


// MARK: - TableView Generics

extension UITableViewCell: ReusableView { }
extension UITableView {
    
    /// Custom Generic function for registering a TableViewCell
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(type.self, forCellReuseIdentifier: type.defaultReuseIdentifier)
    }
    
    /// Custom Generic function for dequeueing a TableViewCell
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(type.defaultReuseIdentifier)")
        }
        return cell
    }
    
    /// Deselects row at given IndexPath
    func deselectRow() {
        guard let indexPath = indexPathForSelectedRow else { return }
        self.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - CollectionView Generics

extension UICollectionViewCell: ReusableView { }
extension UICollectionView {
    
    /// Custom Generic function for registering a CollectionViewCell
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.defaultReuseIdentifier)
    }
    
    /// Custom Generic function for dequeueing a TableViewCell
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(type.defaultReuseIdentifier)")
        }
        
        return cell
    }
}


// MARK: - UIImageView

public extension UIImageView {
    
    public func setImage(_ image: UIImage, with renderingMode: UIImageRenderingMode, tintColor: UIColor) {
        self.image = image.withRenderingMode(renderingMode)
        self.tintColor = tintColor
    }
}

// MARK: - Alert

public extension UIViewController {
    
    /// Wraps the ViewController in a UINavigationController
    public func wrapped() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
    /// Shows an alert message with a completion handler
    public func alert(title: String? = nil, message: String? = nil, cancelable: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.okAction(handler))
        
        if cancelable {
            alertController.addAction(.cancelAction())
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    /// Retrieve the top view controller
    public var topViewController: UIViewController {
        if let overVC = presentedViewController, !overVC.isBeingDismissed {
            return overVC.topViewController
        }
        return self
    }
}


// MARK: UIAlertAction

extension UIAlertAction {
    /// Creates a standard "OK" action handler
    public class func okAction(_ handler: ((_ action: UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: handler)
    }
    
    /// Creates a standard "Cancel" action handler
    public class func cancelAction(_ handler: ((_ action: UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }
}


// MARK: - NSAttributedString

public extension NSAttributedString {
    
    /// Returns an Attributed String with a specific font and color
    static func String(_ string: String, font: UIFont, color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [NSAttributedStringKey.font : font, NSAttributedStringKey.foregroundColor: color])
    }
}



