import Foundation
import SwiftUI
import SwiftData
import UserNotifications

@MainActor
class MessengerViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var statusText = "Инициализация..."
    @Published var isConnected = false
    @Published var connectedPeers: [String] = []
    @Published var nearbyPeers: [String] = []
    
    @Published var autoReconnect = true
    @Published var backgroundMode = true
    @Published var soundEnabled = true
    @Published var vibrationEnabled = true
    
    private let multipeerService: MultipeerService
    private var modelContext: ModelContext?
    
    init() {
        multipeerService = MultipeerService()
        setupCallbacks()
        requestNotificationPermission()
        loadMessages()
    }
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    private func setupCallbacks() {
        multipeerService.onMessageReceived = { [weak self] text, senderName in
            self?.handleReceivedMessage(text: text, senderName: senderName)
        }
        
        multipeerService.onStatusChanged = { [weak self] status in
            self?.statusText = status
        }
        
        // Наблюдаем за изменениями подключения
        multipeerService.$isConnected
            .assign(to: &$isConnected)
        
        multipeerService.$connectedPeers
            .assign(to: &$connectedPeers)
        
        multipeerService.$nearbyPeers
            .assign(to: &$nearbyPeers)
    }
    
    func sendMessage(_ text: String) {
        let message = Message(text: text, isOutgoing: true)
        messages.append(message)
        
        multipeerService.sendMessage(text)
        saveMessage(message)
        
        if soundEnabled {
            playSound()
        }
    }
    
    private func handleReceivedMessage(text: String, senderName: String) {
        let message = Message(text: text, isOutgoing: false, senderName: senderName)
        messages.append(message)
        saveMessage(message)
        
        // Уведомление
        showNotification(title: "Сообщение от \(senderName)", body: text)
        
        if soundEnabled {
            playSound()
        }
        
        if vibrationEnabled {
            vibrate()
        }
    }
    
    func clearHistory() {
        messages.removeAll()
        
        guard let context = modelContext else { return }
        
        do {
            try context.delete(model: ChatMessage.self)
            try context.save()
        } catch {
            print("Ошибка очистки истории: \(error)")
        }
    }
    
    private func saveMessage(_ message: Message) {
        guard let context = modelContext else { return }
        
        let chatMessage = ChatMessage(
            id: message.id,
            text: message.text,
            timestamp: message.timestamp,
            isOutgoing: message.isOutgoing,
            senderName: message.senderName
        )
        
        context.insert(chatMessage)
        
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
    
    private func loadMessages() {
        // Загрузка будет происходить через SwiftData в ContentView
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка запроса разрешений: \(error)")
            }
        }
    }
    
    private func showNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = soundEnabled ? .default : nil
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка уведомления: \(error)")
            }
        }
    }
    
    private func playSound() {
        // Системный звук отправки сообщения
        AudioServicesPlaySystemSound(1001)
    }
    
    private func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

import AudioToolbox
