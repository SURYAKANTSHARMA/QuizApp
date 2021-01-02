//
//  UITableViewExtensions.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 17/12/20.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T {
        let className = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T else {
            fatalError()
        }
        return cell
    }
}
