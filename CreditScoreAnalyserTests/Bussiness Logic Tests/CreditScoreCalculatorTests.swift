//
//  CreditScoreCalculatorTests.swift
//  CreditScoreAnalyserTests
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//
@testable import CreditScoreAnalyser
import XCTest

/*
 1. use new mock json file
 2. after deserialisation, validate the decoded model and it's values.
 3. test getCreditScore() method
 4. test getCreditScoreScales() method
 5. test getCreditScoreColor() method
 6. test doesScoreBelongsToScale() method
 */

class CreditScoreCalculatorTests: XCTestCase {
    
    var creditScoreCalculator: CreditScoreCalculatable? = nil

    override func setUpWithError() throws {
        // load mock json to the credit score calculator
        creditScoreCalculator = CreditScoreCalculator(with: "MockCreditScoreReport")
    }

    override func tearDownWithError() throws {
        creditScoreCalculator = nil
    }

    func testGetCreditScore() {
        guard let report = creditScoreCalculator else {
            XCTFail("Could not find valid score calculator")
            return
        }
        XCTAssert(report.getCreditScore() == 868.0, "Validate if the credit score form json is same as inside the report.")
    }
    
    func testGetCreditScoreScales() {
        guard let report = creditScoreCalculator else {
            XCTFail("Could not find valid score calculator")
            return
        }
        XCTAssert(report.getCreditScoreScales()?.count == 5, "Check if we have got 5 scales from json.")
    }
    
    func testGetCreditScoreColor() {
        guard let report = creditScoreCalculator else {
            XCTFail("Could not find valid score calculator")
            return
        }
        //(hex)#D8AC3D --- rgb(216,172,61)
        XCTAssert(report.getCreditScoreColor() == UIColor(hexRGB: "#A3C65D"), "Validate the color for credit score.")
    }
    
    func testDoesScoreBelongsToScale() {
        guard let report = creditScoreCalculator else {
            XCTFail("Could not find valid score calculator")
            return
        }
        let sampleScale = Scale(type: "highest",
                                min: 825,
                                max: 900,
                                colorHex: "#A3C65D",
                                percentile: "19%")
        let score = report.getCreditScore()
        
        XCTAssert(report.doesScoreBelongsToScale(score: score, scale: sampleScale) == true, "check if the score is available in the given scale.")
    }

}
