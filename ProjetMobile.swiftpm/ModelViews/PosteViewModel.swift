import SwiftUI
import Combine

class PosteViewModel: ObservableObject {
    @Published var postes: [Poste]?
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchPostes(for festivalId: Int) {
        guard let url = URL(string: "https://montpellier-game-fest-volunteers-api-vincentdub2.vercel.app/festivals/\(festivalId)/postes") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Poste].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] postes in
                self?.postes = postes
            })
            .store(in: &cancellables)
    }
}
