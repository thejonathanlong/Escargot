//
//  MeasurementTests.swift
//  CooksTests
//
//  Created by Heavenly Flower on 11/14/17.
//  Copyright © 2018 Heavenly Flower. All rights reserved.
//

import XCTest

class MeasurementTests: XCTestCase {
	
}

// MARK: MeasurementAdditionTests
class MeasurementAdditionTests: XCTestCase {
	
	// MARK: - Gallon Addition
	func testGallonPlusGallon() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = GallonMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 2)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testGallonPlusQuart() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = QuartMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 1.25)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testGallonPlusCup() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = CupMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 1.0625)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testGallonPlusOunce() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = OunceMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 1.0078125)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testGallonPlusTablespoon() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = TablespoonMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 1.00390625)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testGallonPlusTeaspoon() {
		let gallon1 = GallonMeasurement(amount: 1)
		let gallon2 = TeaspoonMeasurement(amount: 1)
		let answer = GallonMeasurement(amount: 1.0013020833333333)
		let test = gallon1 + gallon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	// MARK: - Quart Addition
	func testQuartPlusQuart() {
		let quart1 = QuartMeasurement(amount: 1)
		let quart2 = QuartMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 2)
		let test = quart1 + quart2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testQuartPlusGallon() {
		let quart = QuartMeasurement(amount: 1)
		let gallon = GallonMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 5)
		let test = quart + gallon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testQuartPlusCup() {
		let quart = QuartMeasurement(amount: 1)
		let cup = CupMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 1.25)
		let test = quart + cup
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testQuartPlusOunce() {
		let quart = QuartMeasurement(amount: 1)
		let ounce = OunceMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 1.03125)
		let test = quart + ounce
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testQuartPlusTablespoon() {
		let quart = QuartMeasurement(amount: 1)
		let tablespoon = TablespoonMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 1.015625)
		let test = quart + tablespoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testQuartPlusTeaspoon() {
		let quart = QuartMeasurement(amount: 1)
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let answer = QuartMeasurement(amount: 1.0052083333333333)
		let test = quart + teaspoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	// MARK: - Cup Addition
	func testCupPlusCup() {
		let cup1 = CupMeasurement(amount: 1)
		let cup2 = CupMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 2)
		let test = cup1 + cup2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testCupPlusQuart() {
		let cup = CupMeasurement(amount: 1)
		let quart = QuartMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 5)
		let test = cup + quart
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testCupPlusOunce() {
		let cup = CupMeasurement(amount: 1)
		let ounce = OunceMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 1.125)
		let test = cup + ounce
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testCupPlusTablespoon() {
		let cup = CupMeasurement(amount: 1)
		let tablespoon = TablespoonMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 1.0625)
		let test = cup + tablespoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testCupPlusTeaspoon() {
		let cup = CupMeasurement(amount: 1)
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 1.0208333333333333)
		let test = cup + teaspoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testCupPlusGallon() {
		let cup = CupMeasurement(amount: 1)
		let gallon = GallonMeasurement(amount: 1)
		let answer = CupMeasurement(amount: 17)
		let test = cup + gallon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	// MARK: - Tablespoon Addition
	
	func testTablespoonPlusTablespoon() {
		let tablespoon1 = TablespoonMeasurement(amount: 1)
		let tablespoon2 = TablespoonMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 2)
		let test = tablespoon1 + tablespoon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTablespoonPlusGallon() {
		let tablespoon = TablespoonMeasurement(amount: 1)
		let gallon = GallonMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 257)
		let test = tablespoon + gallon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTablespoonPlusQuart() {
		let tablespoon = TablespoonMeasurement(amount: 1)
		let quart = QuartMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 65)
		let test = tablespoon + quart
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTablespoonPlusCup() {
		let tablespoon = TablespoonMeasurement(amount: 1)
		let cup = CupMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 17)
		let test = tablespoon + cup
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTablespoonPlusOunce() {
		let tablespoon = TablespoonMeasurement(amount: 1)
		let ounce = OunceMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 3)
		let test = tablespoon + ounce
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTablespoonPlusTeaspoon() {
		let tablespoon = TablespoonMeasurement(amount: 1)
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let answer = TablespoonMeasurement(amount: 1.3333333333333333)
		let test = tablespoon + teaspoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	// MARK: - Teaspoon Addition
	
	func testTeaspoonPlusTeaspoon() {
		let teaspoon1 = TeaspoonMeasurement(amount: 1)
		let teaspoon2 = TeaspoonMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 2)
		let test = teaspoon1 + teaspoon2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTeaspoonPlusGallon() {
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let gallon = GallonMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 769)
		let test = teaspoon + gallon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTeaspoonPlusQuart() {
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let quart = QuartMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 193)
		let test = teaspoon + quart
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTeaspoonPlusCup() {
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let cup = CupMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 49)
		let test = teaspoon + cup
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTeaspoonPlusOunce() {
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let ounce = OunceMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 7)
		let test = teaspoon + ounce
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testTeaspoonPlusTablespoon() {
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let tablespoon = TablespoonMeasurement(amount: 1)
		let answer = TeaspoonMeasurement(amount: 4)
		let test = teaspoon + tablespoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	// MARK: - Ounce Addition
	
	func testOuncePlusOunce() {
		let ounce1 = OunceMeasurement(amount: 1)
		let ounce2 = OunceMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 2)
		let test = ounce1 + ounce2
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testOuncePlusGallon() {
		let ounce = OunceMeasurement(amount: 1)
		let gallon = GallonMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 129)
		let test = ounce + gallon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testOuncePlusQuart() {
		let ounce = OunceMeasurement(amount: 1)
		let quart = QuartMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 33)
		let test = ounce + quart
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testOuncePlusCup() {
		let ounce = OunceMeasurement(amount: 1)
		let cup = CupMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 9)
		let test = ounce + cup
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testOuncePlusTablespoon() {
		let ounce = OunceMeasurement(amount: 1)
		let tablespoon = TablespoonMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 1.5)
		let test = ounce + tablespoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
	
	func testOuncePlusTeaspoon() {
		let ounce = OunceMeasurement(amount: 1)
		let teaspoon = TeaspoonMeasurement(amount: 1)
		let answer = OunceMeasurement(amount: 1 + (1/6))
		let test = ounce + teaspoon
		print("test: \(test)")
		print("answer: \(answer)")
		XCTAssertTrue(test == answer)
	}
}

