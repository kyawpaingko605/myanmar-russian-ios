import SwiftUI
import AVFoundation

struct ProTutorView: View {
    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @State private var isLoading = false
    @State private var langMode: LangMode = .myanmar
    @State private var tutorMode: TutorMode = .conversation
    @State private var backendURL = "http://localhost:3000"
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("🎓 Pro Tutor")
                            .font(.system(size: 24, weight: .bold))
                        Spacer()
                        Button(action: { showSettings = true }) {
                            Image(systemName: "gear")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // Mode Toggles
                    HStack(spacing: 8) {
                        ForEach(LangMode.allCases, id: \.self) { mode in
                            Button(action: { langMode = mode }) {
                                Text(mode.label)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(langMode == mode ? .white : .primary)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(langMode == mode ? Color.blue : Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    // Tutor Mode Scroll
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(TutorMode.allCases, id: \.self) { mode in
                                Button(action: { tutorMode = mode }) {
                                    Text(mode.label)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(tutorMode == mode ? .white : .primary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical: 6)
                                        .background(tutorMode == mode ? Color(red: 0.2, green: 0.6, blue: 0.9) : Color(.systemGray6))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .padding(16)
                .background(Color(.systemGray6))
                
                // Messages
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        if messages.isEmpty {
                            VStack(spacing: 16) {
                                Text("🎓")
                                    .font(.system(size: 48))
                                Text("Pro AI Tutor")
                                    .font(.system(size: 18, weight: .bold))
                                Text("မြန်မာ သို့မဟုတ် ရုရှားဘာသာဖြင့် မေးမြန်းပါ")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(32)
                        } else {
                            ForEach(messages) { msg in
                                ChatBubble(message: msg, onPlayAudio: { playAudio(msg) })
                            }
                        }
                    }
                    .padding(16)
                }
                
                // Input Area
                HStack(spacing: 12) {
                    TextField(
                        langMode == .myanmar ? "မြန်မာဘာသာဖြင့် ရေးပါ..." : "Напишите по-русски...",
                        text: $inputText
                    )
                    .textFieldStyle(.roundedBorder)
                    .disabled(isLoading)
                    
                    Button(action: sendMessage) {
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 24))
                        }
                    }
                    .foregroundColor(.blue)
                    .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty || isLoading)
                }
                .padding(16)
                .background(Color(.systemGray6))
            }
            
            if showSettings {
                SettingsOverlay(isShowing: $showSettings, backendURL: $backendURL)
            }
        }
    }
    
    func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty else { return }
        
        // Add user message
        messages.append(ChatMessage(role: .user, text: text))
        inputText = ""
        isLoading = true
        
        // Call backend API
        Task {
            do {
                let response = try await callTutorAPI(
                    message: text,
                    mode: tutorMode,
                    langMode: langMode
                )
                
                messages.append(ChatMessage(role: .assistant, text: response))
                
                // Auto-play response
                playAudio(ChatMessage(role: .assistant, text: response))
            } catch {
                messages.append(ChatMessage(role: .assistant, text: "❌ Error: \(error.localizedDescription)"))
            }
            
            isLoading = false
        }
    }
    
    func callTutorAPI(message: String, mode: TutorMode, langMode: LangMode) async throws -> String {
        let url = URL(string: "\(backendURL)/api/tutor")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = [
            "message": message,
            "mode": mode.rawValue,
            "langMode": langMode.rawValue,
            "history": messages.map { ["role": $0.role.rawValue, "text": $0.text] }
        ] as [String: Any]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "API Error", code: -1)
        }
        
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let responseText = json?["response"] as? String else {
            throw NSError(domain: "Parse Error", code: -1)
        }
        
        return responseText
    }
    
    func playAudio(_ message: ChatMessage) {
        let text = message.role == .assistant ? message.text : message.text
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: langMode == .myanmar ? "my-MM" : "ru-RU")
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: MessageRole
    let text: String
    
    enum MessageRole: String {
        case user
        case assistant
    }
}

enum LangMode: String, CaseIterable {
    case myanmar
    case russian
    
    var label: String {
        self == .myanmar ? "မြန်မာ" : "ရုရှား"
    }
}

enum TutorMode: String, CaseIterable {
    case conversation
    case pronunciation
    case grammar
    case vocabulary
    
    var label: String {
        switch self {
        case .conversation: return "စကားပြော"
        case .pronunciation: return "အသံထွက်"
        case .grammar: return "သုံးစွဲမှု"
        case .vocabulary: return "စကားလုံး"
        }
    }
}

struct ChatBubble: View {
    let message: ChatMessage
    let onPlayAudio: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if message.role == .assistant {
                Text("🎓")
                    .font(.system(size: 20))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(message.text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(message.role == .user ? .white : .primary)
                    .padding(12)
                    .background(message.role == .user ? Color.blue : Color(.systemGray6))
                    .cornerRadius(12)
                
                if message.role == .assistant {
                    Button(action: onPlayAudio) {
                        HStack(spacing: 4) {
                            Image(systemName: "speaker.wave.2.fill")
                            Text("ကြားကြည့်")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.blue)
                    }
                }
            }
            
            if message.role == .user {
                Spacer()
            }
        }
    }
}

struct SettingsOverlay: View {
    @Binding var isShowing: Bool
    @Binding var backendURL: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { isShowing = false }
            
            VStack(spacing: 16) {
                Text("Settings")
                    .font(.system(size: 18, weight: .bold))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Backend URL")
                        .font(.system(size: 14, weight: .semibold))
                    TextField("http://localhost:3000", text: $backendURL)
                        .textFieldStyle(.roundedBorder)
                }
                
                Button(action: { isShowing = false }) {
                    Text("Done")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding(20)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .padding(20)
        }
    }
}

#Preview {
    ProTutorView()
}
