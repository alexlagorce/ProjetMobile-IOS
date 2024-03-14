import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Image("rock-n-solex")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
        }
    }
}
