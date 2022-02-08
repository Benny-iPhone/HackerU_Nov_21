//
//  ToolbarTextField.swift
//  TextFieldProject
//
//  Created by Benny Davidovitz on 08/02/2022.
//

import UIKit

class ToolbarTextField: UITextField {

    //from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupToolbar()
    }
    
    //from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupToolbar()
    }
    
    private func setupToolbar() {
        let screenWidth = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let actionButton = UIBarButtonItem(barButtonSystemItem: self.returnKeyType == .done ? .done : .fastForward,
                                           target: self,
                                           action: #selector(buttonPressed(_:)))
        
        toolbar.items = [spaceButton, actionButton]
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func buttonPressed(_ sender: Any) {
        //mock return key behaviour
        self.sendActions(for: .editingDidEndOnExit)
    }

}
