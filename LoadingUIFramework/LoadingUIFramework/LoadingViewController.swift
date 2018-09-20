//
//  LoadingViewController.swift
//  LoadingUIFramework
//
//  Created by Samantha Gatt on 9/19/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

public class LoadingView: UIView, CAAnimationDelegate {
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpShapeLayers()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpShapeLayers()
    }
    
    
    // MARK: - Properties
    
    // Private
    private var shapeLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    var radius: CGFloat {
        return min(bounds.width, bounds.height) / 2.0 - strokeWidth / 2.0
    }
    private var isAnimating: Bool = false
    private var willStopAnimating: Bool = false
    
    // Customizable (outside of initializer)
    var clockwise: Bool = true
    var strokeColor: CGColor = UIColor.gray.cgColor
    var trackColor: CGColor = UIColor.lightGray.cgColor
    var strokeWidth: CGFloat = 10.0
    var duration: CFTimeInterval = 1
    
    
    // MARK: - Functions
    
    // User accessible
    public func animate() {
        guard !isAnimating else { return }
        defer { isAnimating = true }
        
        startAnimation()
    }
    
    public func endAnimation() {
        guard isAnimating else { return }
        
        willStopAnimating = true
    }
    
    // Private
    private func setUpShapeLayers() {
        let circle = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: clockwise)
        
        shapeLayer.path = circle.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = strokeWidth
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        
        trackLayer.path = circle.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor
        trackLayer.lineWidth = strokeWidth
    }
    
    private func startAnimation(for keyPath: String) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        shapeLayer.add(animation, forKey: keyPath)
    }
    
    private func startAnimation() {
        willStopAnimating = false
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.0
        startAnimation(for: "strokeEnd")
    }
    
    
    // MARK: - CAAnimationDelegate
    
    private func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard !willStopAnimating else {
            willStopAnimating = false
            isAnimating = false
            return
        }
        
        if let anim = anim as? CABasicAnimation, anim.keyPath == "strokeEnd" {
            shapeLayer.strokeStart = 0.0
            shapeLayer.strokeEnd = 1.0
            shapeLayer.removeAllAnimations()
            startAnimation(for: "strokeStart")
        }
        
        if let anim = anim as? CABasicAnimation, anim.keyPath == "strokeStart" {
            shapeLayer.strokeStart = 0.0
            shapeLayer.strokeEnd = 0.0
            shapeLayer.removeAllAnimations()
            startAnimation(for: "strokeEnd")
        }
    }
}
