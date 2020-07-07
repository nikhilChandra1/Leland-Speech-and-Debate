//
//  ViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/2/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//


    import UIKit
    import DropDown

    class HomeViewController: UIViewController{
    
        @IBAction func Bar(_ sender: Any) {
            didTapTopItem()
        }
        
        
        
        let menu: DropDown={
            let menu = DropDown()
            menu.dataSource = [
            "Our Mission",
            "Future Tournaments",
            "Speech Events",
            ]
            return menu
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            let myView = UIView(frame: navigationController?.navigationBar.frame ?? .zero)
            navigationController?.navigationBar.topItem?.titleView = myView
            guard let topView = navigationController?.navigationBar.topItem?.titleView else {
                return
            }
            
            menu.anchorView = topView
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
            gesture.numberOfTapsRequired = 1
            gesture.numberOfTouchesRequired = 1
            topView.addGestureRecognizer(gesture)
            
            menu.selectionAction = {index, title in
                print("index \(index) and \(title)")
                if index==0{
                    self.performSegue(withIdentifier: "OurMission", sender: nil)
                }
                if index==1{
                    self.performSegue(withIdentifier: "TourneyInfo", sender: nil)
                }
                if index==2{
                    self.performSegue(withIdentifier: "SpeechInfo", sender: nil)
                }
                
            }
        }
        
        @objc func didTapTopItem() {
                   menu.show()
               }
        
      
    }
