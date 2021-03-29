//
//  ViewController.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 25/03/21.
//

import UIKit

// View controller responsible for showing credit score chart and it's details.
class CreditScoreAnalyserController: UIViewController, ActionDelegate {
    
    // circle view
    @IBOutlet weak var creditScoreCircleView: CircleUI!
    
    // search score view
    @IBOutlet weak var searchScoreView: SearchScoreView!
    
    // scales
    @IBOutlet weak var highestScaleView: CreditScoreScaleView!
    @IBOutlet weak var higherScaleView: CreditScoreScaleView!
    @IBOutlet weak var mediumScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowScaleView: CreditScoreScaleView!
    @IBOutlet weak var lowestScaleView: CreditScoreScaleView!
    
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
        
        // configure search score view
        searchScoreView.configure(with: self)

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
        label.frame = CGRect(x: creditScoreCircleView.bounds.origin.x + creditScoreCircleView.bounds.size.width / 2 - 40,
                             y: creditScoreCircleView.bounds.origin.y + creditScoreCircleView.bounds.size.height / 2 - 40,
                             width: 100,
                             height: 100)
        label.text = "\(Int(report.getCreditScore()))"
        label.textColor = report.getCreditScoreColor() ?? .red
        label.isHidden = false
        creditScoreCircleView.addSubview(label)
        creditScoreCircleView.setNeedsDisplay()
    }
    
    func searchButtonClicked() {
        // search button clicked.
        let alertController = UIAlertController(title: "Alert", message: "See My Score Analysis", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            print("OK clicked")
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func infoIconClicked(_ sender: Any) {
        // user clicked on info icon in 'where you stand' view.
        let alertController = UIAlertController(title: "Alert", message: "Where you stand information", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            print("OK clicked")
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}

