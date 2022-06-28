//
//  ModalManagerView.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/27.
//

import SwiftUI

//listen for the active modal and display the active modal

struct ModalManagerView: View {
    @EnvironmentObject var modalManager: ModalManager
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    modalManager.showModal.toggle()
                    //reset to the sign in when the user dismisses the view
                    modalManager.activeModal = .signIn
                }
            
            //display the corresponding modal
            switch modalManager.activeModal{
            case .signIn:
                SignInView()
            case.signUp:
                SignUpView()
            case.resetPassword:
                ResetPasswordView()
                
            }
                
        }
    }
}

struct ModalManagerView_Previews: PreviewProvider {
    static var previews: some View {
        ModalManagerView()
            .environmentObject(ModalManager())
    }
}
