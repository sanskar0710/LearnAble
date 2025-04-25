import SwiftUI
import AVFoundation

@main
struct LearnAbleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ConvertView()
                .tabItem {
                    Label("Convert", systemImage: "character.cursor.ibeam")
                }
            
            GamesView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accessibilityLabel("LearnAble Main Navigation")
    }
}

struct HomeView: View {
    // Speech synthesizer for text-to-speech functionality
    private let speechSynthesizer = AVSpeechSynthesizer()
    @State private var welcomeText = "Welcome to LearnAble"
    @State private var isListening = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // App logo and welcome section
                    VStack(alignment: .center, spacing: 15) {
                        Image(systemName: "hand.raised.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                            .accessibilityLabel("LearnAble Logo")
                        
                        Text(welcomeText)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .accessibilityAddTraits(.isHeader)
                        
                        Text("Your companion for accessibility learning")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    
                    // Quick actions section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Quick Actions")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .accessibilityAddTraits(.isHeader)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                QuickActionButton(icon: "text.bubble", title: "Text to Speech", color: .blue) {
                                    speak(text: "Welcome to LearnAble")
                                }
                                
                                QuickActionButton(icon: "mic.fill", title: "Listen", color: .green) {
                                    toggleListening()
                                }
                                
                                QuickActionButton(icon: "doc.text", title: "Learn Braille", color: .orange) {
                                    // Add action for Learning Braille
                                }
                                
                                QuickActionButton(icon: "book.fill", title: "Tutorials", color: .purple) {
                                    // Add action for Tutorials
                                }
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Recent activities section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Activities")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .accessibilityAddTraits(.isHeader)
                        
                        ForEach(1...3, id: \.self) { index in
                            ActivityCard(
                                title: "Activity \(index)",
                                description: "You completed a learning session on \(Date().addingTimeInterval(-Double(index) * 86400).formatted(date: .abbreviated, time: .omitted))",
                                icon: ["doc.text.fill", "book.fill", "character.book.closed.fill"][index - 1]
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Voice assistant button
                    Button {
                        toggleListening()
                    } label: {
                        HStack {
                            Image(systemName: isListening ? "waveform" : "mic.fill")
                                .font(.title2)
                            Text(isListening ? "Listening..." : "Voice Assistant")
                                .fontWeight(.medium)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isListening ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                        .foregroundColor(isListening ? .red : .blue)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .accessibilityLabel(isListening ? "Stop voice assistant" : "Start voice assistant")
                    .accessibilityHint("Double tap to \(isListening ? "stop" : "start") voice recognition")
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("LearnAble")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Function to handle text-to-speech
    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        speechSynthesizer.speak(utterance)
    }
    
    // Function to toggle speech recognition
    private func toggleListening() {
        isListening.toggle()
        // Here you would implement SpeechRecognizer functionality
        if isListening {
            // Start listening
        } else {
            // Stop listening
        }
    }
}

// Helper view for Quick Action buttons
struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.1))
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(width: 100)
        }
        .accessibilityLabel(title)
        .accessibilityHint("Double tap to activate \(title)")
    }
}

// Helper view for Activity Cards
struct ActivityCard: View {
    let title: String
    let description: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 45, height: 45)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(description)")
        .accessibilityHint("Double tap to view details")
    }
}

// Placeholder views for other tabs
struct ConvertView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button("Text to Braille") {
                    // Action
                }
                .buttonStyle(.borderedProminent)
                
                Button("Braille to Text") {
                    // Action
                }
                .buttonStyle(.borderedProminent)
                
                Button("Upload File") {
                    // Action
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Convert")
        }
    }
}

struct GamesView: View {
    var body: some View {
        NavigationStack {
            Text("Games coming soon...")
                .navigationTitle("Games")
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Settings options will appear here")
            }
            .navigationTitle("Settings")
        }
    }
}

// Preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
