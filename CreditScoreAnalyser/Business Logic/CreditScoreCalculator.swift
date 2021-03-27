//
//  CreditScoreCalculator.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

enum Type: String, Decodable {
    case lower
}

struct Scale: Codable {
    var type: String
    var min: Int
    var max: Int
    var colorHex: String
}

struct CreditScore: Codable {
    var score: Double
    var scales: [Scale]
}

protocol CreditScoreCalculatable {
    func getCreditScore() -> Double
    func getCreditScoreScales() -> [Scale]?
    func getCreditScoreColor() -> UIColor?
}

// this class helps in fetching json data for the credit score and de-serializes data into objects.
class CreditScoreCalculator: CreditScoreCalculatable {
    
    var creditScoreReport: CreditScore? = nil
    
    // let's write code to get the json from undle
    init() {
        deSerializeJsonFile()
    }
    
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
    func buildRange() -> [Double]? {
        let scales = creditScoreReport?.scales.map({ (scale: Scale) -> Any in
            return scale.min...scale.max
        })
        return scales as? [Double]
    }
    
}

// copied from internet
extension UIColor {

    convenience init?(hexRGBA: String?) {
        guard let rgba = hexRGBA, let val = Int(rgba.replacingOccurrences(of: "#", with: ""), radix: 16) else {
            return nil
        }
        self.init(red: CGFloat((val >> 24) & 0xff) / 255.0, green: CGFloat((val >> 16) & 0xff) / 255.0, blue: CGFloat((val >> 8) & 0xff) / 255.0, alpha: CGFloat(val & 0xff) / 255.0)
    }
    
    // handles both hex 6 and hex 8
    convenience init?(hexRGB: String?) {
        guard let rgb = hexRGB else {
            return nil
        }
        self.init(hexRGBA: rgb + "ff") // Add alpha = 1.0
    }

}
