//
//  ViewController.swift
//  eWent
//
//  Created by Shashila Heshan on 6/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    var slides:[Slide] = [];

    @IBOutlet weak var scollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        scollView.delegate = self
        
        slides = GetSliderInfo.createSlides(_vc: self)
        GetSliderInfo.setupSlideScrollView(slides: slides,_vc:self,scollView: scollView)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
       
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        GetSliderInfo.setupScrollView(scrollView: scrollView, pageControl: pageControl, slides: slides, _vc: self)
    }
}

