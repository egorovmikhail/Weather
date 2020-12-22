//
//  LoginFormController.swift
//  Weather
//
//  Created by Михаил Егоров on 15.12.2020.
//

import UIKit
import FirebaseAuth

class LoginFormController: UIViewController {
  
  @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var loginField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  private var handle: AuthStateDidChangeListenerHandle!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.handle = Auth.auth().addStateDidChangeListener { auth, user in
      if user != nil {
        self.performSegue(withIdentifier: "LogIn", sender: nil)
        self.loginField.text = nil
        self.passwordField.text = nil
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    loginField.text = "admin"       // Удалить
//    passwordField.text = "123456"   // Удалить
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWasShown(notification:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillBeHidden(notification:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    switch identifier {
      case "loginSegue":
        let isAuth = login()
        if !isAuth {
          showErrorAlert()
        }
        return isAuth
      default:
        return true
    }
  }
  
  func login() -> Bool {
    let login = loginField.text!
    let password = passwordField.text!
    
    return login == "admin" && password == "123456"
  }
  
  func showErrorAlert() {
    let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
    let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true)
  }
  
  @objc func keyboardWasShown(notification: Notification) {
    let userInfo = (notification as NSNotification).userInfo as! [String: Any]
    let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    
    scrollBottomConstraint.constant = frame.height
  }
  
  @objc func keyboardWillBeHidden(notification: Notification) {
    scrollBottomConstraint.constant = 0
  }
  
  
  //  MARK: - Button
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    // 1
    guard
      let email = loginField.text,
      let password = passwordField.text,
      email.count > 0,
      password.count > 0
    else {
      showAlert(title: "Error", message: "Login/password is not entered")
      return
    }
    // 2
    Auth.auth().signIn(withEmail: email, password: password) {[weak self] user, error in
      if let error = error, user == nil {
        self?.showAlert(title: "Error", message: error.localizedDescription)
      }
    }
    
    
  }
  
  @IBAction func signupButtonPressed(_ sender: UIButton) {
    // 1
    let alert = UIAlertController(title: "Register",
                                  message: "Register",
                                  preferredStyle: .alert)
    // 2
    alert.addTextField { textEmail in
      textEmail.placeholder = "Enter your email"
    }
    alert.addTextField { textPassword in
      textPassword.isSecureTextEntry = true
      textPassword.placeholder = "Enter your password"
    }
    // 3
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel)
    // 4
    let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
      // 4.1
      guard let emailField = alert.textFields?[0],
            let passwordField = alert.textFields?[1],
            let password = passwordField.text,
            let email = emailField.text else { return }
      // 4.2
      Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
        if let error = error {
          self?.showAlert(title: "Error", message: error.localizedDescription)
        } else {
          // 4.3
          Auth.auth().signIn(withEmail: email, password: password)
        }
      }
    }
    // 5
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
  
  func showAlert(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
    alert.addAction(action)
    present(alert, animated: true)
  }
  
}

