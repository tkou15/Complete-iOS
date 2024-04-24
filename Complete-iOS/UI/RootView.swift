//
//  ContentView.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/02/28.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(.home)
                        Text("Home")
                    }
                }
            FeatureView()
                .tabItem {
                    VStack {
                        Image(.feature)
                        Text("Feature")
                    }
                }
            ComponentView()
                .tabItem {
                    VStack {
                        Image(.component)
                        Text("Components")
                    }
                }
            SettingView()
                .tabItem {
                    VStack {
                        Image(.seeting)
                        Text("Settings")
                    }
                }
        }
        .accentColor(Color.brand)
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    RootView()
        .modelContainer(for: Item.self, inMemory: true)
}
