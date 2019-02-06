//
//  StatusView.swift
//  StatusView_Example
//
//  Created by JOGENDRA on 06/02/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol StatusViewDelegate: class {
    func didTapStatusBarView()
}

class StatusView: UIViewController {

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var rootVCView: UIView!
    @IBOutlet weak var statusViewHeightConstraint: NSLayoutConstraint!

    var rootVC: UIViewController!
    lazy var textLabel = UILabel()
    weak var delegate: StatusViewDelegate?

    var isVisible: Bool = true

    init(isVisible: Bool, rootVC: UIViewController) {
        super.init(nibName: "StatusView", bundle: nil)

        self.rootVC = rootVC
        self.isVisible = isVisible
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpInputViews()
    }

    func addTapGuestureToStatusBarView() {
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapStatusBarView))
        statusBarView.addGestureRecognizer(tapGuesture)
    }

    @objc func didTapStatusBarView() {
        delegate?.didTapStatusBarView()
    }

    func setUpInputViews() {
        rootVCView.addSubview(rootVC.view)
        rootVC.view.translatesAutoresizingMaskIntoConstraints = false
        rootVC.view.topAnchor.constraint(equalTo: rootVCView.topAnchor).isActive = true
        rootVC.view.leadingAnchor.constraint(equalTo: rootVCView.leadingAnchor).isActive = true
        rootVC.view.bottomAnchor.constraint(equalTo: rootVCView.bottomAnchor).isActive = true
        rootVC.view.trailingAnchor.constraint(equalTo: rootVCView.trailingAnchor).isActive = true

        setNotificationViewFrame()
        addLabelWithAnimation()
        addTapGuestureToStatusBarView()
    }

    func addLabelWithAnimation() {
        textLabel = UILabel(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height , width: UIApplication.shared.statusBarFrame.width, height: 28))
        statusBarView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: statusBarView.topAnchor, constant: 38).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: statusBarView.leadingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: statusBarView.bottomAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: statusBarView.trailingAnchor).isActive = true
        textLabel.text = "Hey there!"
        textLabel.textColor = UIColor.white
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.clear
        textLabel.font = UIFont.systemFont(ofSize: 12)
        addTextLabelAnimations()
    }

    func setNotificationViewFrame() {
        var notificationFrame = UIApplication.shared.statusBarFrame
        if isVisible {
            notificationFrame.size.height += 32
            statusViewHeightConstraint.constant = 62
            addTextLabelAnimations()
        }
        else {
            notificationFrame.size.height -= 32
            statusViewHeightConstraint.constant = 0
            statusBarView.backgroundColor = UIColor.clear
            removeTextLabelAnimations()
        }
    }

    func setRootVCFrame() {
        if isVisible {
            var frame = self.view.frame
            frame.size.height -= (UIApplication.shared.statusBarFrame.height + 32)
            frame.origin.y += (UIApplication.shared.statusBarFrame.height + 32)
            rootVC.view.frame = frame
        }
        else {
            rootVC.view.frame = self.view.frame
        }
    }

    func addTextLabelAnimations() {
        textLabel.addPulseAnimation(from: 0.4, to: 1, duration: 0.8, key: "opacity")
    }

    func removeTextLabelAnimations() {
        textLabel.layer.removeAllAnimations()
    }

    func topViewController() -> UIViewController? {
        return self.rootVC
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
