//
//  ScaleMarkerView.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 28/03/21.
//

import Foundation
import UIKit

struct ScaleMarkerViewUIInput {
    var bgColor: UIColor
    var markerLabeltext: String
}

@IBDesignable
final class ScaleMarkerView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var triangularTipView: UIView!
    @IBOutlet weak var markerShadowView: UIView!
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
        guard let view = self.loadViewFromNib(nibName: String(describing: ScaleMarkerView.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // let's add shadow offset to marker
        markerShadowView.layer.shadowColor = UIColor.black.cgColor
        markerShadowView.layer.shadowOffset = CGSize(width: 10, height: 25)
        markerShadowView.layer.shadowRadius = 2
        markerShadowView.layer.shadowOpacity = 0.2
        
        setLeftTriangle()
    }
    
    // drawing triangular head to marker
    func setLeftTriangle(){
        let height = triangularTipView.frame.size.height
        let width = triangularTipView.frame.size.width
        
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
        
        triangularTipView.layer.insertSublayer(shape, at: 0)
    }
    
    func config(with object: ScaleMarkerViewUIInput) {
        triangularTipView.backgroundColor = object.bgColor
        markerLabel.text = object.markerLabeltext
    }

}
