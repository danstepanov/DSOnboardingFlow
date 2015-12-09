//
//  DSPageViewController.swift
//  DSOnboardingFlow
//
//  Created by Daniel Stepanov on 12/4/15.
//  Copyright © 2015 Daniel Stepanov. All rights reserved.
//

import UIKit

class DSPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var header: UILabel! = {
        let view = UILabel(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Sample Header"
        view.textColor = UIColor.whiteColor()
        view.textAlignment = .Center
        view.font = UIFont(name: "Helvetica Neue", size: 30.0)
        
        return view
    }()
    
    lazy var skipButton: UIButton! = {
        let view = UIButton(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Skip", forState: .Normal)
        view.titleLabel?.textColor = UIColor.whiteColor()
        view.titleLabel?.textAlignment = .Center
        view.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20.0)
        view.addTarget(self, action: "skipButtonTouched:", forControlEvents: .TouchDown)
        
        return view
    }()
    
    var index = 0
        
    var viewControllerArray: NSArray = [DSStepZeroViewController(),DSStepOneViewController(),DSStepTwoViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        //Edit Page Control
//        let pageControl = UIPageControl.appearance()
//        pageControl.pageIndicatorTintColor = UIColor.redColor()
        
        // this sets the background color of the built-in paging dots
        view.backgroundColor = UIColor.clearColor()
        
        // Setup Array
        
        let firstViewController: UIViewController = viewControllerArray.objectAtIndex(0) as! UIViewController
        // Add Subviews
        self.view.insertSubview(skipButton, aboveSubview: self.view)
        self.view.insertSubview(header, aboveSubview: self.view)
        UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(skipButton)
        UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(header)
        
        // This is the starting point. Start with step zero.
//        setViewControllers([firstViewController], direction: .Forward , animated: true, completion: nil)
        
        setViewControllers([getStepZero()], direction: .Forward , animated: true, completion: nil)
        
        self.view.setNeedsUpdateConstraints()
    }
    
    func skipButtonTouched(sender : AnyObject?) {
        skipButton.alpha = 0
//        if index == 0 {
//            index = index + 2
//            setViewControllers([viewControllerArray.objectAtIndex(index) as! UIViewController], direction: .Forward, animated: true, completion: nil)
//        } else if index == 1 {
//            index = index + 1
//            setViewControllers([viewControllerArray.objectAtIndex(index) as! UIViewController], direction: .Forward, animated: true, completion: nil)
//        }
        setViewControllers([getStepTwo()], direction: .Forward, animated: true, completion: nil)
        
    }
    
    override func updateViewConstraints() {
        headerConstraints() 
        skipButtonConstraints()
        super.updateViewConstraints()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStepZero() -> DSStepZeroViewController {
        return DSStepZeroViewController() 
    }
    
    func getStepOne() -> DSStepOneViewController {
        return DSStepOneViewController()
    }
    
    func getStepTwo() -> DSStepTwoViewController {
        return DSStepTwoViewController()
    }
    
    func headerConstraints() {
        self.view.addConstraint(NSLayoutConstraint(
            item: header,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: header,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 50))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: header,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: header,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 0.1,
            constant: 0))
    }
    
    func skipButtonConstraints() {
        self.view.addConstraint(NSLayoutConstraint(
            item: skipButton,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: skipButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 50))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: skipButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: skipButton,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: skipButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 0.2,
            constant: 0))
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

//        if index == 0 {
//            skipButton.alpha = 1
//            index = index + 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        } else if index == 1 {
//            skipButton.alpha = 0
//            index = index + 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        } else {
//            return nil
//        }

        if viewController.isKindOfClass(DSStepZeroViewController) {
            // 0 -> 1
            skipButton.alpha = 1
            return getStepOne()
        } else if viewController.isKindOfClass(DSStepOneViewController) {
            // 1 -> 2
            skipButton.alpha = 1
            return getStepTwo()
        } else {
            skipButton.alpha = 0
            // 2 -> end of the road
            return nil
        }
    }

    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
//        if index == 2 {
//            skipButton.alpha = 1
//            index = index - 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        }
//        else if index == 1 {
//            skipButton.alpha = 1
//            index = index - 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        }
//        else {
//            return nil
//        }
        if viewController.isKindOfClass(DSStepTwoViewController) {
            // 2 -> 1
            skipButton.alpha = 1
            return getStepOne()
        } else if viewController.isKindOfClass(DSStepOneViewController) {
            // 1 -> 0
            skipButton.alpha = 1
            return getStepZero()
        } else {
            skipButton.alpha = 1
            // 0 -> end of the road
            return nil
        }
        
    }
    
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return viewControllerArray.count
        return 3
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return index
            return 0
    }
    
}
