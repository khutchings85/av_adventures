//
//  JournalTests.swift
//  My AdventuresTests
//
//  Created by Kyle Hutchings on 7/2/24.
//
import XCTest

final class JournalTests: XCTestCase {
    let journal = Journal()

    override func setUpWithError() throws {
        // Clear the journal for each test
        let entries = journal.getEntries()
        for entry in entries {
            journal.removeEntry(entry: entry)
        }
    }

    func testAddEntry() throws {
        let newEntry = JournalEntry(latitude: 34.052235, longitude: -118.243683, altitude: 89.0, date: Date.now, title: "Trip to LA", body: "Visited the Hollywood sign.")
        journal.addEntry(entry: newEntry)

        let entries = journal.getEntries()
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(newEntry, entries[0])
    }
    
    func testRemoveEntry() throws {
        let entry1 = JournalEntry(latitude: 34.052235, longitude: -118.243683, altitude: 89.0, date: Date.now, title: "Trip to LA", body: "Visited the Hollywood sign.")
        let entry2 = JournalEntry(latitude: 40.712776, longitude: -74.005974, altitude: 10.0, date: Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!, title: "Trip to NY", body: "Saw the Statue of Liberty.")
        journal.addEntry(entry: entry1)
        journal.addEntry(entry: entry2)
        journal.removeEntry(entry: entry1)
        
        let entries = journal.getEntries()
        XCTAssertEqual(entries.count, 1)
        XCTAssertTrue(entries.contains(entry2))
    }
    
    func testGetEntries() throws {
        let entry1 = JournalEntry(latitude: 34.052235, longitude: -118.243683, altitude: 89.0, date: Date.now, title: "Trip to LA", body: "Visited the Hollywood sign.")
        let entry2 = JournalEntry(latitude: 40.712776, longitude: -74.005974, altitude: 10.0, date: Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!, title: "Trip to NY", body: "Saw the Statue of Liberty.")
        let entry3 = JournalEntry(latitude: 48.856613, longitude: 2.352222, altitude: 35.0, date: Calendar.current.date(byAdding: .hour, value: 2, to: Date.now)!, title: "Trip to Paris", body: "Visited the Eiffel Tower.")
        journal.addEntry(entry: entry1)
        journal.addEntry(entry: entry2)
        journal.addEntry(entry: entry3)

        let entries = journal.getEntries()
        XCTAssertEqual(entries.count, 3)
        XCTAssertTrue(entries.contains(entry1))
        XCTAssertTrue(entries.contains(entry2))
        XCTAssertTrue(entries.contains(entry3))
    }

    func testRemoveEntryFailure() {
        let entry1 = JournalEntry(latitude: 34.052235, longitude: -118.243683, altitude: 89.0, date: Date.now, title: "Trip to LA", body: "Visited the Hollywood sign.")
        let entry2 = JournalEntry(latitude: 40.712776, longitude: -74.005974, altitude: 10.0, date: Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!, title: "Trip to NY", body: "Saw the Statue of Liberty.")
        journal.addEntry(entry: entry1)
        journal.removeEntry(entry: entry2)

        let entries = journal.getEntries()
        XCTAssertEqual(entries.count, 1)
        XCTAssertTrue(entries.contains(entry1))
    }
}

final class JournalEntryTests: XCTestCase {

    func testJournalEntryProps() {
        let latitude = 34.052235
        let longitude = -118.243683
        let altitude = 89.0
        let date = Date.now
        let title = "Trip to LA"
        let body = "Visited the Hollywood sign."

        let entry = JournalEntry(latitude: latitude, longitude: longitude, altitude: altitude, date: date, title: title, body: body)
        
        XCTAssertEqual(entry.latitude, latitude)
        XCTAssertEqual(entry.longitude, longitude)
        XCTAssertEqual(entry.altitude, altitude)
        XCTAssertEqual(entry.date, date)
        XCTAssertEqual(entry.title, title)
        XCTAssertEqual(entry.body, body)
    }

    func testJournalEntryEquatable() {
        let entry1 = JournalEntry(latitude: 34.052235, longitude: -118.243683, altitude: 89.0, date: Date.now, title: "Trip to LA", body: "Visited the Hollywood sign.")
        let entry2 = entry1
    
        // checks that entries are equal when date is the same
        XCTAssertEqual(entry1, entry2)
    }
    
    func testJournalEntryNotEquatable() {
        let latitude = 34.052235
        let longitude = -118.243683
        let altitude = 89.0
        let date1 = Date.now
        let date2 = Calendar.current.date(byAdding: .hour, value: 1, to: date1)!
        let title = "Trip to LA"
        let body = "Visited the Hollywood sign."

        let entry1 = JournalEntry(latitude: latitude, longitude: longitude, altitude: altitude, date: date1, title: title, body: body)
        let entry2 = JournalEntry(latitude: latitude, longitude: longitude, altitude: altitude, date: date2, title: title, body: body)
        
        XCTAssertNotEqual(entry1, entry2)
    }
}

final class StringExtensionsTests: XCTestCase {

    func testUppercaseFirst() {
        let input = "antoine"
        let expectedOutput = "Antoine"
        XCTAssertEqual(input.uppercasedFirst(), expectedOutput, "The String is not correctly capitalized.")
    }
}

final class Base64DataToHexTests: XCTestCase {
    
    func testEmptyData() {
        let data = Data(base64Encoded: "")!
        XCTAssertEqual(data.hexEncodedString(), "")
    }
    
    func testSimpleStringData() {
        let data = Data(base64Encoded: "SGVsbG8gV29ybGQh")! // "Hello World!" in base64
        let expectedHexString = "48656c6c6f20576f726c6421"
        XCTAssertEqual(data.hexEncodedString(), expectedHexString)
    }
    
    func testNonAlphanumericCharacters() {
        let data = Data(base64Encoded: "Q29kZSAhQCQjJCVeJiooKQ==")! // "Code !@#$%^&*()" in Base64
        let expectedHexString = "436f6465202140242324255e262a2829"
        XCTAssertEqual(data.hexEncodedString(), expectedHexString)
    }
    
    func testNumericString() {
        let data = Data(base64Encoded: "MTIzNDU2Nzg5MA==")! // "1234567890" in Base64
        let expectedHexString = "31323334353637383930"
        XCTAssertEqual(data.hexEncodedString(), expectedHexString)
    }
    
    func testPaddingCharacters() {
        let data = Data(base64Encoded: "U29mdHdhcmUgRW5naW5lZXJpbmc=")! // "Software Engineering" in Base64 with padding
        let expectedHexString = "536f66747761726520456e67696e656572696e67"
        XCTAssertEqual(data.hexEncodedString(), expectedHexString)
    }
}
