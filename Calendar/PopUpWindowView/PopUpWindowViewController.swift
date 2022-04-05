//
//  PopUpWindowViewController.swift
//  Calendar
//
//  Created by Thiago Henrique Alves Ferreira on 02/04/22.
//

import UIKit

class PopUpWindowViewcontroller: UIViewController {

    private let popUpWindowView = PopUpWindowView()
    
    init(title: String, text: String, buttontext: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        
        popUpWindowView.popupTitle.text = title
        popUpWindowView.popupText.text = text
        popUpWindowView.popupButton.setTitle(buttontext, for: .normal)

        popUpWindowView.popupButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        view = popUpWindowView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
