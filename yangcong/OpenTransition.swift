//
//  OpenTransion.swift
//  yangcong
//
//  Created by D_ttang on 16/1/7.
//  Copyright © 2016年 D_ttang. All rights reserved.
//

import UIKit

class OpenDiaryAnimation: NSObject, UIViewControllerTransitioningDelegate {
    
    let openDiaryTransition = OpenDiaryTransition()
    var tmpOriginFrame: CGRect!
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        openDiaryTransition.originFrame = tmpOriginFrame
        openDiaryTransition.presenting = true
        return openDiaryTransition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        openDiaryTransition.presenting = false
        return openDiaryTransition
    }
}

class OpenDiaryTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.3
    var presenting  = true
    var originFrame = CGRect.zero
    
    var topImageHeight:CGFloat = 0.0
    var dismissCompletion: (()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(1, yScaleFactor)
        
        
        if presenting {
            herbView.alpha = 0.1
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration,
            
            animations: {
                herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
                herbView.alpha = self.presenting ? 1.0 : 0.0
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
    }
}