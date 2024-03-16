import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    func fetchCurrentUser() {
        guard let token = UserDefaults.standard.string(forKey: "userToken"),
              let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/users/current") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.user = decodedResponse
                }
            } catch let error {
                print("Error decoding user: \(error)")
            }
        }.resume()
    }
    
    func updateUser(_ user: User) {
        var token: String?
        var userId: String?
        
        token = UserDefaults.standard.string(forKey: "userToken")
        userId = user.id
        
        if let token = token, let userId = userId,
           let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/users/\(userId)") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONEncoder().encode(user)
                
                URLSession.shared.dataTask(with: request) { _, response, error in
                    if let httpResponse = response as? HTTPURLResponse,
                       (200..<300).contains(httpResponse.statusCode) {
                        print("User updated successfully")
                        // Mettez à jour les données de l'utilisateur localement si nécessaire
                    } else {
                        print("Failed to update user. Error: \(String(describing: error))")
                    }
                }.resume()
            } catch {
                print("Failed to encode user data. Error: \(error)")
            }
        } else {
            print("Token or user ID is missing")
        }
    }
}


