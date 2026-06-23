import SwiftUI

struct QuizView: View {
    @State private var questions = [
        QuizQuestion(
            id: 1,
            question: "မြန်မာ 'မင်္ဂလာပါ' ကို ရုရှားလို ဘယ်လိုပြောလဲ?",
            options: ["Привет", "Спасибо", "Пожалуйста", "До свидания"],
            correctAnswer: 0
        ),
        QuizQuestion(
            id: 2,
            question: "'Спасибо' ကို မြန်မာလို ဘယ်လိုပြောလဲ?",
            options: ["ကျေးဇူးတင်ပါတယ်", "မင်္ဂလာပါ", "ကောင်းပါတယ်", "ကျွန်တော်"],
            correctAnswer: 2
        ),
    ]
    
    @State private var currentIndex = 0
    @State private var score = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    
    var currentQuestion: QuizQuestion {
        questions[currentIndex]
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("🧠 Quiz")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                    Text("\(currentIndex + 1)/\(questions.count)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                // Progress Bar
                ProgressView(value: Double(currentIndex) / Double(questions.count))
                    .tint(Color(red: 0.6, green: 0.2, blue: 0.8))
                    .padding(.horizontal, 20)
                
                Spacer()
                
                // Question
                VStack(alignment: .leading, spacing: 16) {
                    Text(currentQuestion.question)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    VStack(spacing: 12) {
                        ForEach(0..<currentQuestion.options.count, id: \.self) { index in
                            OptionButton(
                                text: currentQuestion.options[index],
                                isSelected: selectedAnswer == index,
                                isCorrect: showResult && index == currentQuestion.correctAnswer,
                                isWrong: showResult && selectedAnswer == index && index != currentQuestion.correctAnswer,
                                action: {
                                    if !showResult {
                                        selectedAnswer = index
                                        showResult = true
                                        if index == currentQuestion.correctAnswer {
                                            score += 1
                                        }
                                    }
                                }
                            )
                        }
                    }
                }
                .padding(20)
                .background(Color(.systemGray6))
                .cornerRadius(16)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Next Button
                if showResult {
                    Button(action: nextQuestion) {
                        Text(currentIndex == questions.count - 1 ? "ပြီးစီးပါပြီ" : "နောက်တစ်ခု")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(Color(red: 0.6, green: 0.2, blue: 0.8))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
                
                // Score Display
                if currentIndex == questions.count - 1 && showResult {
                    VStack(spacing: 12) {
                        Text("✨ အောင်မြင်ပါတယ်!")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.8))
                        
                        Text("ရမှတ်: \(score)/\(questions.count)")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .padding(16)
                    .background(Color(red: 0.6, green: 0.2, blue: 0.8).opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                    .frame(height: 20)
            }
        }
    }
    
    func nextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            selectedAnswer = nil
            showResult = false
        }
    }
}

struct QuizQuestion: Identifiable {
    let id: Int
    let question: String
    let options: [String]
    let correctAnswer: Int
}

struct OptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if isCorrect {
            return Color.green.opacity(0.2)
        } else if isWrong {
            return Color.red.opacity(0.2)
        } else if isSelected {
            return Color.blue.opacity(0.1)
        } else {
            return Color(.systemGray6)
        }
    }
    
    var borderColor: Color {
        if isCorrect {
            return Color.green
        } else if isWrong {
            return Color.red
        } else if isSelected {
            return Color.blue
        } else {
            return Color.clear
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                }
                
                Text(text)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(16)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
            .cornerRadius(12)
        }
        .disabled(isCorrect || isWrong)
    }
}

#Preview {
    QuizView()
}
