//
//  DonutProgressView.swift
//  circlescore
//
//  Created by Amish Patel on 21/05/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

class DonutProgressView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var creditScoreLabel: UILabel!
    @IBOutlet weak var maxScoreLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    
    var progressLayer = CAShapeLayer()
    
    private let outerLineWidth: CGFloat = 2.0
    private let innerLineWidth: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commenInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commenInit()
    }
    
    func commenInit() {
        Bundle.main.loadNibNamed("DonutProgressView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.borderWidth = outerLineWidth
        self.layer.cornerRadius = self.bounds.size.width/2
        
        let radius = (progressView.frame.height - innerLineWidth)/2.0
        
        let startAngle = -(CGFloat.pi)/2
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: progressView.frame.size.width / 2.0, y: progressView.frame.size.height / 2.0), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressLayer.frame = progressView.bounds
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = innerLineWidth
        progressLayer.strokeEnd = 0.0
        progressLayer.strokeColor = UIColor.red.cgColor
        progressView.layer.addSublayer(progressLayer)
       
    }
    
    func updateScoreAndMaxScore(score: Int, maxScore: Int) {
        let progress = getPercentageForPrgressBar(creditScore: score, maxScore: maxScore)
        setTextForCreditScore(creditScore: score)
        setTextForMaxScore(maxScore: maxScore)
        animateProgressBar(creditScore: score, toProgress: progress)
    }
    
    func setTextForCreditScore(creditScore: Int) {
        creditScoreLabel.text = "\(creditScore)"
    }

    func setTextForMaxScore(maxScore: Int) {
        maxScoreLabel.text = "out of \(maxScore)"
    }
    
    func animateProgressBar(creditScore: Int, toProgress: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = toProgress
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressLayer.add(animation, forKey: "foregroundAnimation")
    }
    
    func getPercentageForPrgressBar(creditScore: Int, maxScore: Int) -> Float {
        return Float(Float(creditScore)/Float(maxScore))
    }
    
}
