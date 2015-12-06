//
//  DSPageViewController.swift
//  DSOnboardingFlow
//
//  Created by Daniel Stepanov on 12/4/15.
//  Copyright © 2015 Daniel Stepanov. All rights reserved.
//

import UIKit

class DSPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self
        // this sets the background color of the built-in paging dots
        view.backgroundColor = UIColor.clearColor()
        
        // This is the starting point.  Start with step zero.
        //setViewControllers(DSStepZeroViewController!, direction: .Forward, animated: false, completion: nil)
        setViewControllers([getStepZero()], direction: .Forward , animated: true, completion: nil)

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

    
}

extension DSPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(DSStepTwoViewController) {
            // 2 -> 1
            return getStepOne()
        } else if viewController.isKindOfClass(DSStepOneViewController) {
            // 1 -> 0
            return getStepZero()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(DSStepZeroViewController) {
            // 0 -> 1
            return getStepOne()
        } else if viewController.isKindOfClass(DSStepOneViewController) {
            // 1 -> 2
            return getStepTwo()
        } else {
            // 2 -> end of the road
            return nil
        }
    }
    
    // Enables pagination dots
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    // This only gets called once, when setViewControllers is called
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension DSPageViewController : UIPageViewControllerDelegate {
    
}
