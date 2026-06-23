import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            TabView(selection: $appState.selectedTab) {
                // Home Tab
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(0)
                
                // Flashcards Tab
                FlashcardsView()
                    .tabItem {
                        Label("Flashcards", systemImage: "rectangle.stack.fill")
                    }
                    .tag(1)
                
                // Quiz Tab
                QuizView()
                    .tabItem {
                        Label("Quiz", systemImage: "checkmark.circle.fill")
                    }
                    .tag(2)
                
                // Pro Tutor Tab
                ProTutorView()
                    .tabItem {
                        Label("Pro Tutor", systemImage: "book.fill")
                    }
                    .tag(3)
                
                // Progress Tab
                ProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.bar.fill")
                    }
                    .tag(4)
            }
            .accentColor(Color(red: 0.8, green: 0.2, blue: 0.2))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
