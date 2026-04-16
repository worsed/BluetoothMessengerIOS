import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MessengerViewModel()
    @State private var messageText = ""
    @State private var showingSettings = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Статус подключения
                HStack {
                    Circle()
                        .fill(viewModel.isConnected ? Color.green : Color.gray)
                        .frame(width: 10, height: 10)
                    
                    Text(viewModel.statusText)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("\(viewModel.connectedPeers.count) устройств")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                
                // Список сообщений
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.messages.count) { _, _ in
                        if let lastMessage = viewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Поле ввода
                HStack(spacing: 12) {
                    TextField("Сообщение...", text: $messageText)
                        .textFieldStyle(.roundedBorder)
                        .submitLabel(.send)
                        .onSubmit {
                            sendMessage()
                        }
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(messageText.isEmpty ? .gray : .blue)
                    }
                    .disabled(messageText.isEmpty || !viewModel.isConnected)
                }
                .padding()
                .background(Color(.systemBackground))
            }
            .navigationTitle("Bluetooth Messenger")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(viewModel: viewModel)
            }
        }
    }
    
    private func sendMessage() {
        guard !messageText.isEmpty else { return }
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isOutgoing {
                Spacer()
            }
            
            VStack(alignment: message.isOutgoing ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding(12)
                    .background(message.isOutgoing ? Color.blue : Color(.systemGray5))
                    .foregroundColor(message.isOutgoing ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            if !message.isOutgoing {
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
