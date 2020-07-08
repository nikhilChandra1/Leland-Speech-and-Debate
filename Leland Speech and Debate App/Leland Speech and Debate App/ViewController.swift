//
//  ViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/2/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//


    import UIKit
    import DropDown
    import GoogleMobileAds

    class HomeViewController: UIViewController, GADBannerViewDelegate{
        
        var bannerView: GADBannerView!

        @IBAction func Bar(_ sender: Any) {
            didTapTopItem()
        }
        
        func addBannerViewToView(_ bannerView: GADBannerView) {
         bannerView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(bannerView)
         view.addConstraints(
           [NSLayoutConstraint(item: bannerView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: bottomLayoutGuide,
                               attribute: .top,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: bannerView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
           ])
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
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            

            addBannerViewToView(bannerView)
            
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
            bannerView.delegate = self
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
        @objc func didTapTopItem() {
                   menu.show()
               }
        
      
    }
