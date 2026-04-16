import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: MessengerViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingClearAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Подключение") {
                    HStack {
                        Text("Статус")
                        Spacer()
                        Text(viewModel.isConnected ? "Подключено" : "Отключено")
                            .foregroundColor(viewModel.isConnected ? .green : .secondary)
                    }
                    
                    Toggle("Автоматическое переподключение", isOn: $viewModel.autoReconnect)
                    
                    Toggle("Фоновый режим", isOn: $viewModel.backgroundMode)
                }
                
                Section("Устройства поблизости") {
                    if viewModel.nearbyPeers.isEmpty {
                        Text("Устройства не найдены")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(viewModel.nearbyPeers, id: \.self) { peer in
                            HStack {
                                Image(systemName: "iphone")
                                Text(peer)
                                Spacer()
                                if viewModel.connectedPeers.contains(peer) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                }
                
                Section("Уведомления") {
                    Toggle("Звук при получении", isOn: $viewModel.soundEnabled)
                    Toggle("Вибрация", isOn: $viewModel.vibrationEnabled)
                }
                
                Section("История") {
                    HStack {
                        Text("Всего сообщений")
                        Spacer()
                        Text("\(viewModel.messages.count)")
                            .foregroundColor(.secondary)
                    }
                    
                    Button(role: .destructive) {
                        showingClearAlert = true
                    } label: {
                        Text("Очистить историю")
                    }
                }
                
                Section("О приложении") {
                    HStack {
                        Text("Версия")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("iOS")
                        Spacer()
                        Text("18.0+")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
            .alert("Очистить историю?", isPresented: $showingClearAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Очистить", role: .destructive) {
                    viewModel.clearHistory()
                }
            } message: {
                Text("Все сообщения будут удалены безвозвратно")
            }
        }
    }
}
