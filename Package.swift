// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BluetoothMessengerIOS",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "BluetoothMessengerIOS",
            targets: ["BluetoothMessengerIOS"])
    ],
    targets: [
        .target(
            name: "BluetoothMessengerIOS",
            path: ".",
            sources: [
                "BluetoothMessengerIOSApp.swift",
                "ContentView.swift",
                "Models/Message.swift",
                "Models/ChatMessage.swift",
                "ViewModels/MessengerViewModel.swift",
                "Views/SettingsView.swift",
                "Services/MultipeerService.swift"
            ]
        )
    ]
)
