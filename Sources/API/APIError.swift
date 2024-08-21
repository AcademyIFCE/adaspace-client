//
//  APIError.swift
//  
//
//  Created by Gabriela Bezerra on 20/08/24.
//

import Foundation

enum APIError: Error {
    case apiError(code: Int, body: Data?)
}
