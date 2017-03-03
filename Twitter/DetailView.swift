//
//  DetailView.swift
//  Twitter
//
//  Created by Aristotle on 2017-03-02.
//  Copyright © 2017 HLPostman. All rights reserved.
//

import Foundation
import UIKit

class DetailView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromXib()
//        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFromXib() -> Void {
        Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)
        view.frame = self.frame
        view.backgroundColor = UIColor.red
        view.layoutIfNeeded()
        self.addSubview(view)
    }

}
