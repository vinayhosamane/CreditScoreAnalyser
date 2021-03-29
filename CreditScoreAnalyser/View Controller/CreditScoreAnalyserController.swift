//
//  ViewController.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 25/03/21.
//

import UIKit

// View controller responsible for showing credit score chart and it's details.
class CreditScoreAnalyserController: UIViewController {
    
    // circle view
    @IBOutlet weak var creditScoreCircleView: CreditScoreUI!
    
    // search score view
    @IBOutlet weak var searchScoreView: SearchScoreView!
    
    // scales
    @IBOutlet weak var highestScaleView: CreditScoreScaleView!
    @IBOutlet weak var higherScaleView: CreditScoreScaleView!
    @IBOutlet weak var mediumScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowestScaleView: CreditScoreScaleView!
    @IBOutlet weak var circleMaskView: UIView!
    
    var viewsMap: [CreditScoreScaleView] = []
    
    // credit score model
    var creditScoreReport: CreditScoreCalculatable?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // map of all scle views
        viewsMap = [highestScaleView, higherScaleView, mediumScaleView, lowScaleView, lowestScaleView]
        
        // process json credit score report
        creditScoreReport = CreditScoreCalculator(with: "SampleCreditScoreReport")
        
        guard let report = creditScoreReport else {
            return
        }
        
        // update credit score.
        creditScoreCircleView.configure(with: CreditScoreUIInput(score: report.getCreditScore(),
                                                                 color: report.getCreditScoreColor() ?? .white))
        
        addCenterLabelToMaskView()

        guard let scales = report.getCreditScoreScales() else {
            return
        }
        if !scales.isEmpty {
            // loop through scales and configure them.
            scales.enumerated().forEach { (index, scale: Scale) in
                // let's configure
                configureScaleView(forScale: scale, forView: viewsMap[index])
            }
        }
        
    }
    
    func configureScaleView(forScale scale: Scale, forView view: CreditScoreScaleView) {
        guard let report = creditScoreReport else {
            return
        }
        
        let shouldShowMarker = report.doesScoreBelongsToScale(score: report.getCreditScore(), scale: scale)
        view.hideMarker(hide: !shouldShowMarker)
        let markerLabelText = "\(Int(report.getCreditScore()))"
        let scaleInput = CreditScoreScaleViewInput(percentageValue: scale.percentile,
                                                        scaleContainerViewBGColor: UIColor(hexRGB: scale.colorHex) ?? .white,
                                                        scaleLabelValue: "\(scale.min) - \(scale.max)", shouldShowMarker: shouldShowMarker,
                                                        markerLabelText: shouldShowMarker ? markerLabelText : nil)
        view.configWithValues(with: scaleInput)
    }
    
    func addCenterLabelToMaskView() {
        guard let report = creditScoreReport else {
            return
        }
        // let's add center text to the circle.
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40.0, weight: .heavy)
        label.frame = CGRect(x: circleMaskView.bounds.origin.x + circleMaskView.bounds.size.width / 2 - 40,
                             y: circleMaskView.bounds.origin.y + circleMaskView.bounds.size.height / 2 - 40,
                             width: 100,
                             height: 100)
        label.text = "\(Int(report.getCreditScore()))"
        label.textColor = report.getCreditScoreColor() ?? .red
        label.isHidden = false
        circleMaskView.addSubview(label)
        circleMaskView.setNeedsDisplay()
    }

}

