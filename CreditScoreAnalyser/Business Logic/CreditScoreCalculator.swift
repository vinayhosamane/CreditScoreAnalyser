//
//  CreditScoreCalculator.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

// this class helps in fetching json data for the credit score and de-serializes data into objects.
class CreditScoreCalculator: CreditScoreCalculatable {
    
    var creditScoreReport: CreditScore? = nil
    
    // let's write code to get the json from bundle
    init() {
        deSerializeJsonFile()
    }
    
    // datat processor
    private func deSerializeJsonFile() {
        // get json data from bundle
        do {
            if let jsonPath = Bundle.main.path(forResource: "SampleCreditScoreReport", ofType: "json"),
               let jsonData = try String(contentsOfFile: jsonPath).data(using: .utf8) {
                creditScoreReport = try JSONDecoder().decode(CreditScore.self, from: jsonData)
            }
        } catch {
            print("something is wrong with json de-serialization")
        }
    }
    
    // returns credit score
    func getCreditScore() -> Double {
        return creditScoreReport?.score ?? 0.0
    }
    
    // returns credit score scales
    func getCreditScoreScales() -> [Scale]? {
        return creditScoreReport?.scales
    }
    
    func getCreditScoreColor() -> UIColor? {
        guard let report = creditScoreReport else {
            return nil
        }
        var color: UIColor?
        report.scales.forEach({ (scale: Scale) in
            // let's find out if the value is in scale
            if (scale.min...scale.max).contains(Int(report.score)) {
                // yes it is in the range
                color = UIColor(hexRGB: scale.colorHex)
            }
        })
        return color
    }
    
    //returns scales range in array
    private func buildRange() -> [Double]? {
        let scales = creditScoreReport?.scales.map({ (scale: Scale) -> Any in
            return scale.min...scale.max
        })
        return scales as? [Double]
    }
    
    func doesScoreBelongsToScale(score: Double, scale: Scale) -> Bool {
        guard let report = creditScoreReport else {
            return false
        }
        if (scale.min...scale.max).contains(Int(report.score)) {
            // yes it is in the range
            return true
        }
        return false
    }
    
}
