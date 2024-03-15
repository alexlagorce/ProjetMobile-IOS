import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = FestivalViewModel()
    @State private var selectedFestival: Festival? // Pour stocker le festival sélectionné
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.festivals) { festival in
                    FestivalRowView(festival: festival)
                        .onTapGesture {
                            selectedFestival = festival // Sélectionner le festival lorsqu'il est tapé
                        }
                }
                .navigationTitle("Liste des festivals")
            }
        }
        .sheet(item: $selectedFestival) { festival in
            RegistrationFestivalView(festival: festival)
        }
        .onAppear {
            viewModel.fetchFestivals()
        }
    }
}
