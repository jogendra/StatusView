//
//  StatusView.swift
//  StatusView_Example
//
//  Created by JOGENDRA on 05/02/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol StatusViewDelegate: class {
    func didTapStatusView()
}

class StatusView: UIView {

    weak var delegate: StatusViewDelegate?

    lazy var textLabel = UILabel()

    public var statusViewHeight: CGFloat = 28
    public var titleTextColor: UIColor = .white
    public var titleTextFontSize: CGFloat = 12
    public var titleText: String = ""
    public var isVisible: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTapGuestureToStatusView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addTapGuestureToStatusView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapStatusView))
        self.addGestureRecognizer(tapGesture)
    }

    @objc func didTapStatusView() {
        delegate?.didTapStatusView()
    }

    func addLabelWithAnimation() {
        textLabel = UILabel(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIApplication.shared.statusBarFrame.width, height: statusViewHeight))
        self.addSubview(textLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 38).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textLabel.text = titleText
        textLabel.textColor = titleTextColor
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.clear
        textLabel.font = UIFont.systemFont(ofSize: titleTextFontSize)
        addTextLabelAnimations()
    }

    func addTextLabelAnimations() {
        textLabel.addPulseAnimation(from: 0.4, to: 1, duration: 0.8, key: "opacity")
    }

    public func updateStatusView(statusViewColor: UIColor?, text: String?, textColor: UIColor?) {
        self.backgroundColor = statusViewColor
        textLabel.text = text
        textLabel.textColor = textColor ?? titleTextColor
    }

    public func removeTextLabelAnimations() {
        textLabel.layer.removeAllAnimations()
    }

    func setStatusViewFrame() {
        var statusFrame = UIApplication.shared.statusBarFrame
        if isVisible {
            statusFrame.size.height += 32
            addTextLabelAnimations()
        }
        else {
            statusFrame.size.height -= 32
            self.backgroundColor = UIColor.clear
            removeTextLabelAnimations()
        }
    }

}

extension UIView {

    func addPulseAnimation(from fromValue: Any, to toValue: Any, duration: CFTimeInterval, key: String) {
        let pulseAnimation = CABasicAnimation(keyPath: key)
        pulseAnimation.duration = duration
        pulseAnimation.fromValue = fromValue
        pulseAnimation.toValue = toValue
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        layer.add(pulseAnimation, forKey: key)
    }

}
