//
//  CreditScoreUI.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 25/03/21.
//
import UIKit
import Foundation

struct CreditScoreUIInput {
    var score: Double
    var color: UIColor
}

protocol CreditScoreExternalInterface {
    func configure(with config: CreditScoreUIInput)
}

// 1. color scale needs to be implemented
/*{
 sclae: [ (scale, color), (sclae, color), (scale, color), (scal, color) ],
 value: 860
 }
 */

//struct ColorRangeCalculator {
//
//    private var incomingNumber: Double
//    private var currentColorPallete: UIColor
//
//    init(scaleUnit: Double) {
//        incomingNumber = scaleUnit
//
//        // calculate color pallete for the range
//        if (825...900).contains(incomingNumber) {
//            // in 825-900 credit score sclae
//            currentColorPallete = ColorUtils.scale1
//        } else if (800...824).contains(incomingNumber) {
//            // in 800-824 credit score sclae
//            currentColorPallete = ColorUtils.scale2
//        } else if (775...799).contains(incomingNumber) {
//            // in 775-799 credit score sclae
//            currentColorPallete = ColorUtils.scale3
//        } else if (700...774).contains(incomingNumber) {
//            // in 700-774 credit score sclae
//            currentColorPallete = ColorUtils.scale4
//        } else if (300...699).contains(incomingNumber) {
//            // in 800-824 credit score sclae
//            currentColorPallete = ColorUtils.scale5
//        } else {
//            currentColorPallete = UIColor.white
//        }
//    }
//
//    func getStrokeColor() -> UIColor {
//        return currentColorPallete
//    }
//
//}

// this class is responsible for building credit score circle UI.
@IBDesignable class CreditScoreUI: UIView, CreditScoreExternalInterface {
    
    private var strokeColor = ColorUtils.strokeColor
    
    // score receibed from report
    private var creditScore: CGFloat = 860.0

    // it is in percentage
    private var myCreditScore: CGFloat = 820.0 / CGFloat(Constants.creditScoreScale)
    
    // start angle for the arc
    private lazy var startAngle: CGFloat = {
        return 0 + CGFloat.pi / 2 // pi starts at 180 degree from right, so I have move it down to 90 degree
    }()
    
    // end angle for the arc
    private lazy var endAngle: CGFloat = {
        return 2 * CGFloat.pi // it has to be 270 degree
    }()
    
    // gives radius of the arc
    private lazy var radius: CGFloat = {
        return 120 // we have to calculate this from the arc size..need to think out loud.
    }()

    // gives another arc layer to mimic the empty or un-filled state.
    private lazy var maskLayer: (_ rect: CGRect, _ radius: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat) -> CAShapeLayer = { (rect, radius, startAngle, endAngle) in
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = ColorUtils.arcFillingColor

        let circularPath = UIBezierPath(arcCenter: self.getViewCenter(for: rect), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circularPath.fill()

        maskLayer.path = circularPath.cgPath
        maskLayer.strokeColor = ColorUtils.emptyStrokeColor
        maskLayer.lineWidth = Constants.strokeLineWidth
        maskLayer.lineCap = .round

        return maskLayer
    }
    
    private lazy var circleLayer: (_ rect: CGRect, _ radius: CGFloat, _ startAngle: CGFloat, _ endAngle: CGFloat) -> CAShapeLayer = { (rect, radius, startAngle, endAngle) in
        // stroked circle
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = ColorUtils.arcFillingColor

        let circularPath = UIBezierPath(arcCenter: self.getViewCenter(for: rect), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        circularPath.fill()
        shapeLayer.path = circularPath.cgPath

        shapeLayer.strokeColor = self.strokeColor
        shapeLayer.lineWidth = Constants.strokeLineWidth
        shapeLayer.strokeEnd = Constants.strokeEnd
        shapeLayer.lineCap = .round

        return shapeLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        // let's set the corner radius to look like circle.
        layer.cornerRadius = frame.width / 2

        // let add circle and it's mask to the layer.
        
//        circleLayer.fillColor = UIColor.clear.cgColor
//        maskLayer.fillColor = UIColor.clear.cgColor
        let belowLayer = maskLayer(frame, radius, startAngle, endAngle)
        let strokeLayer = circleLayer(frame, radius, startAngle, endAngle)

        self.layer.addSublayer(belowLayer)
        
        // stroked circle
        self.layer.addSublayer(strokeLayer)
        
        // add center text
        let textLayer = CATextLayer()
        textLayer.string = "\(Int(creditScore))"
        textLayer.foregroundColor = ColorUtils.strokeColor
        textLayer.font = FontUtils.centerTextFont
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: frame.origin.x, y: frame.origin.y + frame.height / 2 - 15, width: frame.width, height: Constants.centerTextHeight)
        textLayer.contentsScale = UIScreen.main.scale
        self.layer.addSublayer(textLayer)
        
        // let's add some animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = myCreditScore
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        strokeLayer.add(animation, forKey: "basicAnimation")
    }
    
    override func draw(_ rect: CGRect) {
       // we can use either draw rect or CSLayer to draw some custome or heirarchiel views into the parent view.
       // this might be slower than drawing in the CALayer.
    }
    
    func configure(with config: CreditScoreUIInput) {
        // configure score and colore from here.
                    // set credit score in the view state and re-draw the view.
        myCreditScore = CGFloat(config.score / Constants.creditScoreScale)
        strokeColor = config.color.cgColor
        creditScore = CGFloat(config.score)
        // re-draw layers
        setup()
        self.setNeedsDisplay()
    }
    
}

extension CreditScoreUI {

    // returns arc radius, calculated from drawn view bounds size.
    fileprivate func getRadius(for rect: CGRect) -> CGFloat {
        return rect.width / 2
    }
    
    // returns center of the view for arc circl to calculate the angle.
    fileprivate func getViewCenter(for rect: CGRect) -> CGPoint {
        return CGPoint(x: rect.width / 2, y: rect.height / 2)
    }
    
}
