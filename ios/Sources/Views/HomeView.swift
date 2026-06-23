import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var streak = 5
    @State private var wordsLearned = 45
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.9, green: 0.3, blue: 0.3),
                        Color(red: 0.95, green: 0.5, blue: 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("မြန်မာ-Русский")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Language Learner")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            // Stats Cards
                            HStack(spacing: 12) {
                                StatCard(emoji: "🔥", value: "\(streak)", label: "ဆက်တိုက်ရက်")
                                StatCard(emoji: "📚", value: "\(wordsLearned)", label: "သင်ယူပြီး")
                                StatCard(emoji: "⭐", value: "85%", label: "အောင်မြင်မှု")
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                            
                            // Feature Cards
                            VStack(spacing: 12) {
                                FeatureCard(
                                    emoji: "🃏",
                                    title: "Flashcards",
                                    subtitle: "စကားလုံးများ သင်ယူခြင်း",
                                    color: Color(red: 0.8, green: 0.2, blue: 0.2)
                                )
                                
                                FeatureCard(
                                    emoji: "🧠",
                                    title: "Quiz",
                                    subtitle: "ပညာရေးတွေ စမ်းသပ်ခြင်း",
                                    color: Color(red: 0.6, green: 0.2, blue: 0.8)
                                )
                                
                                FeatureCard(
                                    emoji: "🎓",
                                    title: "Pro Tutor",
                                    subtitle: "AI နဲ့ စကားပြောခြင်း",
                                    color: Color(red: 0.2, green: 0.6, blue: 0.9)
                                )
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                        }
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(24, corners: [.topLeft, .topRight])
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct StatCard: View {
    let emoji: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(emoji)
                .font(.system(size: 24))
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct FeatureCard: View {
    let emoji: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(emoji)
                .font(.system(size: 32))
        }
        .padding(16)
        .background(color.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}

// Custom corner radius modifier
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    HomeView()
        .environmentObject(AppState())
}
