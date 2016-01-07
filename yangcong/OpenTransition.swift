//
//  OpenTransion.swift
//  yangcong
//
//  Created by D_ttang on 16/1/7.
//  Copyright © 2016年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class OpenAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    var fromFrame: CGRect = CGRectZero
    var fromFrameCenter: CGPoint = CGPointZero

    var openTransition = OpenTransition()
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        openTransition.fromFrame = fromFrame
        openTransition.fromFrameCenter = fromFrameCenter
        return openTransition
    }
}

class OpenTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionContext: UIViewControllerContextTransitioning?
    
    var fromFrame: CGRect = CGRectZero
    var fromFrameCenter: CGPoint = CGPointZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        self.transitionContext = transitionContext
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let fromView = fromViewController.view //from view
        let toController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toController.view
        
        containerView!.addSubview(fromView)
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(toView)
        
        
        let buttonFrame = fromViewController.fromView.frame
        let buttonFrameCenter = fromViewController.fromView.center
        
        let endFrame = CGRectMake(buttonFrameCenter.x - CGRectGetHeight(toView.frame) , buttonFrameCenter.y-CGRectGetHeight(fromView.frame), CGRectGetHeight(toView.frame)*2.5, CGRectGetHeight(toView.frame)*2.5)
        
//        print(endFrame)
        
        let maskPath = UIBezierPath(ovalInRect: buttonFrame)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = toView.frame
        maskLayer.path = maskPath.CGPath
        maskLayer.fillColor = UIColor.redColor().CGColor
        toView.layer.mask = maskLayer
        
        let bigCirclePath = UIBezierPath(ovalInRect: endFrame)
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.CGPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = 0.5
        
        maskLayer.path = bigCirclePath.CGPath
        maskLayer.addAnimation(pathAnimation, forKey: "pathAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let transitionContext = self.transitionContext {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
