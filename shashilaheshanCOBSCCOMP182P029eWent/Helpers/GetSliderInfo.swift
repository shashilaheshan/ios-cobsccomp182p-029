//
//  GetSliderInfo.swift
//  eWent
//
//  Created by Shashila Heshan on 7/2/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import Foundation
import UIKit

class GetSliderInfo {
    
    static func createSlides(_vc: UIViewController) -> [Slide] {
        var slides :[Slide] = []
        
        SliderData.getSliderData { sData in
            
            guard let sliderData = sData else {return}
            do{
                if let json = try JSONSerialization.jsonObject(with: sliderData, options: []) as?
                    [String: Any] {
                    if let sliders = json["sliders"] as? Array<Dictionary<String,String>> {
                        for slider in sliders {
                            
                            let slided:Slide = Bundle.main.loadNibNamed("Slide", owner: _vc, options: nil)?.first as! Slide
                            slided.imageView.image = UIImage(named: slider["image"] ?? "")
                            slided.txtTitle.text = slider["title"] ?? ""
                            slided.txtDescription.text = slider["description"] ?? ""
                            slided.btnAval = slider["getstart"] == "1" ? true : false
                            
                            slides.append(slided)
                            
                        }
                    }
                    
                }
            }catch let err {
                print(err.localizedDescription)
            }
            
        }
        
        return slides
    }
    
    //Setting scroll view transitions with page Controller
    static func setupScrollView(scrollView : UIScrollView,pageControl: UIPageControl,slides : Array<Slide>,_vc : UIViewController) {
        let pageIndex = round(scrollView.contentOffset.x/_vc.view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
            
            slides[0].imageView.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
            
        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
            
        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].imageView.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
    
        }
        
    }
    //Setup slider Data with Scoll view at _Vc instance
    static func setupSlideScrollView(slides : [Slide],_vc:UIViewController,scollView: UIScrollView) {
        scollView.frame = CGRect(x: 0, y: 0, width: _vc.view.frame.width, height: _vc.view.frame.height)
        scollView.contentSize = CGSize(width: _vc.view.frame.width * CGFloat(slides.count), height: _vc.view.frame.height)
        scollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: _vc.view.frame.width * CGFloat(i), y: 0, width: _vc.view.frame.width, height: _vc.view.frame.height)
            scollView.addSubview(slides[i])
        }
    }

}
