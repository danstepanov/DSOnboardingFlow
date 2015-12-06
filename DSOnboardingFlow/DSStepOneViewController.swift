//
//  DSStepOneViewController.swift
//  DSOnboardingFlow
//
//  Created by Daniel Stepanov on 12/4/15.
//  Copyright © 2015 Daniel Stepanov. All rights reserved.
//

import UIKit

class DSStepOneViewController: UIViewController {
    
    lazy var imageView: UIImageView! = {
        let view = UIImageView(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "Smile")
        
        return view
    }()
    
    lazy var bigTextView: UILabel! = {
        let view = UILabel(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Hey Girl"
        view.textColor = UIColor.whiteColor()
        view.textAlignment = .Center
        view.font = UIFont(name: "Helvetica Neue", size: 37.0)
        
        return view
    }()
    
    lazy var smallTextView: UILabel! = {
        let view = UILabel(frame: CGRectZero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "This is a sample sentence. Please replace me with actual text. Thanks Bae."
        view.numberOfLines = 2
        view.textColor = UIColor.whiteColor()
        view.textAlignment = .Center
        view.font = UIFont(name: "Helvetica Neue", size: 15.0)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(imageView)
        self.view.addSubview(bigTextView)
        self.view.addSubview(smallTextView)
        
        self.view.setNeedsUpdateConstraints()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        
        imageViewConstraints()
        bigTextViewConstraints()
        smallTextViewConstraints()
        super.updateViewConstraints()
    }
    
    func imageViewConstraints() {
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: imageView,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Width,
            multiplier: 0.5,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
    }
    
    func bigTextViewConstraints() {
        self.view.addConstraint(NSLayoutConstraint(
            item: bigTextView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: bigTextView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 45))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: bigTextView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: bigTextView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: imageView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 40))
    }
    
    func smallTextViewConstraints() {
        
        self.view.addConstraint(NSLayoutConstraint(
            item: smallTextView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: smallTextView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 60))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: smallTextView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Width,
            multiplier: 0.8,
            constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(
            item: smallTextView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: bigTextView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 10))
    }
}
