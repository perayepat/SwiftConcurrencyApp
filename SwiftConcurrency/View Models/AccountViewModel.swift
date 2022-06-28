    //
    //  AccountViewModel.swift
    //  SwiftConcurrency
    //
    //  Created by IACD-013 on 2022/06/28.
    //
/// `Await` lets other get done on the thread simultaneously
///`Throws` lets the system know the function can throw an error, same as `try`

import Foundation

    
class AccountViewModel: ObservableObject{
    func getUser() async throws -> User{
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/1") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error while fetching error")}
        
        let decodedUser = try JSONDecoder().decode(User.self, from: data)
        return decodedUser
        
    }
}
