//
//  WelcomeViewController.swift
//  LoginDemo
//
//  Created by Yatharth Mahawar on 1/19/21.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doblabel: UILabel!
    @IBOutlet weak var citylabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.layer.cornerRadius = 30
        logoutButton.layer.shadowOpacity = 0.5
        getDocument()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    

    
    private func getDocument() {
         //Get sspecific document from current user
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let docRef = db.collection("users").document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                print("Document data: \(dataDescription)")
                self.nameLabel.text = dataDescription?["name"] as! String
                self.doblabel.text = dataDescription?["dob"] as! String
                self.citylabel.text = dataDescription?["city"] as! String
            } else {
                print("Document does not exist")
            }
        }
    
    
}




}
