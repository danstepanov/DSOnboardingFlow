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
    
    var index = 0 {
        didSet {
            print("current index: \(index)")
        }
    }
        
    var viewControllerArray: NSArray = [DSStepZeroViewController(),DSStepOneViewController(),DSStepTwoViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        
        //Edit Page Control
//        let pageControl = UIPageControl.appearance()
//        pageControl.frame = CGRectMake(0, 0, 150, 37)
//        pageControl.pageIndicatorTintColor = UIColor.redColor()
        
        for i in 0..<viewControllerArray.count {
            // because NSArray has reference semantics, we can modify the
            // view controller in-place / we don't need NSMutableArray.
            let vc = viewControllerArray.objectAtIndex(i) as! UIViewController
            vc.view!.tag = i
        }
        
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
        setViewControllers([firstViewController], direction: .Forward , animated: true, completion: nil)
        index = 0 // see `skipButtonTouched` for why this is set here.
        
        self.view.setNeedsUpdateConstraints()
    }
    
    func skipButtonTouched(sender : AnyObject?) {
        // you could probably get rid of this after moving the code that sets
        // the alpha to the `didSet` of the index property (see top of class).
        skipButton.alpha = 0
        
        let lastVC = viewControllerArray.lastObject as! UIViewController
        // we have to set the index ourselves, since we're changing it.
        // The UIPageViewController delegate methods only get called when the user switches pages.
        index = viewControllerArray.count - 1
        setViewControllers([lastVC], direction: .Forward, animated: true, completion: nil)
        
//        if index == 0 {
//            index = index + 2
//            setViewControllers([viewControllerArray.objectAtIndex(index) as! UIViewController], direction: .Forward, animated: true, completion: nil)
//        } else if index == 1 {
//            index = index + 1
//            setViewControllers([viewControllerArray.objectAtIndex(index) as! UIViewController], direction: .Forward, animated: true, completion: nil)
//        }
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
    
//    func getStepZero() -> DSStepZeroViewController {
//        return DSStepZeroViewController() 
//    }
//    
//    func getStepOne() -> DSStepOneViewController {
//        return DSStepOneViewController()
//    }
//    
//    func getStepTwo() -> DSStepTwoViewController {
//        return DSStepTwoViewController()
//    }
    
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
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Right,
            multiplier: 0.95,
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
            multiplier: 0.025,
            constant: 0))
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        // this was called `destinationIndex`, but I did not want to confuse it with the fact that
        // it actually isn't going to be shown on screen (possibly) when this method is called.
        let requestedIndex = viewController.view!.tag + 1
        
        if requestedIndex < 0 || requestedIndex >= viewControllerArray.count {
            return nil
        } else {
            return viewControllerArray.objectAtIndex(requestedIndex) as? UIViewController
        }

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

//        if viewController.isKindOfClass(DSStepZeroViewController) {
//            // 0 -> 1
//            skipButton.alpha = 1
//            return getStepOne()
//        } else if viewController.isKindOfClass(DSStepOneViewController) {
//            // 1 -> 2
//            skipButton.alpha = 1
//            return getStepTwo()
//        } else {
//            skipButton.alpha = 0
//            // 2 -> end of the road
//            return nil
//        }
    }

    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let destinationIndex = viewController.view!.tag - 1
        
        if destinationIndex < 0 || destinationIndex >= viewControllerArray.count {
            return nil
        } else {
            return viewControllerArray.objectAtIndex(destinationIndex) as? UIViewController
        }
        
//        if index == 2 {
//            skipButton.alpha = 1
//            index = index - 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        } else if index == 1 {
//            skipButton.alpha = 1
//            index = index - 1
//            return viewControllerArray.objectAtIndex(index) as? UIViewController
//        } else {
//            return nil
//        }

//        if viewController.isKindOfClass(DSStepTwoViewController) {
//            // 2 -> 1
//            skipButton.alpha = 1
//            return getStepOne()
//        } else if viewController.isKindOfClass(DSStepOneViewController) {
//            // 1 -> 0
//            skipButton.alpha = 1
//            return getStepZero()
//        } else {
//            skipButton.alpha = 1
//            // 0 -> end of the road
//            return nil
//        }
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            index = presentationIndexForPageViewController(pageViewController)
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllerArray.count
    }
    
    // This only gets called _whenever_ setViewControllers is called, sometimes only once in viewDidLoad.
    // Also used by this-own class's `pageViewController(_, didFinishAnimating:_, ...)`
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        // if viewControllers array or the `.first` object is nil, return 0
        return pageViewController.viewControllers?.first?.view!.tag ?? 0
    }
}
