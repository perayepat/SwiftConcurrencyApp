//
//  Network.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/26.
//

import Foundation
import Apollo

class Network{
    
    /// set using lazy so its only created when needed as to not effect other things in the program 
    static let shared = Network()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "https://graphql.contentful.com/content/v1/spaces/n91b5lztcrt2?access_token=on9bb_q-U1yFbwof8GkRWScnF6s6TmkKunC3-iceljw")!)
}
