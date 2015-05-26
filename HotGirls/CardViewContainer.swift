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
    
    let kDeleteXNum:CGFloat = 100.0
    let kDeltaHeightAndWidth:CGFloat = 20.0
    let kDeltaYAxis:CGFloat = 30.0
    
    var cardViewArray:[CardView] = []
    var rectArray:[CGRect] = []
    var alphaArray:[CGFloat] = []
    var delegate:CardViewContainerDelegate?
    
    var isOpenCardModel:Bool = true{
        didSet{
            openCardModel(isOpenCardModel)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for i in 0..<3{
            var cardView:CardView = CardView(frame: CGRectInset(self.bounds, CGFloat(i)*kDeltaHeightAndWidth, CGFloat(i)*kDeltaHeightAndWidth))
        
            cardView.girlImage = UIImage(named: "meishi\(i+1).jpg")!
            print("meishi\(i).jpg\n")
            cardView.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0 , CGRectGetHeight(self.bounds)/2.0 + CGFloat(i)*kDeltaYAxis)
            cardView.alpha = 1-CGFloat(i) * 0.1
            alphaArray.append(cardView.alpha)
            cardViewArray.append(cardView)
            rectArray.append(cardView.frame)
            
            self.addSubview(cardView)
            self.sendSubviewToBack(cardView)
        }
        
        print("array count is %d",cardViewArray.count)
        
        var gesture:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        
        self.addGestureRecognizer(gesture)
        
        var tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
        
        self.addGestureRecognizer(tapGesture)
    }
    
    func handlePanGesture(gesture:UIPanGestureRecognizer){
        var startPoint = CGPointZero
        switch gesture.state{
        case .Began:
            var point = gesture.locationInView(self)
            startPoint = point
        case .Changed:
            var translatePoint = gesture.translationInView(self)
            
            if isOpenCardModel{
                for i in 0..<3{
                    var cardView:CardView = cardViewArray[i]
                    cardView.center = CGPointMake(cardView.center.x + translatePoint.x*0.5*CGFloat(3-i), cardView.center.y)
                }
                gesture.setTranslation(CGPointZero, inView: self)
            }else
            {
                
            }
            
        case .Ended:
            
            var endPoint = gesture.locationInView(self)
            
            if isOpenCardModel{
                detectEndPoint(endPoint)
            }else
            {
                
            }
            
            
        default:
            print("defailt")
        }
    }
    
    func detectEndPoint(endPoint:CGPoint){
        if endPoint.x > (CGRectGetWidth(self.bounds) - kDeleteXNum) {
            var firstCardView:CardView = cardViewArray[0]
            var lastOriginalRect:CGRect = rectArray.last!
            var lastAlpha:CGFloat = alphaArray.last!
            
            cardViewArray.removeAtIndex(0)
            cardViewArray.append(firstCardView)
            
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                firstCardView.center = CGPointMake(CGRectGetWidth(self.bounds)*2, firstCardView.center.y)
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
                                
                        })
                        
                    }
                    
                    
                    firstCardView.frame = lastOriginalRect
                    firstCardView.alpha = lastAlpha
                    UIView.animateWithDuration(0.25, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        self.sendSubviewToBack(firstCardView)
                        
                        
                        }, completion: { (_) -> Void in
                            
                    })

            })
            
        }else if endPoint.x < kDeleteXNum
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

                        })
                        
                        
                    }
                    firstCardView.frame = lastOriginalRect
                    firstCardView.alpha = lastAlpha
                    UIView.animateWithDuration(0.25, delay: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        self.sendSubviewToBack(firstCardView)
                        
                        
                        }, completion: { (_) -> Void in
                            
                    })
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

    }
    
    func handleTapGesture(tapGesture:UITapGestureRecognizer){
        isOpenCardModel = !isOpenCardModel
    }
    
    func openCardModel(open:Bool){
        if open{
            for i in 0..<cardViewArray.count{
                var view:CardView = cardViewArray[i]
                
                UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    view.frame = self.rectArray[i]
                    }, completion: { (flag:Bool) -> Void in
                })
            }
            var firstView:CardView = self.cardViewArray[0]
            firstView.showAvatarImageView(false)

        }else
        {
            var firstRect:CGRect = rectArray.first!

            for i in 1..<cardViewArray.count{
                var view:CardView = cardViewArray[i]
                
                // 如果不缩小ImageView那么在动画期间imageView的大小会直接是父view结束时的大小
                view.prepareForHideImageView()
                
                UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    view.frame = firstRect
                    }, completion: { (flag:Bool) -> Void in
                       view.finishedPrepareHideImageView()
                        
                })

            }
            var firstView:CardView = self.cardViewArray[0]
            firstView.showAvatarImageView(true)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleRightScroll(endPoint:CGPoint){
        
    }

}
