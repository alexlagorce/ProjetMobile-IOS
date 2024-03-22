import SwiftUI

import Foundation

class VolunteerViewModel: ObservableObject {
    @Published var volunteers: [Volunteer] = []
    
    func fetchUserFestivals(for userID: String) {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/users/\(userID)/festivals") else {
            print("URL is nil")
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error fetching festivals: \(error.localizedDescription)")
                } else {
                    print("Error fetching festivals: unknown error")
                }
                return
            }
            
            do {
                let fetchedVolunteers = try decoder.decode([Volunteer].self, from: data)
                print("fetched volunteers: \(fetchedVolunteers)")
                
                DispatchQueue.main.async {
                    self.volunteers = fetchedVolunteers
                    print("Volunteers fetched successfully")
                }
            } catch {
                print("Error decoding volunteer festivals: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                }
            }
        }.resume()
    }
}
