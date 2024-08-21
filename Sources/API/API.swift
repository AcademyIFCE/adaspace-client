//
//  API.swift
//  
//
//  Created by Gabriela Bezerra on 20/08/24.
//

import Foundation

enum API {

    static func searchUsers(on baseURL: URL) async throws -> [User] {
        let url = baseURL.appending(path: "users")
        let (data, response) = try await URLSession.shared.data(from: url)

        try check(data: data, response: response)
        // DECODE! Bytes -> [User]
        let users = try JSONDecoder().decode([User].self, from: data)
        return users
    }

    static func check(data: Data?, response: URLResponse) throws {
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200..<300:
                print("😸 Sucesso! \(response.statusCode)")
            default:
                print("🙀 Erro \(response.statusCode)")
                throw APIError.apiError(code: response.statusCode, body: data)
            }
        }
    }

    static func createUser(on baseURL: URL) async throws -> String {
        let url = baseURL.appending(path: "users")

        let create = User.Create(name: "Lorem Ipsum", username: "lorem-ipsum", password: "12345")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(create)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]

        let (data, response) = try await URLSession.shared.data(for: request)

        try check(data: data, response: response)

        let session = try JSONDecoder().decode(Session.self, from: data)

        return session.token
    }

    static func login(on baseURL: URL) async throws -> String {
        let url = baseURL.appending(path: "users/login")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let username = "lorem.ipsum"
        let password = "12345"

        let auth = (username + ":" + password).data(using: .utf8)!.base64EncodedString()

        request.setValue("Basic \(auth)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        try check(data: data, response: response)

        let session = try JSONDecoder().decode(Session.self, from: data)

        return session.token
    }

    static func me(on baseURL: URL, with token: String) async throws -> User {
        let url = baseURL.appending(path: "users/me")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        try check(data: data, response: response)

        let user = try JSONDecoder().decode(User.self, from: data)
        return user
    }

    static func logout(on baseURL: URL, with token: String) async throws {
        let url = baseURL.appending(path: "users/logout")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        try check(data: data, response: response)

        let session = try JSONDecoder().decode(Session.self, from: data)

        print(session.token)
    }
}
