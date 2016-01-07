//
//  ViewController.swift
//  yangcong
//
//  Created by D_ttang on 16/1/7.
//  Copyright © 2016年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fromView = UIView()
    let openTrans = OpenAnimation()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print(sender)
        fromView = sender as! UIView
        
        //print(fromView)
        
        let secondViewController = segue.destinationViewController as! SecondViewController
//        secondViewController.fromCenter = fromView.center
        secondViewController.fromLeft = fromView.center.x - view.frame.width / 2
        secondViewController.fromTop = fromView.center.y
        openTrans.fromFrame = fromView.frame
        openTrans.fromFrameCenter = fromView.center
        secondViewController.transitioningDelegate = openTrans
    }
}

