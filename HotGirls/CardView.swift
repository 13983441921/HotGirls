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
    var girlAvatarImageView:UIImageView = UIImageView(frame: CGRectZero)
    
    var girlImage: UIImage?{
        didSet{
            girlImageView.image = girlImage
        }
    }
    
    var girlAvatarImage:UIImage?{
        didSet{
            girlAvatarImageView.image = girlAvatarImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       // self.clipsToBounds = true
        self.backgroundColor = UIColor.whiteColor()
        
        girlAvatarImageView.layer.cornerRadius = 25
        girlAvatarImageView.layer.masksToBounds = true
        girlAvatarImageView.layer.borderWidth = 2
        girlAvatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        girlAvatarImageView.transform = CGAffineTransformMakeTranslation(0, -300)
        
        girlImage = UIImage(named: "tom.jpg")
        girlAvatarImageView.image = girlImage
        
        self.addSubview(girlImageView)
        self.addSubview(girlAvatarImageView)
        
        girlImageView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.edges.equalTo(self).insets(EdgeInsetsMake(20, 10, 20, 10))
        }
        
        girlAvatarImageView.snp_makeConstraints { (make:ConstraintMaker) -> Void in
            make.centerX.equalTo(self)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.top.equalTo(self).offset(-20)
        }
        
    }
    
    func prepareForHideImageView(){
        girlImageView.transform = CGAffineTransformMakeScale(0.1, 0.1)
    }
    
    func finishedPreppareHideImageView(){
        girlImageView.transform = CGAffineTransformIdentity
    }
    
    func showAvatarImageView(show:Bool){
        if show{
            UIView.animateWithDuration(0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.girlAvatarImageView.transform = CGAffineTransformIdentity
                }, completion: { (flag:Bool) -> Void in
                    
                    
            })
        
        }else
        {
            UIView.animateWithDuration(0.35, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.girlAvatarImageView.transform = CGAffineTransformMakeTranslation(0, -300)
                }, completion: { (flag:Bool) -> Void in
                    
                    
            })
            
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
