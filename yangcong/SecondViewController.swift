//
//  SecondViewController.swift
//  yangcong
//
//  Created by D_ttang on 16/1/7.
//  Copyright © 2016年 D_ttang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var center: NSLayoutConstraint!
    

//    var center: NSLayoutConstraint?
    
    let endY: CGFloat = 40.0
    var endX: CGFloat = 0.0
    
    var fromTop: CGFloat = 0.0
    var fromLeft: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        top.constant = fromTop - closeBtn.frame.size.width / 2
        center.constant = fromLeft
        self.view.layoutIfNeeded()
        
        endX = (view.frame.width - closeBtn.frame.width) / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        top.constant = endY
        center.constant = 0
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Close this view
    @IBAction func closeAction(sender: AnyObject) {
        dismissViewControllerAnimated(true) { _ in
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
