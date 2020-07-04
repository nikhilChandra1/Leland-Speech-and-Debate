//
//  TournamentScrollViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/4/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//

import UIKit

var tournament = ""
class TournamentScrollViewController: UIViewController {

    @IBAction func SaintFrancisInvitational(_ sender: Any) {
        tournament = "Saint Francis"
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
