//
//  KKAnimateViewController.swift
//  Swift_Demo
//
//  Created by sumian on 2019/2/18.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit

class KKAnimateViewController: NSObject,UIViewControllerAnimatedTransitioning {
    
    var operation: UINavigationControllerOperation = UINavigationControllerOperation.none
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.26
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        let fromViewStartFame = transitionContext.initialFrame(for: fromViewController)
        var fromViewEndFrame = fromViewStartFame
        let toViewEndFrame = transitionContext.finalFrame(for: toViewController)
        var toViewStartFrame = toViewEndFrame
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        if operation == .push {
            toViewStartFrame.origin.x = toViewEndFrame.size.width
        }
        else{
            fromViewEndFrame.origin.x = fromViewStartFame.size.width
            containerView.sendSubview(toBack: toView)
        }
        
        fromView?.frame = fromViewStartFame
        toView.frame = toViewStartFrame

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
            fromView?.frame = fromViewEndFrame
            toView.frame = toViewEndFrame
        }) { (status) in
            transitionContext.completeTransition(true)
        }
    }
}
