import Foundation
import MapKit
import SwiftData

@Model
class JournalEntry {
    let latitude: Double
    let longitude: Double
    let altitude: Double
    var title: String
    var date: Date
    var body: String?

    init(latitude: Double, longitude: Double, altitude: Double, date: Date, title: String, body: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.title = title
        self.date = date
        self.body = body
    }

    func getMapCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

class Journal {
    private var entries: [JournalEntry] = []

    func addEntry(entry: JournalEntry) {
        entries.append(entry)
    }

    func removeEntry(entry: JournalEntry) {
        entries.removeAll { $0.id == entry.id }
    }
    
    func getEntries() -> [JournalEntry] {
        return entries;
    }
}

extension String {
    func uppercasedFirst() -> String {
        let firstCharacter = prefix(1).capitalized
        let remainingCharacters = dropFirst().lowercased()
        return firstCharacter + remainingCharacters
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}
