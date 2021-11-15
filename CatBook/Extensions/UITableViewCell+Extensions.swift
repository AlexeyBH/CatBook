//
//  UITableViewCell+Extensions.swift
//  CatBook
//
//  Created by Михаил Зиновьев on 15.11.2021.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib  : UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
}
