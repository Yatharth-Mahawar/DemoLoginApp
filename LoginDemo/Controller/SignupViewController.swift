//
//  SignupViewController.swift
//  LoginDemo
//
//  Created by Yatharth Mahawar on 1/19/21.
//

import UIKit
import FirebaseAuth
import Firebase
import SkyFloatingLabelTextField

class SignupViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var dobTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTxtField: SkyFloatingLabelTextField!
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 30
        signupButton.layer.shadowOpacity = 0.5
        createDatePicker()
        
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
                validate()
    }
    
    
    func Signup(){
        Auth.auth().createUser(withEmail: emailTxtField.text!, password: passwordTxtField.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print(error?.localizedDescription)
                return
            }
            let db = Firestore.firestore()
                .collection("users")
                .document(user.uid)
                .setData(["name":self.nameTxtField.text,"dob":self.dobTxtField.text,"city":self.cityTxtField.text]) { [weak self] err in
                    guard let self = self else { return }
                    if let err = err {
                        print("err ... \(err)")
                        
                    }
                }
            
            self.WelcomeScreen()
             
        }
        
    }
    
    
    
    func WelcomeScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    //MARK:- Date Picker Toolbar
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnPressed))
        toolbar.setItems([doneBtn], animated: true)
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        dobTxtField.inputView = datePicker
        dobTxtField.inputAccessoryView  = createToolbar()
    }
    
    @objc func doneBtnPressed(){
        let dateFormat = DateFormatter()
        //dateFormat.dateStyle = .medium
        dateFormat.dateFormat = "MM/dd/yyyy"
        //dateFormat.timeStyle = .none
        self.dobTxtField.text = dateFormat.string(from: datePicker.date)
        self.view.endEditing(true)
        
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func validate() {
        if emailTxtField.text == "" {
            emailTxtField.errorMessage = "Enter email"
        }
        else if passwordTxtField.text == "" {
            passwordTxtField.text = "Enter Password"
        }
        else if dobTxtField.text == "" {
            dobTxtField.errorMessage = "Enter DOB"
        }
        else if nameTxtField.text == "" {
            nameTxtField.errorMessage = "Enter name"
        }
        else if cityTxtField.text == "" {
            cityTxtField.errorMessage = "Enter city"
        }
        else {
            Signup()
        }
    }
    
    
}
