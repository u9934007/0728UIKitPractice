//
//  ViewController.swift
//  0728UIKitPractice
//
//  Created by 楊采庭 on 2017/7/28.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let segmentControl = UISegmentedControl(items: [ "1", "2", "3", "4"])

        segmentControl.frame = CGRect(x: 50, y: 50, width: 120, height: 30)
        segmentControl.center.x = CGFloat(screenWidth/2)
        segmentControl.center.y = CGFloat(screenHeight/4)

        segmentControl.selectedSegmentIndex = 1

//        segmentControl.addTarget(self, action: "changePicture:", for: UIControlEvents.valueChanged)

        self.view.addSubview(segmentControl)

    }

}
