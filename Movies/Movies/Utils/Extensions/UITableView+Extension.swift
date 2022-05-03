//
//  UITableView+Extension.swift
//  Movies
//
//  Created by Pierre Chamorro on 2/05/22.
//

import Foundation
import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(cell: T.Type) {
        register(UINib(nibName: "\(T.self)", bundle: nil), forCellReuseIdentifier: "\(T.self)")
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        return cell
    }
}
