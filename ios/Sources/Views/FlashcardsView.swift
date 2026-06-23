import SwiftUI
import AVFoundation

struct FlashcardsView: View {
    @State private var cards = [
        Card(id: 1, myanmar: "မင်္ဂလာပါ", russian: "Привет", pronunciation: "Privet", category: "Greetings"),
        Card(id: 2, myanmar: "ကောင်းပါတယ်", russian: "Спасибо", pronunciation: "Spasibo", category: "Greetings"),
        Card(id: 3, myanmar: "ကျေးဇူးတင်ပါတယ်", russian: "Пожалуйста", pronunciation: "Pozhaluysta", category: "Greetings"),
        Card(id: 4, myanmar: "တစ်", russian: "Один", pronunciation: "Odin", category: "Numbers"),
        Card(id: 5, myanmar: "နှစ်", russian: "Два", pronunciation: "Dva", category: "Numbers"),
    ]
    
    @State private var currentIndex = 0
    @State private var isFlipped = false
    @State private var rotation = 0.0
    
    var currentCard: Card {
        cards[currentIndex]
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("🃏 Flashcards")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Text("\(currentIndex + 1)/\(cards.count)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                Spacer()
                
                // Flip Card
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.8, green: 0.2, blue: 0.2),
                                        Color(red: 0.95, green: 0.5, blue: 0.2)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        VStack(spacing: 16) {
                            Text(isFlipped ? "ရုရှား" : "မြန်မာ")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.8))
                            
                            Text(isFlipped ? currentCard.russian : currentCard.myanmar)
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            if isFlipped {
                                Text(currentCard.pronunciation)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white.opacity(0.8))
                                
                                Button(action: speakRussian) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "speaker.wave.2.fill")
                                        Text("ကြားကြည့်")
                                    }
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(32)
                    }
                    .frame(height: 320)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            isFlipped.toggle()
                            rotation += 180
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Navigation Buttons
                HStack(spacing: 16) {
                    Button(action: previousCard) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.2))
                    }
                    .disabled(currentIndex == 0)
                    .opacity(currentIndex == 0 ? 0.3 : 1)
                    
                    Spacer()
                    
                    Button(action: nextCard) {
                        Image(systemName: "chevron.right.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(Color(red: 0.8, green: 0.2, blue: 0.2))
                    }
                    .disabled(currentIndex == cards.count - 1)
                    .opacity(currentIndex == cards.count - 1 ? 0.3 : 1)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
    }
    
    func nextCard() {
        if currentIndex < cards.count - 1 {
            isFlipped = false
            currentIndex += 1
        }
    }
    
    func previousCard() {
        if currentIndex > 0 {
            isFlipped = false
            currentIndex -= 1
        }
    }
    
    func speakRussian() {
        let utterance = AVSpeechUtterance(string: currentCard.russian)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct Card: Identifiable {
    let id: Int
    let myanmar: String
    let russian: String
    let pronunciation: String
    let category: String
}

#Preview {
    FlashcardsView()
}
