//
//  DemoView.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class View: UIView {
    private var _constraints: [NSLayoutConstraint]
    
    let faceScrollView: PXInfiniteScrollView
    let bodyScrollView: PXInfiniteScrollView
    
    override init(frame: CGRect) {
        _constraints = []
        faceScrollView = PXInfiniteScrollView()
        bodyScrollView = PXInfiniteScrollView()
        super.init(frame: frame)
        
        faceScrollView.translatesAutoresizingMaskIntoConstraints = false
        faceScrollView.scrollDirection = PXInfiniteScrollViewDirection.Horizontal
        
        bodyScrollView.translatesAutoresizingMaskIntoConstraints = false
        bodyScrollView.scrollDirection = PXInfiniteScrollViewDirection.Horizontal
        
        addSubview(bodyScrollView)
        addSubview(faceScrollView)
        
        setNeedsUpdateConstraints()
    }
    
    // NOT IMPLEMENTED
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        removeConstraints(_constraints)
        
        let views: [String : UIView] = ["faceScrollView" : faceScrollView, "bodyScrollView" : bodyScrollView]
        let metrics: [String : Int] = ["spacing" : Int(bounds.height * 0.315), "faceHeight" : 78]
        
        _constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bodyScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        _constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|-spacing-[faceScrollView(faceHeight)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        _constraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[bodyScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views))
        
        _constraints.append(NSLayoutConstraint(item: faceScrollView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: faceScrollView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0))
        
        _constraints.append(NSLayoutConstraint(item: faceScrollView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.055, constant: 0.0))
        
        addConstraints(_constraints)
        super.updateConstraints()
    }
}
