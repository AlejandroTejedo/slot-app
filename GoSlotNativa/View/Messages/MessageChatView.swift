//
//  MessageChatView.swift
//  GoSlotNativa
//
//  Created by Alejandro on 9/12/21.
//

import SwiftUI

struct MessageChatView: View {
    
    @State var message = ""
    @ObservedObject var viewModel: MessagesViewModel
    @State var scrolled = false
    
    init(userId: String) {
        self.viewModel = MessagesViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
            
            ScrollViewReader { reader in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            MessageRowView(message: message)
                                .onAppear {
                                    if message.id == viewModel.messages.last?.id && !scrolled {
                                        reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: viewModel.messages) { _ in
                            reader.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            MessageInputView(message: $message, action: sendMessage)
        }
    }
    
    func sendMessage() {
        viewModel.sendMessage(message: message)
        message = ""
        print("Mensaje enviado")
    }
}


