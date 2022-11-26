//
//  Extension + UIAlertController.swift
//  TaskList
//
//  Created by leogoba on 24.11.2022.
//

import Foundation

extension UIAlertController {
    
    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "What do you want to do?", preferred)
    }
}
