//
//  User.swift
//
//
//  Created by Gabriela Bezerra on 20/08/24.
//

import Foundation

struct User: Decodable {
    let id: UUID
    let username: String
    let name: String
    let avatar: String?
}
