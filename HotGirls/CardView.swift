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
    
    var girlImageView: UIImageView = UIImageView(frame: CGRectZero)
    
    var girlImage: UIImage?{
        didSet{
            girlImageView.image = girlImage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(girlImageView)
        
        girlImageView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.edges.equalTo(self).insets(EdgeInsetsMake(20, 10, 20, 10))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
