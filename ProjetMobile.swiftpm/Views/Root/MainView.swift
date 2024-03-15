import SwiftUI

struct MainView: View {
    @AppStorage("loggedIn") var loggedIn: Bool = false
    
    var body: some View {
        VStack {
            if !loggedIn{
                LoginView()
            } else {
                LoggedInView(isLoggedIn: $loggedIn)
            }
        }
    }
}
