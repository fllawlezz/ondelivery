//
//  ProfileLogin.swift
//  YummyV1
//
/*
 Need a login page with signup and login
*/
//  Created by Brandon In on 4/11/18.
//  Copyright © 2018 Rendered Co.RaftPod. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ProfileLogin: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{
    var customTabController: CustomTabBarController?;
    
    var restaurants = [Restaurant]();
    var advertisedRestaurants = [Restaurant]();
    var cards = [PaymentCard]();
    var pastOrders = [PastOrder]();
    var addresses = [UserAddress]()
    var userAddresses = [NSManagedObject]();
    
    var userID: String?
    var email: String?
    var telephone: String?
    var firstName: String?
    var lastName: String?
    var subPlan: String?
    var freeOrders: Int?
    var password: String?
    
    //data variables
    let pageItems = ["Sign Up","Login"];
    let reuseIdentifier = "one";
    let signUpTitles = ["Telephone","Email","First Name","Last Name", "Password"];
    let loginTitles = ["Email","Password"];
    
    var fromStartUpPage = false;
    var onLoginPage = false;
    
    //address variables
    
    var loginBoolean = false;
    
    var locManager: CLLocationManager!
    var placeMark: CLPlacemark!;
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: pageItems);
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tintColor = UIColor.appYellow;
        segmentedControl.addTarget(self, action: #selector(self.switchSegments), for: .valueChanged);
        return segmentedControl;
    }()
    
    lazy var skipButton: UIBarButtonItem = {
        let skipButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(self.skipFunction)); // change action
        return skipButton;
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let cancelButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(self.cancelFunction)); //change action
        return cancelButton;
    }()
    
    lazy var signUpView: SignUpView = {
        let signUpView = SignUpView(mainView: self.view);
        return signUpView;
    }();
    
    //login functions
    lazy var loginView: LoginView = {
        let loginView = LoginView();
        return loginView;
    }()
    
    //MARK: loading indicator
    lazy var darkView: UIView = {
        let darkView = UIView();
        darkView.translatesAutoresizingMaskIntoConstraints = false;
        darkView.backgroundColor = UIColor.black;
        darkView.alpha = 0;
        return darkView;
    }()
    
    lazy var spinner: SpinningView = {
        let spinner = SpinningView();
        spinner.translatesAutoresizingMaskIntoConstraints = false;
        spinner.circleLayer.strokeColor = UIColor.white.cgColor;
        return spinner;
    }()
    
    lazy var loadingTitle: UILabel = {
        let loadingTitle = UILabel();
        loadingTitle.translatesAutoresizingMaskIntoConstraints = false;
        loadingTitle.text = "Loading";
        loadingTitle.font = UIFont(name: "Montserrat-Regular", size: 14)
        loadingTitle.textColor = UIColor.white;
        loadingTitle.textAlignment = .center;
        return loadingTitle;
    }()
    
    //data variables
    var jsonresult: NSDictionary!;
    var signingUp = false;
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isHidden = false;
        self.view.backgroundColor = UIColor.veryLightGray;
        self.navigationItem.titleView = segmentedControl;
        
        if(fromStartUpPage){
            self.navigationItem.rightBarButtonItem = skipButton;
        }else{
            self.navigationItem.leftBarButtonItem = cancelButton;
        }
        
        self.view.addSubview(self.signUpView);
        signUpView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        signUpView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        self.view.addSubview(self.loginView);
        loginView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
//        setupSignUpView();
//        setupLoginView();
        
        setupLoadingView();
        
        if(loginBoolean){
            segmentedControl.selectedSegmentIndex = 1;
//            signUpTotalView.isHidden = true;
            signUpView.isHidden = true;
            loginView.isHidden = false;
        }
    }
    
    func setupLoadingView(){
        self.view.addSubview(darkView);
        darkView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        darkView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        darkView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        darkView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        self.darkView.addSubview(spinner);
        spinner.centerXAnchor.constraint(equalTo: self.darkView.centerXAnchor).isActive = true;
        spinner.centerYAnchor.constraint(equalTo: self.darkView.centerYAnchor).isActive = true;
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.darkView.addSubview(loadingTitle);
        loadingTitle.bottomAnchor.constraint(equalTo: spinner.topAnchor, constant: -10).isActive = true;
        loadingTitle.centerXAnchor.constraint(equalTo: darkView.centerXAnchor).isActive = true;
        loadingTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true;
        loadingTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true;
    }
    
    func sendToServer(telephoneSignUp: String!, emailSignUp: String!, firstNameSignUp: String!, lastNameSignUp: String!, passwordSignUp: String!){
        //send data to server and test for email address
        signingUp = true;
        
        self.locManager = CLLocationManager();
        self.locManager.delegate = self;
        
        let locStatus = CLLocationManager.authorizationStatus();
        if(locStatus == .notDetermined){
            //ask for location
//            print("asking");
            self.locManager.requestAlwaysAuthorization();
        }else if(locStatus == .denied){
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
            self.skipButton.isEnabled = true;
        }else if(locStatus == .authorizedAlways || locStatus == .authorizedWhenInUse){
            let conn = Conn();
            let postString = "email=\(emailSignUp!)&firstName=\(firstNameSignUp!)&lastName=\(lastNameSignUp!)&telephone=\(telephoneSignUp!)&password=\(passwordSignUp!)"
            print(postString);
            conn.connect(fileName: "SignUpPart1.php", postString: postString) { (re) in
                let result = re as String;
                DispatchQueue.main.async {
                    if(result == "found"){
                        //email is taken
                        let alert = UIAlertController(title: "Found That Account", message: "That account has already been registered. Please login instead.", preferredStyle: .alert);
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
                        self.present(alert, animated: true, completion: nil);
                        self.skipButton.isEnabled = true;
                    }else{
                        //                    print(result);
                        self.userID = result;
                        self.firstName = firstNameSignUp!;
                        self.lastName = lastNameSignUp!;
                        self.email = emailSignUp!;
                        self.password = passwordSignUp!;
                        self.telephone = telephoneSignUp!;
                        
                        self.subPlan = "NONE";
                        self.freeOrders = 0;
                        
                        self.spinner.animating = true;
                        self.spinner.updateAnimation();
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.darkView.alpha = 0.7;
                        })
                        
//                        self.telephoneField.textField.resignFirstResponder();
//                        self.emailField.textField.resignFirstResponder();
//                        self.firstNameField.textField.resignFirstResponder();
//                        self.lastNameField.textField.resignFirstResponder();
//                        self.passwordField.textField.resignFirstResponder();
                        
                        defaults.set("wentThroughStartup", forKey: "startup");
                        
                        saveDefaults(defaults: defaults!, firstName: self.firstName!, lastName: self.lastName!, email: self.email!, phoneNumber: self.telephone!, password: self.password!);
                        saveSubscription(defaults: defaults!, subscriptionPlan: self.subPlan!, freeOrders: self.freeOrders!);
//                        populateDefaults(defaults: defaults);
                        
                        self.getLocation();
                    }
                }
            }
        }
    }
    
    @objc private func cancelFunction(){
        self.customTabController?.selectedIndex = 0;
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc private func switchSegments(){
        let selectedIndex = segmentedControl.selectedSegmentIndex;
        if(selectedIndex == 0){
            self.skipButton.isEnabled = true;
//            self.signUpTotalView.isHidden = false;
            self.signUpView.isHidden = false;
            self.loginView.isHidden = true;
        }else if(selectedIndex == 1){
            self.skipButton.isEnabled = false
//            self.signUpTotalView.isHidden = true;
            self.signUpView.isHidden = true;
            self.loginView.isHidden = false;
        }
    }
    
    @objc func skipFunction(){
        spinner.animating = true;
        spinner.updateAnimation();
        UIView.animate(withDuration: 0.3, animations: {
            self.darkView.alpha = 0.7;
        })
        locManager = CLLocationManager();
        locManager.delegate = self;
        
        let locStatus = CLLocationManager.authorizationStatus();
        if(locStatus == .notDetermined){
            //ask for location    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            switch(textField){
//            case self.telephoneField.textField: emailField.textField.becomeFirstResponder();break;
//            case self.emailField.textField: firstNameField.textField.becomeFirstResponder();break;
//            case self.firstNameField.textField: lastNameField.textField.becomeFirstResponder();break;
//            case self.lastNameField.textField: passwordField.textField.becomeFirstResponder();break;
//            case self.loginTelephoneField.textField: loginPasswordField.textField.becomeFirstResponder();break;
//            case self.loginPasswordField.textField: self.loginAttempt();break;
//            case self.passwordField.textField: self.submitFields();break;
//            default: break;
//            }
//            return true;
//
//            locManager.requestAlwaysAuthorization();
        }else if(locStatus == .denied){
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
        }else if(locStatus == .authorizedAlways || locStatus == .authorizedWhenInUse){
            getLocation();
        }else{
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedAlways || status == .authorizedWhenInUse){
            getLocation();
        }else if(status == .denied){
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
        }else if(status == .restricted){
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
        }else if(status == .notDetermined){
            self.locManager.requestAlwaysAuthorization();
        }else{
            let alert = UIAlertController(title: "Need Location Services", message: "We need your location to determine what restaurants are around you. Allow location services to continue", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (result) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.darkView.alpha = 0.0;
                    self.spinner.animating = false;
                    self.spinner.updateAnimation();
                })
            }))
            self.present(alert, animated: true, completion: nil);
        }
    }
}
