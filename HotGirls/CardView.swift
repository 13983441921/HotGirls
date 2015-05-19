//
//  CardView.swift
//  HotGirls
//
//  Created by 臧其龙 on 15/5/18.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    var girlImageView: UIImageView = UIImageView()
    
    var girlImage: UIImage?{
        didSet{
            girlImageView.image = girlImage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        
        
        self.addSubview(girlImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        girlImageView.frame = CGRectInset(self.bounds, 10, 40)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
