//
//  User+Create.swift
//  
//
//  Created by Gabriela Bezerra on 20/08/24.
//

import Foundation

extension User {
    struct Create: Encodable {
        let name: String
        let username: String
        let password: String
    }
}
