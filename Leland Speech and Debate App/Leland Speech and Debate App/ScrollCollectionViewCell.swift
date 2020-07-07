//
//  ScrollCollectionViewCell.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/4/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseDatabase
var webpage = " "

class ScrollCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tournamentTitle: UILabel!
    
    var addButtonTapAction : (()->())?
    var createAlert : (()->())?
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var signUpAJudge: UIButton!
    @IBOutlet weak var signUpStudent: UIButton!
    @IBAction func informationB(_ sender: Any) {
        tourney = self.tournamentTitle.text!
        
    }
    
    
    @IBAction func signUpJ(_ sender: Any) {
        
        getInfo(whatInfo: "Judge Sign Up")
    }
    @IBAction func signUpS(_ sender: Any) {
        
        getInfo(whatInfo: "Student Sign Up")
    }
    
    func getInfo(whatInfo: String) {
        print(whatInfo)
        let db = Firestore.firestore()
        let docRef = db.collection("Tournaments").document(self.tournamentTitle.text!)
        
        
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
                if let webpageJudge = dict?[whatInfo] {
                     webpage = String(describing: webpageJudge)
                     self.addButtonTapAction?()
                }
                else {
                    self.createAlert?()
                    print("webpage not found")
                }
                
                
               
            } else {
                print("Document does not exist")
            }
        }
    }
}
