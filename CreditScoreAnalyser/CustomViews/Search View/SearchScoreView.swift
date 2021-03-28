//
//  SearchScoreView.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 27/03/21.
//

import Foundation
import UIKit

@IBDesignable
final class SearchScoreView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchLabel: BaselineAlignedLabel!
    @IBOutlet weak var searchIcon: UIImageView!
    
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
        guard let view = self.loadViewFromNib(nibName: String(describing: SearchScoreView.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
        
        // let's add underline to the label
        let attributedString = NSMutableAttributedString(string: searchLabel.text ?? "See My Score Analysis")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: attributedString.length))
        
        searchLabel.attributedText = attributedString
        searchLabel.sizeToFit()
    }
    
}

extension UIView {

    func loadViewFromNib(nibName name: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
