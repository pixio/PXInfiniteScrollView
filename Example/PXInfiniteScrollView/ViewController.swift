//
//  PXSwiftViewController.swift
//  PXImageView
//
//  Created by Dave Heyborne on 2.17.16.
//  Copyright © 2016 Dave Heyborne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var contentView: View {
        return view as! View
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func loadView() {
        super.loadView()
        view = View()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PX Infinite Scroll View"
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        edgesForExtendedLayout = UIRectEdge.None
        
        let faces: [String] = ["andres", "andrew", "ben", "calvin", "daniel", "dillon", "hunsaker", "julie", "jun", "kevin", "lorenzo", "matt", "seth", "spencer", "victor", "william"]
        var faceViews: [UIImageView] = []
        for face in faces {
            let imageView: UIImageView = UIImageView(image: UIImage(named: face))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            faceViews.append(imageView)
        }
        
        let animals: [String] = ["big bird", "bear", "bugs bunny", "cat", "cow", "duck", "giraffe", "gorilla", "jumping lemur", "lemur", "lion", "penguin", "sloth", "wolf", "as it is"]
        var animalViews: [UIImageView] = []
        for animal in animals {
            let imageView: UIImageView = UIImageView(image: UIImage(named: animal))
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            animalViews.append(imageView)
        }
        contentView.faceScrollView.pages = faceViews
        contentView.bodyScrollView.pages = animalViews
    }
}
