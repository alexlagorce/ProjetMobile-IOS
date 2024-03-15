import SwiftUI

import Foundation

class FestivalViewModel: ObservableObject {
    @Published var festivals: [Festival] = []
    
    func fetchFestivals() {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/festivals") else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full) // Utilise une DateFormatter personnalisée
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let fetchedFestivals = try decoder.decode([Festival].self, from: data)
                
                DispatchQueue.main.async {
                    self.festivals = fetchedFestivals
                }
            } catch {
                print("Error decoding festivals: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON data: \(jsonString)")
                }
            }
        }.resume()
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
