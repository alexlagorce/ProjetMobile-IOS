import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel = FestivalViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var registrationViewModel = RegistrationViewModel()

    @State private var selectedFestival: Festival? // Pour stocker le festival sélectionné

    var body: some View {
        NavigationView {
            VStack{
                Text("Liste des festivals")
                    .padding(.top, 10)
                    .font(.title)
                    .padding(.bottom, 10)
                    .bold()
                    .padding(.top, 10)
                    .foregroundColor(.gray)
                List(viewModel.festivals) { festival in
                    FestivalRowView(festival: festival)
                        .onTapGesture {
                            selectedFestival = festival // Sélectionner le festival lorsqu'il est tapé
                        }
                }
                
            }
        }
        .sheet(item: $selectedFestival) { festival in
            RegistrationFestivalView(festival: festival, registrationViewModel: registrationViewModel)
        }
        .onAppear {
            viewModel.fetchFestivals()
        }
    }
}
