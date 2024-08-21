//
//  Session.swift
//  
//
//  Created by Gabriela Bezerra on 20/08/24.
//

import Foundation

struct Session: Decodable {
    let token: String
    let user: User
}
