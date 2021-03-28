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
    
    @IBOutlet weak var shadowMarkerView: UIView!
    
    @IBOutlet weak var triangularView: UIView!

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
    
    // drawing triangular head to marker
    func setLeftTriangle(){
        let height = triangularView.frame.size.height
        let width = triangularView.frame.size.width
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x:0, y: height/2))
        path.addLine(to: CGPoint(x:height/2, y:height))
        path.addLine(to: CGPoint(x:height/2, y:0))
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor.white.cgColor
        shape.lineWidth = 4
        shape.strokeColor = UIColor.white.cgColor
        
        triangularView.layer.insertSublayer(shape, at: 0)
    }
    
    func configure() {
        guard let view = self.loadViewFromNib(nibName: String(describing: CreditScoreScaleView.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // let's add shadow offset to marker
        shadowMarkerView.layer.shadowColor = UIColor.black.cgColor
        shadowMarkerView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowMarkerView.layer.shadowRadius = 2
        shadowMarkerView.layer.shadowOpacity = 0.2
        
        setLeftTriangle()
    }
    
    func configWithValues(with config: CreditScoreScaleViewInput) {
        percentageLabel.text = config.percentageValue
        scaleContainerView.backgroundColor = config.scaleContainerViewBGColor
        scaleLabel.text = config.scaleLabelValue
        if config.shouldShowMarker {
            markerLabel.text = config.markerLabelText
        }
        triangularView.backgroundColor = config.scaleContainerViewBGColor
    }
    
    func hideMarker(hide: Bool) {
        markerView.isHidden = hide
        markerLabel.isHidden = hide
    }
    
}
