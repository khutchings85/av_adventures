//
//  ContentView.swift
//  My Adventures
//
//  Created by Kyle Hutchings on 6/14/24.
//

import MapKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var entries: [JournalEntry]

    init() {
        addEntries()
    }

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.0728544, longitude: -77.0430197),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var body: some View {
        VStack {
            Map(position: $position) {
                ForEach(entries, id: \.id) { entry in
                    Marker(entry.title, coordinate: entry.getMapCoordinate())
                }
            }.mapStyle(.hybrid(elevation: .realistic))
            
            HStack(spacing: 50) {
                ForEach(entries, id: \.id) { entry in
                    Button(entry.title) {
                        position = MapCameraPosition.region(
                            MKCoordinateRegion(
                                center: entry.getMapCoordinate(),
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                            )
                        )
                    }
                }
            }
        }
    }
    
    func addEntries() {
        let entry1 = JournalEntry(latitude: 35.0728544, longitude: -77.0430197, altitude: 19.0, date: Date.now, title: "KEWN", body: "Home airport.")
        let entry2 = JournalEntry(latitude: 35.5824394, longitude: -79.1013378, altitude: 10.0, date: Date.now, title: "KTTA", body: "Raleigh exec, executive flight training.")
        let entry3 = JournalEntry(latitude: 35.3801550, longitude: -78.7322367, altitude: 35.0, date: Date.now, title: "KHRJ", body: "Harnett County.")

        modelContext.insert(entry1)
        modelContext.insert(entry2)
        modelContext.insert(entry3)
    
        // Get all entries
        for entry in entries {
            print(entry.title)
        }
    }
    
    func deleteEntries(_ indexSet: IndexSet) {
        for index in indexSet {
            let entry = entries[index]
            modelContext.delete(entry)
        }
    }
}

#Preview {
    ContentView()
}
