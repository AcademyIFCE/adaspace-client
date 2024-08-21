import Foundation

@main
struct SocialNetworkExecutable {

    static func main() async throws {
        do {

            let baseURL = URL(string: "http://127.0.0.1:8080")!

            // Users

            // Search Users
            let users = try await API.searchUsers(on: baseURL)
            print(users.count, "usuários:", users.map(\.username))

            // Create User
            var token = try await API.createUser(on: baseURL)
            print(token)

            // Login
            // token = try await API.login(on: baseURL)
            // print(token)
            
            // let token = "<seu token mockado aqui>"

            // Profile
            var profile = try await API.me(on: baseURL, with: token)
            print(profile)

            // Logout
            try await API.logout(on: baseURL, with: token)

        } catch APIError.apiError(let code, let body) {
            print("Error code: \(code)")
            if let body, let stringified = String(data: body, encoding: .utf8) {
                print("Error body: \(stringified)")
            }
        } catch {
            print(error)
        }

    }


}
