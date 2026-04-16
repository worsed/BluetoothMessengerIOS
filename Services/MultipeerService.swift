import Foundation
import MultipeerConnectivity

class MultipeerService: NSObject, ObservableObject {
    private let serviceType = "bt-messenger"
    private var peerID: MCPeerID
    private var session: MCSession
    private var advertiser: MCNearbyServiceAdvertiser
    private var browser: MCNearbyServiceBrowser
    
    @Published var connectedPeers: [String] = []
    @Published var nearbyPeers: [String] = []
    @Published var isConnected = false
    
    var onMessageReceived: ((String, String) -> Void)?
    var onStatusChanged: ((String) -> Void)?
    
    override init() {
        // Используем имя устройства
        let deviceName = UIDevice.current.name
        peerID = MCPeerID(displayName: deviceName)
        
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        
        session.delegate = self
        advertiser.delegate = self
        browser.delegate = self
        
        startServices()
    }
    
    func startServices() {
        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
        onStatusChanged?("Поиск устройств...")
    }
    
    func stopServices() {
        advertiser.stopAdvertisingPeer()
        browser.stopBrowsingForPeers()
        session.disconnect()
        onStatusChanged?("Отключено")
    }
    
    func sendMessage(_ text: String) {
        guard !session.connectedPeers.isEmpty else {
            onStatusChanged?("Нет подключенных устройств")
            return
        }
        
        let message = MessageData(text: text, senderName: peerID.displayName)
        
        do {
            let data = try JSONEncoder().encode(message)
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            onStatusChanged?("Ошибка отправки: \(error.localizedDescription)")
        }
    }
    
    private func updateConnectionStatus() {
        DispatchQueue.main.async {
            self.connectedPeers = self.session.connectedPeers.map { $0.displayName }
            self.isConnected = !self.session.connectedPeers.isEmpty
            
            if self.isConnected {
                self.onStatusChanged?("Подключено к \(self.connectedPeers.count) устройствам")
            } else {
                self.onStatusChanged?("Ожидание подключения...")
            }
        }
    }
}

// MARK: - MCSessionDelegate
extension MultipeerService: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        updateConnectionStatus()
        
        switch state {
        case .connected:
            print("Подключено к: \(peerID.displayName)")
        case .connecting:
            print("Подключение к: \(peerID.displayName)")
        case .notConnected:
            print("Отключено от: \(peerID.displayName)")
        @unknown default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let message = try JSONDecoder().decode(MessageData.self, from: data)
            DispatchQueue.main.async {
                self.onMessageReceived?(message.text, message.senderName)
            }
        } catch {
            print("Ошибка декодирования сообщения: \(error)")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Не используется
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Не используется
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Не используется
    }
}

// MARK: - MCNearbyServiceAdvertiserDelegate
extension MultipeerService: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // Автоматически принимаем приглашения
        invitationHandler(true, session)
    }
}

// MARK: - MCNearbyServiceBrowserDelegate
extension MultipeerService: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        DispatchQueue.main.async {
            if !self.nearbyPeers.contains(peerID.displayName) {
                self.nearbyPeers.append(peerID.displayName)
            }
        }
        
        // Автоматически приглашаем найденные устройства
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 30)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        DispatchQueue.main.async {
            self.nearbyPeers.removeAll { $0 == peerID.displayName }
        }
    }
}

// MARK: - MessageData
struct MessageData: Codable {
    let text: String
    let senderName: String
}
