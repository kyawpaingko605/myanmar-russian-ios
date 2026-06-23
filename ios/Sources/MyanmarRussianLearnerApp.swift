import SwiftUI

@main
struct MyanmarRussianLearnerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AppState())
        }
    }
}

class AppState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var apiKey: String = ""
    @Published var isLoggedIn: Bool = false
    
    init() {
        // Load API key from UserDefaults if available
        if let saved = UserDefaults.standard.string(forKey: "apiKey") {
            self.apiKey = saved
            self.isLoggedIn = true
        }
    }
    
    func saveApiKey(_ key: String) {
        self.apiKey = key
        UserDefaults.standard.set(key, forKey: "apiKey")
        self.isLoggedIn = true
    }
}
