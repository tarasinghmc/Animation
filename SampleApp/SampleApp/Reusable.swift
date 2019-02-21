//
//  Reusable.swift
//  SampleApp
//
//  Created by Tara Singh M C on 15/02/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

protocol IdentifiableNib: Identifiable {}

extension IdentifiableNib {
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: Bundle.main)
    }
}

extension UITableViewCell: Identifiable {}
extension UITableViewHeaderFooterView: Identifiable {}
extension UICollectionReusableView: Identifiable {}
extension UIViewController: Identifiable {}


extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_ viewController: T.Type) -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: viewController.identifier) as? T else {
            
            preconditionFailure("Unable to instantiate \(T.description())")
            
        }
        
        return viewController
    }
    
}

extension UITableView {
    
    public func registerCells<T: UITableViewCell>(_ cells: [T.Type]) {
        cells.forEach { register($0) }
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        if let cell = cell as? IdentifiableNib.Type {
            self.register(cell.nib, forCellReuseIdentifier: cell.identifier)
        } else {
            self.register(cell, forCellReuseIdentifier: cell.identifier)
        }
    }
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T else {
            preconditionFailure("Unable to dequeue \(T.description()) for indexPath: \(indexPath)")
        }
        return cell
    }
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cell.identifier) as? T else {
            preconditionFailure("Unable to dequeue \(T.description())")
        }
        return cell
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ view: T.Type) {
        if let view = view as? IdentifiableNib.Type {
            self.register(view.nib, forHeaderFooterViewReuseIdentifier: view.identifier)
        } else {
            self.register(view, forHeaderFooterViewReuseIdentifier: view.identifier)
        }
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ view: T.Type) -> T {
        guard let headerFooterView = self.dequeueReusableHeaderFooterView(withIdentifier: view.identifier) as? T else {
            preconditionFailure("Unable to dequeue \(T.description()) for indexPath: \(indexPath)")
        }
        return headerFooterView
    }
}

extension UICollectionView {
    
    func register<T: UICollectionReusableView>(_ view: T.Type, forSupplementaryViewOfKind elementKind: String) {
        if let view = view as? IdentifiableNib.Type {
            self.register(view.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: view.identifier)
        } else {
            self.register(view, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: view.identifier)
        }
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ view: T.Type, ofKind elementKind: String, for indexPath: IndexPath) -> T {
        
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: view.identifier, for: indexPath) as? T else {
            
            preconditionFailure("Unable to dequeue \(T.description()) for indexPath: \(indexPath)")
        }
        
        return view
    }
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, forIndexPath indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T else {
            preconditionFailure("Unable to dequeue \(T.description()) for indexPath: \(indexPath)")
        }
        return cell
    }
}


