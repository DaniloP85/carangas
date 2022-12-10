//
//  UIViewController+Instantiate.swift
//  Carangas
//
//  Created by pos on 29/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: name) as! Self
    }
}
