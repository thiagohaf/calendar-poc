//
//  PopUpWindowView.swift
//  Calendar
//
//  Created by Thiago Henrique Alves Ferreira on 02/04/22.
//

import UIKit

let BorderWidth: CGFloat = 2.0

public class PopUpWindowView: UIView {
    
    
    // Popup Background
    let popupView: UIView = {
        let popupView = UIView()
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.backgroundColor = UIColor.blue
        popupView.layer.borderWidth = BorderWidth
        popupView.layer.masksToBounds = true
        popupView.layer.borderColor = UIColor.white.cgColor
        return popupView
    }()
    
    // Popup Title
    let popupTitle: UILabel =  {
        let popupTitle = UILabel()
        popupTitle.translatesAutoresizingMaskIntoConstraints = false
        popupTitle.textColor = UIColor.blue
        popupTitle.backgroundColor = UIColor.white
        popupTitle.layer.masksToBounds = true
        popupTitle.adjustsFontSizeToFitWidth = true
        popupTitle.clipsToBounds = true
        popupTitle.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupTitle.numberOfLines = 1
        popupTitle.textAlignment = .center
        return popupTitle
    }()
    
    // Popup Text
    let popupText: UILabel = {
        let popupText = UILabel()
        popupText.translatesAutoresizingMaskIntoConstraints = false
        popupText.textColor = UIColor.white
        popupText.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        popupText.numberOfLines = 0
        popupText.textAlignment = .center
        return popupText
    }()
    
    // Popup Button
    let popupButton: UIButton = {
        let popupButton = UIButton()
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        popupButton.setTitleColor(UIColor.blue, for: .normal)
        popupButton.titleLabel?.font = UIFont.systemFont(ofSize: 23.0, weight: .bold)
        popupButton.backgroundColor = UIColor.white
        return popupButton
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        // Semi-transparent background
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopUpWindowView {
    func setupUI() {
        popupView.addSubview(popupTitle)
        popupView.addSubview(popupText)
        popupView.addSubview(popupButton)
        
        // Add the popupView(box) in the PopUpWindowView (semi-transparent background)
        addSubview(popupView)
        
        setupContraints()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            // PopupView constraints
            popupView.widthAnchor.constraint(equalToConstant: 293),
            popupView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            popupView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            popupView.heightAnchor.constraint(equalToConstant: 300),
            
            // PopupTitle constraints
            popupTitle.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupTitle.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupTitle.topAnchor.constraint(equalTo: popupView.topAnchor, constant: BorderWidth),
            popupTitle.heightAnchor.constraint(equalToConstant: 55),
           
            // PopupText constraints
            popupText.heightAnchor.constraint(greaterThanOrEqualToConstant: 67),
            popupText.topAnchor.constraint(equalTo: popupTitle.bottomAnchor, constant: 8),
            popupText.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15),
            popupText.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -15),
            popupText.bottomAnchor.constraint(equalTo: popupButton.topAnchor, constant: -8),
            
            // PopupButton constraints
            popupButton.heightAnchor.constraint(equalToConstant: 44),
            popupButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: BorderWidth),
            popupButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -BorderWidth),
            popupButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -BorderWidth),
        ])
    }
}
