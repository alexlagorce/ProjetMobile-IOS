import SwiftUI

struct MyFestivalsView: View {
    @ObservedObject var volunteerViewModel = VolunteerViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @State private var selectedFestival: Festival? // Pour stocker le festival sélectionné
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Mes festivals")
                    .padding(.top, 10)
                    .font(.title)
                    .padding(.bottom, 10)
                    .bold()
                    .padding(.top, 10)
                    .foregroundColor(.gray)
                List(volunteerViewModel.volunteers.map { $0.festival }) { festival in
                    FestivalRowView(festival: festival)
                        .onTapGesture {
                            selectedFestival = festival // Sélectionner le festival lorsqu'il est tapé
                        }
                }
            }
            .sheet(item: $selectedFestival) { festival in
                FestivalDetailsView(festival: festival)
            }
            .onAppear {
                // Récupérer l'utilisateur actuel
                userViewModel.fetchCurrentUser()
            }
            .onReceive(userViewModel.$user) { user in
                if let currentUser = user {
                    volunteerViewModel.fetchUserFestivals(for: currentUser.id)
                }
            }
        }
    }
}
