//
//  SecondViewController.swift
//  MemoryFun
//
//  Created by Benny Davidovitz on 10/05/2022.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createButton()
    }
    
    private func createButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        button.setTitle("click me", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        
        //view has a strong reference to the button as a subviews memeber
        view.addSubview(button)
        
        self.myButton = button
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
