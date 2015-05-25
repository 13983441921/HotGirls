//
//  ViewController.swift
//  HotGirls
//
//  Created by 臧其龙 on 15/5/18.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var cupLayer:CAShapeLayer = CAShapeLayer()
    
    var screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
    var screenHeight = CGRectGetHeight(UIScreen.mainScreen().bounds)

    var starView:StarView = StarView(frame: CGRectMake(0, 0, 100, 100))
    var cardViewContainer:CardViewContainer = CardViewContainer(frame: CGRectMake(0, 0, 320, 260))
    var num:Int = 99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.blackColor()
        
        cardViewContainer.center = CGPointMake(self.view.center.x, self.view.center.y-100)
        cardViewContainer.delegate = self
        self.view.addSubview(cardViewContainer)
        
        starView.center = CGPointMake(self.view.center.x, self.view.center.y+200)
        self.view .addSubview(starView)
        
    }
    
    @IBAction func startAnimation(){
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:CardViewContainerDelegate{
    func cardDidEndAnimationStart() {
        var num:Int = Int(arc4random_uniform(99))
        starView.startLoadNumber(num)
    }
}