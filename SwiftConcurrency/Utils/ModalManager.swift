//
//  ModalManager.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/27.
//

import Foundation

class ModalManager: ObservableObject{
    enum ActiveModals{
        case signIn
        case signUp
        case resetPassword
    }
    
    @Published public var showModal:Bool = false
    @Published public var activeModal: ActiveModals = .signIn
}
