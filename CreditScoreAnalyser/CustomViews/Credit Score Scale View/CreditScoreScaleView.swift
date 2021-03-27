//
//  CreditScoreScaleView.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

struct CreditScoreScaleViewInput {
    var percentageValue: String
    var scaleContainerViewBGColor: UIColor
    var scaleLabelValue: String
    var shouldShowMarker: Bool
    var markerLabelText: String?
}

@IBDesignable
final class CreditScoreScaleView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var scaleContainerView: UIView!
    @IBOutlet weak var scaleLabel: UILabel!
    
    
    @IBOutlet weak var markerView: UIView!
    @IBOutlet weak var markerLabel: UILabel!
    
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
        
        // let's add shadow offset to marker
        markerView.layer.shadowColor = UIColor.black.cgColor
        markerView.layer.shadowOffset = CGSize(width: 15, height: 15)
        markerView.layer.shadowRadius = 4
        markerView.layer.shadowOpacity = 0.2
    }
    
    func configWithValues(with config: CreditScoreScaleViewInput) {
        percentageLabel.text = config.percentageValue
        scaleContainerView.backgroundColor = config.scaleContainerViewBGColor
        scaleLabel.text = config.scaleLabelValue
        if config.shouldShowMarker {
            markerLabel.text = config.markerLabelText
        }
    }
    
    func hideMarker(hide: Bool) {
        markerView.isHidden = hide
        markerLabel.isHidden = hide
    }
    
}
