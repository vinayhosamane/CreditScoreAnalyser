//
//  CircleUI.swift
//  CreditScoreAnalyser
//
//  Created by Hosamane, Vinay K N on 29/03/21.
//

import Foundation
import UIKit

class CircleUI: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var creditScoreView: CreditScoreUI!
    
    @IBOutlet weak var centerLabel: UILabel!
    
    @IBOutlet weak var arcStartLabel: UILabel!
    @IBOutlet weak var arcEndLabel: UILabel!
    
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
    
    private func configure() {
        guard let view = self.loadViewFromNib(nibName: String(describing: CircleUI.self)) else {
            return
        }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    func configure(with config: CreditScoreUIInput) {
        // set credit score in the view state and re-draw the view.
        creditScoreView.configure(with: config)
        
        centerLabel.text = "\(Int(config.score))"
        centerLabel.textColor = config.color
    }
}
