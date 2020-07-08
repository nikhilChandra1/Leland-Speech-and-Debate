//
//  webPageViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/6/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//

import UIKit
import SafariServices
var number = 0
class webPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if number == 1 {
            performSegue(withIdentifier: "backToTourney", sender: nil)
            number = 0
        }
        let vc = SFSafariViewController(url: URL(string: webpage)!)
        present(vc, animated: true)
        number = 1
        
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
