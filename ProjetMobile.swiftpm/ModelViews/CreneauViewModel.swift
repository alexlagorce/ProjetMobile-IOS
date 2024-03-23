import SwiftUI
import Combine

class CreneauViewModel: ObservableObject {
    @Published var creneaux: [Creneau]?
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchCreneaux(for festivalId: Int) {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/festivals/\(festivalId)/creneaux") else {
            print("Invalid URL")
            return
        }
        
        print("Fetching creneaux for festival ID:", festivalId) // Message de débogage
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full) // Utilise une DateFormatter personnalisée
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Creneau].self, decoder: decoder)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] creneaux in
                print("Received creneaux:", creneaux) // Ajouter un print pour vérifier les créneaux reçus
                self?.creneaux = creneaux
            })
            .store(in: &cancellables)
    }
    
    func updateCreneauEspaceCapacity(idCreneauEspace: Int, newCapacity: Int, idCreneau: Int, idEspace: Int, capacityEspaceAnimationJeux: Int, espace: Espace) {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/creneauEspaces/\(idCreneauEspace)") else {
            print("Invalid URL")
            return
        }
        
        print("Updating creneauEspace capacity for ID:", idCreneauEspace) // Message de débogage
        
        // Création de la structure de données pour la mise à jour
        let updatedCreneauEspace = CreneauEspace(idCreneauEspace: idCreneauEspace, idCreneau: idCreneau, idEspace: idEspace, currentCapacity: newCapacity, capacityEspaceAnimationJeux: capacityEspaceAnimationJeux, espace: espace)
        
        // Configuration de la requête HTTP
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Encodage des données à envoyer
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            request.httpBody = try encoder.encode(updatedCreneauEspace)
        } catch {
            print("Error encoding data:", error)
            return
        }
        
        // Envoi de la requête HTTP
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Gestion des erreurs et de la réponse...
        }.resume()
    }
}
