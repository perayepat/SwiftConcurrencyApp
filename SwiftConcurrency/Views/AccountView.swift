//
//  AccountView.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/28.
//

import SwiftUI

struct AccountView: View {
    @StateObject var accountViewModel = AccountViewModel()
    @State private var user: User?
    
    var body: some View {
        VStack{
            if let user = user {
                ProfileCard(user: user)
                    .padding(.horizontal, 8)
            } else{
                Text("No User")
            }
        }
        
        
            .task {
                do {
                    user = try await accountViewModel.getUser()
                }
                catch{
                    print("Error while getting the user \(error)")
                }
            }
                
            
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(AccountViewModel())
    }
}
