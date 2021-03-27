//
//  BaselineAlignedLabel.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

@IBDesignable class BaselineAlignedLabel: UILabel {

  override func drawText(in rect: CGRect) {
      if let stringText = text {
          let stringTextAsNSString = stringText as NSString
          let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width,height: CGFloat.greatestFiniteMagnitude),
                                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                          attributes: [NSAttributedString.Key.font: font as UIFont],
                                                                          context: nil).size
        super.drawText(in: CGRect(x:0,y: 3,width: self.frame.width, height:ceil(labelStringSize.height)))
      } else {
          super.drawText(in: rect)
      }
  }

  override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      layer.borderWidth = 1
      layer.borderColor = UIColor.black.cgColor
  }

}
