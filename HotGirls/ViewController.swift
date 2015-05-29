//
//  ViewController.swift
//  HotGirls
//
//  Created by 臧其龙 on 15/5/18.
//  Copyright (c) 2015年 臧其龙. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var cupLayer:CAShapeLayer = CAShapeLayer()
    
    var screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
    var screenHeight = CGRectGetHeight(UIScreen.mainScreen().bounds)

    var starView:StarView = StarView(frame: CGRectMake(0, 0, 100, 100))
    var cardViewContainer:CardViewContainer = CardViewContainer(frame: CGRectMake(0, 0, 320, 260))
    var num:Int = 99
    
    var imageURLArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor.blackColor()
        
        cardViewContainer.center = CGPointMake(self.view.center.x, self.view.center.y-100)
        cardViewContainer.delegate = self
    
        self.view.addSubview(cardViewContainer)
        
        starView.center = CGPointMake(self.view.center.x, self.view.center.y+200)
        self.view .addSubview(starView)
        
        
        Alamofire.request(.GET, "http://127.0.0.1:5000/meizi", parameters: nil)
            .response { (request, response, data, error) in
               // println(request)
                //println(response)
                var networkdata = data as! NSData
                let json = JSON(data: networkdata)
                for i in 0..<json.count{
                    var dict = json[i]
                    var string:String = dict["imgsrc"].stringValue
                    self.imageURLArray.append(string)
                }
                self.cardViewContainer.imageStringURLArray = self.imageURLArray
                print(self.imageURLArray)
                
        }
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