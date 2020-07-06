//
//  TournamentInfoViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/4/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseFirestoreSwift
class TournamentInfoViewController: UIViewController {
    
    @IBOutlet var Location: UILabel!
    @IBOutlet var Timings: UILabel!
    @IBOutlet var feesPerEvent: UILabel!
    @IBOutlet var titulo: UILabel!
    
    @IBOutlet var Dates: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
        let docRef = db.collection("Tournaments").document("Saint Francis")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                
                print("Document data: \(dataDescription)")
                
                func convertToDictionary(text: String) -> [String: Any]? {
                    if let data = text.data(using: .utf8) {
                        do {
                            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    return nil
                }
                dataDescription = dataDescription.replacingOccurrences(of: "[", with: "{", options: .literal, range: nil)
                dataDescription = dataDescription.replacingOccurrences(of: "]", with: "}", options: .literal, range: nil)
                print(dataDescription)
                var dict = convertToDictionary(text: dataDescription)
                print(dict)
                if let location = dict?["Location"] {
                    self.Location.text = "Location: " + String(describing: location)
                }
                if let tournamentFees = dict?["Tournament Fees"] {
                    self.feesPerEvent.text = "Fees Per Event: " + String(describing: tournamentFees)
                }
                if let title = dict?["Title"] {
                    self.titulo.text = String(describing: title)
                }
                if let timings = dict?["Timings"] {
                    self.Timings.text = "Timings: " + String(describing: timings)
                }
                if let tournamentDates = dict?["Tournament Dates"] {
                    self.Dates.text = "Tournament Dates: " + String(describing: tournamentDates)
                }
               
            } else {
                print("Document does not exist")
            }
        }
        
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
