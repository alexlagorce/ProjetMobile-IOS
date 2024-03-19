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
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Creneau].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] creneaux in
                print("Received creneaux:", creneaux) // Ajouter un print pour vérifier les créneaux reçus
                self?.creneaux = creneaux
            })
            .store(in: &cancellables)
        
        print("Fetching creneaux for festival ID:", festivalId) // Ajouter un print pour vérifier l'ID du festival
    }
}
