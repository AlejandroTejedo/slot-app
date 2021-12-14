//
//  LazyView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 7/12/21.
//

import SwiftUI

struct LazyView<Content:View>: View {
    
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body : Content { build() }
    
}
