//
//  Extensions.swift
//  GoSlotNativa
//
//  Created by Alejandro on 24/10/21.
//

import UIKit

extension UIApplication {
    func endEditing () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
