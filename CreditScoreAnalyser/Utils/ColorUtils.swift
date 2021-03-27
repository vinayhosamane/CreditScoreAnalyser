//
//  ColorUtils.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 26/03/21.
//

import Foundation
import UIKit

// all required color pallets are placed in one file for easy and efficient maintainance.
struct ColorUtils {
    static let strokeColor = UIColor(red: 217/255, green: 165/255, blue: 59/255, alpha: 1.0).cgColor
    static let emptyStrokeColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0).cgColor
    static let labelColor = UIColor(red: 217/255, green: 165/255, blue: 59/255, alpha: 1.0)
    static let arcFillingColor = UIColor.clear.cgColor
    static let scale1 = UIColor(displayP3Red: 163/255, green: 198/255, blue: 93/255, alpha: 1)
    static let scale2 = UIColor(displayP3Red: 216/255, green: 172/255, blue: 61/255, alpha: 1)
    static let scale3 = UIColor(displayP3Red: 206/255, green: 119/255, blue: 51/255, alpha: 1)
    static let scale4 = UIColor(displayP3Red: 197/255, green: 77/255, blue: 42/255, alpha: 1)
    static let scale5 = UIColor(displayP3Red: 193/255, green: 55/255, blue: 39/255, alpha: 1)
}
