import SwiftUI

struct ProgressView: View {
    @State private var streak = 5
    @State private var learnedWords = 45
    @State private var totalWords = 100
    @State private var avgScore = 85
    
    var progressPercentage: Double {
        Double(learnedWords) / Double(totalWords)
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("📊 Progress")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color(red: 0.1, green: 0.7, blue: 0.5))
                .foregroundColor(.white)
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Stats Row
                        HStack(spacing: 12) {
                            StatCard(emoji: "🔥", value: "\(streak)", label: "ဆက်တိုက်ရက်")
                            StatCard(emoji: "📚", value: "\(learnedWords)", label: "သင်ယူပြီး")
                            StatCard(emoji: "🎯", value: "\(avgScore)%", label: "Quiz ပျမ်းမျှ")
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        
                        // Overall Progress
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("စုစုပေါင်း တိုးတက်မှု")
                                    .font(.system(size: 14, weight: .semibold))
                                Spacer()
                                Text("\(Int(progressPercentage * 100))%")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(red: 0.1, green: 0.7, blue: 0.5))
                            }
                            
                            ProgressView(value: progressPercentage)
                                .tint(Color(red: 0.1, green: 0.7, blue: 0.5))
                            
                            Text("\(learnedWords) / \(totalWords) စကားလုံး")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        .padding(16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Category Progress
                        VStack(alignment: .leading, spacing: 12) {
                            Text("အမျိုးအစားအလိုက်")
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.horizontal, 20)
                            
                            ForEach(categories, id: \.id) { category in
                                CategoryProgressRow(category: category)
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
        }
    }
    
    var categories: [Category] {
        [
            Category(id: 1, emoji: "👋", name: "Greetings", learned: 8, total: 10, color: Color(red: 0.8, green: 0.2, blue: 0.2)),
            Category(id: 2, emoji: "🔢", name: "Numbers", learned: 10, total: 10, color: Color(red: 0.2, green: 0.6, blue: 0.9)),
            Category(id: 3, emoji: "🍽️", name: "Food", learned: 6, total: 12, color: Color(red: 0.1, green: 0.7, blue: 0.5)),
            Category(id: 4, emoji: "🏠", name: "Places", learned: 5, total: 8, color: Color(red: 0.9, green: 0.6, blue: 0.1)),
        ]
    }
}

struct CategoryProgressRow: View {
    let category: Category
    
    var percentage: Double {
        Double(category.learned) / Double(category.total)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(category.emoji)
                    .font(.system(size: 18))
                
                Text(category.name)
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
                
                Text("\(category.learned)/\(category.total)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            ProgressView(value: percentage)
                .tint(category.color)
        }
        .padding(.horizontal, 20)
    }
}

struct Category: Identifiable {
    let id: Int
    let emoji: String
    let name: String
    let learned: Int
    let total: Int
    let color: Color
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

#Preview {
    ProgressView()
}
