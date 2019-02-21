//
//  AddCustomShortcutView.swift
//  SampleApp
//
//  Created by Tara Singh M C on 20/02/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

protocol AddCustomShortcutViewDelegate: class {
    func dismiss(view: AddCustomShortcutView)
}
class AddCustomShortcutView: UIView {

    var shouldSetupConstraints = true
    var bottomConstraint: NSLayoutConstraint?

    weak var delegate: AddCustomShortcutViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let closeButton = UIButton(frame: .zero)
        closeButton.backgroundColor = .red
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
        self.addSubview(closeButton)
        
        let conTop = closeButton.topAnchor.constraint(equalTo: self.topAnchor , constant: 12)
        let conTrailing = self.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 12)
        let conWidth = closeButton.widthAnchor.constraint(equalToConstant: 40)
        let conHeight = closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor )
        NSLayoutConstraint.activate([conTop, conTrailing, conWidth, conHeight])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            // AutoLayout constraints
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    
    @objc func closeButtonPressed(_ sender: Any) {
        delegate?.dismiss(view: self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
}
