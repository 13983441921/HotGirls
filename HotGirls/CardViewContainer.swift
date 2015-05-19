//
//  CardViewContainer.swift
//  HotGirls
//
//  Created by 臧其龙 on 15/5/19.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit

protocol CardViewContainerDelegate{
    func cardDidEndAnimationStart()
}

class CardViewContainer: UIView {
    
    var cardViewArray:[CardView] = []
    var rectArray:[CGRect] = []
    var alphaArray:[CGFloat] = []
    var delegate:CardViewContainerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0..<3{
            var cardView:CardView = CardView(frame: CGRectInset(self.bounds, CGFloat(i)*20.0, CGFloat(i)*20.0))
        
            cardView.girlImage = UIImage(named: "meishi\(i+1).jpg")!
            print("meishi\(i).jpg\n")
            cardView.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0 , CGRectGetHeight(self.bounds)/2.0 + CGFloat(i)*30.0)
            cardView.alpha = 1-CGFloat(i) * 0.1
            alphaArray.append(cardView.alpha)
            cardViewArray.append(cardView)
            rectArray.append(cardView.frame)
            
            self.addSubview(cardView)
            self.sendSubviewToBack(cardView)
        }
        
        var layerTransform:CATransform3D = CATransform3DIdentity
        layerTransform.m34 = -1.0/500
        
        self.layer.transform = layerTransform
       
        var gesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        
        self.addGestureRecognizer(gesture)
    }
    
    func handlePanGesture(gesture:UIPanGestureRecognizer){
        var startPoint = CGPointZero
        switch gesture.state{
        case .Began:
            var point = gesture.locationInView(self)
            startPoint = point
        case .Changed:
            var translatePoint = gesture.translationInView(self)
            for i in 0..<3{
                var cardView:CardView = cardViewArray[i]
                cardView.center = CGPointMake(cardView.center.x + translatePoint.x*0.5*CGFloat(3-i), cardView.center.y)
            }
            gesture.setTranslation(CGPointZero, inView: self)
        case .Ended:
            
            var endPoint = gesture.locationInView(self)
            
            
            if endPoint.x > CGRectGetWidth(self.bounds) - 30 {
                var firstCardView:CardView = cardViewArray[0]
                var lastOriginalRect:CGRect = rectArray.last!
                var lastAlpha:CGFloat = alphaArray.last!
                
                cardViewArray.removeAtIndex(0)
                cardViewArray.append(firstCardView)

                UIView .animateWithDuration(0.25, animations: { () -> Void in
                    firstCardView.center = CGPointMake(CGRectGetWidth(self.bounds), firstCardView.center.y)
                })
            }else if endPoint.x < 100
            {
                var firstCardView:CardView = cardViewArray[0]
                var lastOriginalRect:CGRect = rectArray.last!
                var lastAlpha:CGFloat = alphaArray.last!
                
                cardViewArray.removeAtIndex(0)
                cardViewArray.append(firstCardView)
                

                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                     firstCardView.center = CGPointMake(-CGRectGetWidth(self.bounds)*2, firstCardView.center.y)
                    }, completion: { (isCompletion:Bool) -> Void in
                        
                        
                        for i in 0..<2{
                            var cardView:CardView = self.cardViewArray[i]
                            var originalRect:CGRect = self.rectArray[i]
                            var alphaInArray:CGFloat = self.alphaArray[i]
                            
                            self.delegate?.cardDidEndAnimationStart()
                            UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                                cardView.frame = originalRect
                                cardView.alpha = alphaInArray
                                }, completion: { (flag:Bool) -> Void in
                                    self.sendSubviewToBack(firstCardView)
                                    firstCardView.frame = lastOriginalRect
                                    firstCardView.alpha = lastAlpha
                            })

                        }
                })
            }else
            {
                for i in 0..<3{
                    var cardView:CardView = cardViewArray[i]
                    var originalRect:CGRect = rectArray[i]
                    
                    delegate?.cardDidEndAnimationStart()
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                        cardView.frame = originalRect
                        }, completion: { (flag:Bool) -> Void in
                            
                    })
                }

            }
            
        default:
            print("defailt")
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleRightScroll(endPoint:CGPoint){
        
    }

}
