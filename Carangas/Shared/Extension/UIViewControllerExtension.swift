//
//  UIViewControllerExtension.swift
//  Carangas
//
//  Created by Valmir Junior on 17/10/20.
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instatiate(from storyBoard: UIStoryboard) -> Self {
        let name = String(describing: self)
        return storyBoard.instantiateViewController(withIdentifier: name) as! Self
    }
}
