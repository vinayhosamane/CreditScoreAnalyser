//
//  ViewController.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 25/03/21.
//

import UIKit

// View controller responsible for showing credit score chart and it's details.
class ViewController: UIViewController {
    
    @IBOutlet weak var pointerLabel: UILabel!
    @IBOutlet weak var creditScoreCircleView: CreditScoreUI!
    
    @IBOutlet weak var searchScoreView: SearchScoreView!
    
    @IBOutlet weak var highestScaleView: CreditScoreScaleView!
    @IBOutlet weak var higherScaleView: CreditScoreScaleView!
    @IBOutlet weak var mediumScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowestScaleView: CreditScoreScaleView!
    
    var creditScoreReport: CreditScoreCalculatable?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // process json credit score report
        creditScoreReport = CreditScoreCalculator()
        
        guard let report = creditScoreReport else {
            return
        }
        
        // update credit score.
        creditScoreCircleView.configure(with: CreditScoreUIInput(score: report.getCreditScore(),
                                                                 color: report.getCreditScoreColor() ?? .white))
        
        // let's add center text to the circle.
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        label.frame = CGRect(x: 0 + (creditScoreCircleView.bounds.width/2) - 30,
                             y: creditScoreCircleView.bounds.height / 2 - 35.0,
                             width: 100,
                             height: 100)
        label.text = "\(report.getCreditScore())"
        label.textColor = report.getCreditScoreColor() ?? .red
        label.isHidden = false
        creditScoreCircleView.addSubview(label)
        creditScoreCircleView.setNeedsDisplay()
        
        // 1. set scale colors from the report
        guard let scales = report.getCreditScoreScales() else {
            return
        }
        if !scales.isEmpty && scales.count == 5 {
            // highest scale
            let highestScale = scales[0]
            let hightScaleInput = CreditScoreScaleViewInput(percentageValue: "19%",
                                                            scaleContainerViewBGColor: UIColor(hexRGB: highestScale.colorHex) ?? .white,
                                                            scaleLabelValue: "\(highestScale.min) - \(highestScale.max)")
            highestScaleView.configWithValues(with: hightScaleInput)
            
            // higher scale
            let higherScale = scales[1]
            let higherScaleInput = CreditScoreScaleViewInput(percentageValue: "20%",
                                                            scaleContainerViewBGColor: UIColor(hexRGB: higherScale.colorHex) ?? .white,
                                                            scaleLabelValue: "\(higherScale.min) - \(higherScale.max)")
            higherScaleView.configWithValues(with: higherScaleInput)
            
            // moderate scale
            let moderateScale = scales[2]
            let moderateScaleInout = CreditScoreScaleViewInput(percentageValue: "21%",
                                                            scaleContainerViewBGColor: UIColor(hexRGB: moderateScale.colorHex) ?? .white,
                                                            scaleLabelValue: "\(moderateScale.min) - \(moderateScale.max)")
            mediumScaleView.configWithValues(with: moderateScaleInout)
            
            // low scale
            let lowScale = scales[3]
            let lowScaleInput = CreditScoreScaleViewInput(percentageValue: "21%",
                                                            scaleContainerViewBGColor: UIColor(hexRGB: lowScale.colorHex) ?? .white,
                                                            scaleLabelValue: "\(lowScale.min) - \(lowScale.max)")
            lowScaleView.configWithValues(with: lowScaleInput)
            
            // lowest scale
            let lowestScale = scales[4]
            let lowestScaleInput = CreditScoreScaleViewInput(percentageValue: "19%",
                                                            scaleContainerViewBGColor: UIColor(hexRGB: lowestScale.colorHex) ?? .white,
                                                            scaleLabelValue: "\(lowestScale.min) - \(lowestScale.max)")
            lowestScaleView.configWithValues(with: lowestScaleInput)
            
        }
        
    }

}

