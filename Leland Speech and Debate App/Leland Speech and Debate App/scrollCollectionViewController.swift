//
//  scrollCollectionViewController.swift
//  Leland Speech and Debate App
//
//  Created by Nikhil Chandra on 7/5/20.
//  Copyright © 2020 Nikhil Chandra. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import VegaScrollFlowLayout

private let reuseIdentifier = "tourneyIdentifier"
var tourney = " "
class scrollCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{
    var tournaments = [String]()
    var filteredTournaments = [String]()
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet var collectionview: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let layout = VegaScrollFlowLayout()
        fetchTourneys()
        filteredTournaments = tournaments
        
        self.collectionview.reloadData()
        SearchBar.delegate = self
        collectionview.collectionViewLayout = layout
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: collectionview.frame.width, height: 367)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionview.delegate = self
        collectionview.dataSource = self
        

        
        //collectionview?.register(UINib(nibName: "ScrollCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        
       
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
    }
    
    
    func fetchTourneys() {
        let db = Firestore.firestore()
        db.collection("Tournaments").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.tournaments.append(document.documentID)
                        print(self.tournaments)
                    }
                    self.filteredTournaments = self.tournaments
                    self.collectionview.reloadData()
                    
                }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.filteredTournaments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ScrollCollectionViewCell
        print(filteredTournaments)
        print(indexPath.row)
        cell.tournamentTitle.text = filteredTournaments[indexPath.row]
        print(cell.tournamentTitle.text)
        print(cell.signUpAJudge)
        print(cell.signUpStudent)
        cell.isHidden = false
        cell.addButtonTapAction = {
            // implement your logic here, e.g. call preformSegue()
            self.performSegue(withIdentifier: "toWebpageIdentifier", sender: self)
        }
        cell.createAlert = {
            
            let alert  = UIAlertController(title: "Not Available Yet", message: "Please check later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
                
            
        }
        
        // Configure the cell
        print(cell)
        
        return cell
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTournaments = []
        if searchText == "" {
            filteredTournaments = tournaments
        } else {
            for tourney in tournaments {
                print(tourney)
                if tourney.lowercased().contains(searchText.lowercased()) {
                    filteredTournaments.append(tourney)
                }
            }
        }
        print("filtered", filteredTournaments)
        self.collectionview.reloadData()
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
