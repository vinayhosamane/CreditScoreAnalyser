//
//  CreditScoreScaleView.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

@IBDesignable
final class CreditScoreScaleView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var scaleContainerView: UIView!
    @IBOutlet weak var scaleLabel: UILabel!
    
    
    @IBOutlet weak var markerView: ScaleMarkerView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        guard let view = self.loadViewFromNib(nibName: String(describing: CreditScoreScaleView.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func configWithValues(with config: CreditScoreScaleViewInput) {
        percentageLabel.text = config.percentageValue
        scaleContainerView.backgroundColor = config.scaleContainerViewBGColor
        scaleLabel.text = config.scaleLabelValue
        if config.shouldShowMarker {
            // configure marker view
            let markerViewInput = ScaleMarkerViewUIInput(bgColor: config.scaleContainerViewBGColor,
                                                         markerLabeltext: config.markerLabelText ?? "")
            markerView.config(with: markerViewInput)
            
        }
    }
    
    func hideMarker(hide: Bool) {
        markerView.isHidden = hide
    }
    
}
