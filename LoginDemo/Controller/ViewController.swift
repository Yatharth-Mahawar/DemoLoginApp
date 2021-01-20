//
//  ViewController.swift
//  LoginDemo
//
//  Created by Yatharth Mahawar on 1/19/21.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginButton.layer.cornerRadius = 30
        loginButton.layer.shadowOpacity = 0.5
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func LoginButton(_ sender: UIButton) {
       validateData()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let SignupViewControllerVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        SignupViewControllerVC.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(SignupViewControllerVC, animated: true)
        
    }
    
    func validateData(){
        if (emailTextField.text?.isEmail)! && (passwordTextField.text!.count >= 6){
            login()
        }
        else {
            emailTextField.errorMessage = "Incorrect Email"
            passwordTextField.errorMessage = "Incorrect Password"
            
            
        }
    
        
    }
    
    
    
    func login() {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else {return}
            if let err = error {
                print(err.localizedDescription)
            }
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let WelcomeViewControllerVC = self?.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
            WelcomeViewControllerVC.modalPresentationStyle = .overFullScreen
            self?.present(WelcomeViewControllerVC, animated: true, completion: nil)
            
            
            
        }
        
    }
}

extension String {
       var isEmail: Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
          let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
       }
   }
