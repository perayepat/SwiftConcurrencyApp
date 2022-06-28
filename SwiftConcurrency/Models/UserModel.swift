//
//  UserModel.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/28.
//
///this is from "https://jsonplaceholder.typicode.com/users"
///using those users as placeholders to model our data

import Foundation

struct User: Identifiable, Decodable{
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: Address
    var company: Company
    
    //A struct for the address
    struct Address: Decodable{
        var street: String
        var suite: String
        var city: String
        var zipcode: String
        var geo: Geo
        
        //A struct for the Geo
        struct Geo: Decodable{
            var lat: String
            var lng: String
        }
    }
    
    struct Company: Decodable{
        var name: String
        var catchPhrase: String
        var bs: String
    }
}

//same as a class, capablities are just isolated
// allowed us to protect the content vairable from data races
actor Description{
    var content: String
    
    init(content: String){
        self.content = content
    }
}
//accessing it outside this function is done async
extension Description{
    func update(with newContent: String){
        self.content = newContent
    }
}

//{
//  "id": 1,
//  "name": "Leanne Graham",
//  "username": "Bret",
//  "email": "Sincere@april.biz",
//  "address": {
//    "street": "Kulas Light",
//    "suite": "Apt. 556",
//    "city": "Gwenborough",
//    "zipcode": "92998-3874",
//    "geo": {
//      "lat": "-37.3159",
//      "lng": "81.1496"
//    }
//  },
//  "phone": "1-770-736-8031 x56442",
//  "website": "hildegard.org",
//  "company": {
//    "name": "Romaguera-Crona",
//    "catchPhrase": "Multi-layered client-server neural-net",
//    "bs": "harness real-time e-markets"
//  }
//}
