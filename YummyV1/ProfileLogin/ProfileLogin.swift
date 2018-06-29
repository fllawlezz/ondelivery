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
    var addressArray = [String]();
    var cityArray = [String]();
    var zipcodeArray = [String]();
    var stateArray = [String]();
    var idArray = [String]();
    var mainAddressArray = [String]();
    
    //orders variables
    var restaurantNameArray = [String]();
    var totalSumsArray = [Double]();
    var orderIDArray = [String]();
    var datesArray = [String]();
    var restIDArray = [String]();
    var restURLArray = [String]();
    
    var foodNameArray = [[String]]();
    var foodPriceArray = [[String]]();
    var foodQuantityArray = [[String]]();
    var foodIDArray = [[String]]();
    var foodPicArray = [NSData]();
    
    //Cards
//    var address: [UserAddress]?
//    var cards: [PaymentCard]?
    
    var nickNameArray = [String]();
    var cardArray = [String]();
    var expirationArray = [String]();
    var cvcArray = [String]();
    var mainArray = [String]();
    var cardIDArray = [String]();
    
    var loginBoolean = false;
    
    var locManager: CLLocationManager!
    var placeMark: CLPlacemark!;
    
    //DATA Elements
    var restaurantTitles = [String]();
    var restaurantIDs = [String]();
    var restaurantAddresses = [String]();
    var restaurantTelephones = [String]();
    var restaurantOpenHours = [String]();
    var restaurantCloseHours = [String]();
    var restaurantDistances = [Double]();
    var restaurantPicURLs = [String]();//the URLS
    var restaurantPics = [UIImage]();
    var restaurantsAdvertised = [String]();
    var restaurantAdvertismentURLs = [String]();
    var restaurantAdvertismentPics = [UIImage]();
    
    private let termsLink = "https://ondeliveryinc.com/terms.html";
    private let privacyLink = "https://ondeliveryinc.com/privacy.html";
    
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
    
    lazy var termsAndConditions: UITextView = {
        let termsAndConditions = UITextView();
        termsAndConditions.translatesAutoresizingMaskIntoConstraints = false;
        termsAndConditions.textAlignment = .center;
        termsAndConditions.isEditable = false;
        termsAndConditions.isScrollEnabled = false;
        termsAndConditions.textColor = UIColor.gray;
        termsAndConditions.backgroundColor = UIColor.veryLightGray;
        termsAndConditions.font = UIFont.systemFont(ofSize: 12);
        termsAndConditions.text = "Hello World this is your manager speaking"
        return termsAndConditions;
    }()
    
    lazy var signUpTotalView: UIView = {
        let signUpTotalView = UIView();
        signUpTotalView.translatesAutoresizingMaskIntoConstraints = false;
        signUpTotalView.backgroundColor = UIColor.veryLightGray;
        return signUpTotalView;
    }()
    
    lazy var signUpTableView: UIView = {
        let signUpTableView = UIView();
        signUpTableView.translatesAutoresizingMaskIntoConstraints = false;
        signUpTableView.backgroundColor = UIColor.white;
        return signUpTableView;
    }()
    
    lazy var telephoneField: ProfileLoginSignUpCell = {
        let telephoneField = ProfileLoginSignUpCell();
        telephoneField.translatesAutoresizingMaskIntoConstraints = false;
        telephoneField.setTitle(titleString: "Telephone");
        telephoneField.layer.borderWidth = 0.3;
        telephoneField.layer.borderColor = UIColor.veryLightGray.cgColor;
        telephoneField.textField.delegate = self;
        telephoneField.textField.keyboardType = .phonePad;
        telephoneField.textField.addTarget(self, action: #selector(self.textDidChange(sender:)), for: .editingChanged);
        return telephoneField;
    }()
    
    lazy var emailField: ProfileLoginSignUpCell = {
        let emailField = ProfileLoginSignUpCell();
        emailField.translatesAutoresizingMaskIntoConstraints = false;
        emailField.setTitle(titleString: "Email");
        emailField.layer.borderWidth = 0.3;
        emailField.layer.borderColor = UIColor.veryLightGray.cgColor;
        emailField.textField.delegate = self;
        emailField.textField.keyboardType = .emailAddress;
        return emailField;
    }()
    
    lazy var firstNameField: ProfileLoginSignUpCell = {
        let firstNameField = ProfileLoginSignUpCell();
        firstNameField.translatesAutoresizingMaskIntoConstraints = false;
        firstNameField.setTitle(titleString: "First Name");
        firstNameField.layer.borderWidth = 0.3;
        firstNameField.layer.borderColor = UIColor.veryLightGray.cgColor;
        firstNameField.textField.delegate = self;
        return firstNameField;
    }()
    
    lazy var lastNameField: ProfileLoginSignUpCell = {
        let lastNameField = ProfileLoginSignUpCell();
        lastNameField.translatesAutoresizingMaskIntoConstraints = false;
        lastNameField.setTitle(titleString: "Last Name");
        lastNameField.layer.borderWidth = 0.3;
        lastNameField.layer.borderColor = UIColor.veryLightGray.cgColor;
        lastNameField.textField.delegate = self;
        return lastNameField;
    }()
    
    lazy var passwordField: ProfileLoginSignUpCell = {
        let passwordField = ProfileLoginSignUpCell();
        passwordField.translatesAutoresizingMaskIntoConstraints = false;
        passwordField.setTitle(titleString: "Password");
        passwordField.layer.borderWidth = 0.25;
        passwordField.layer.borderColor = UIColor.veryLightGray.cgColor;
        passwordField.textField.delegate = self;
        passwordField.textField.isSecureTextEntry = true;
        passwordField.textField.returnKeyType = .go;
        passwordField.textField.placeholder = "At least 7 characters";
        return passwordField;
    }()
    
    lazy var signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system);
        signUpButton.translatesAutoresizingMaskIntoConstraints = false;
        signUpButton.setTitle("Sign Up", for: .normal);
        signUpButton.setTitleColor(UIColor.black, for: .normal);
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        signUpButton.backgroundColor = UIColor.appYellow;
        signUpButton.layer.cornerRadius = 3;
        signUpButton.layer.borderColor = UIColor.gray.cgColor;
        signUpButton.addTarget(self, action: #selector(submitFields), for: .touchUpInside);
        return signUpButton;
    }()
    
    //login functions
    lazy var loginTotalView: UIView = {
        let loginTotalView = UIView();
        loginTotalView.translatesAutoresizingMaskIntoConstraints = false;
        loginTotalView.backgroundColor = UIColor.veryLightGray;
        return loginTotalView;
    }()
    
    lazy var loginTableView: UIView = {
        let loginTableView = UIView();
        loginTableView.translatesAutoresizingMaskIntoConstraints = false;
        loginTableView.backgroundColor = UIColor.white;
        return loginTableView;
    }()
    
    lazy var loginTelephoneField: ProfileLoginSignUpCell = {
        let loginTelephoneField = ProfileLoginSignUpCell();
        loginTelephoneField.translatesAutoresizingMaskIntoConstraints = false;
        loginTelephoneField.setTitle(titleString: "Telephone");
        loginTelephoneField.layer.borderWidth = 0.25;
        loginTelephoneField.layer.borderColor = UIColor.veryLightGray.cgColor;
        loginTelephoneField.textField.delegate = self;
        loginTelephoneField.textField.keyboardType = .numberPad;
        loginTelephoneField.textField.returnKeyType = .next;
        loginTelephoneField.textField.placeholder = "Telephone";
        loginTelephoneField.textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return loginTelephoneField;
    }()
    
    lazy var loginPasswordField: ProfileLoginSignUpCell = {
        let loginPasswordField = ProfileLoginSignUpCell();
        loginPasswordField.translatesAutoresizingMaskIntoConstraints = false;
        loginPasswordField.setTitle(titleString: "Password");
        loginPasswordField.layer.borderWidth = 0.25;
        loginPasswordField.layer.borderColor = UIColor.veryLightGray.cgColor;
        loginPasswordField.textField.delegate = self;
        loginPasswordField.textField.isSecureTextEntry = true;
        loginPasswordField.textField.returnKeyType = .go;
        loginPasswordField.textField.placeholder = "Password";
        return loginPasswordField;
    }()
    
    lazy var forgotPassword: UIButton = {
        let forgotPassword = UIButton(type: .system);
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false;
        forgotPassword.setTitle("Forgot Password", for: .normal);
        forgotPassword.setTitleColor(UIColor.blue, for: .normal);
        forgotPassword.titleLabel?.font = UIFont(name: "Montserrat-Italic", size: 12)
        forgotPassword.addTarget(self, action: #selector(self.forgotPasswordFunction), for: .touchUpInside);
        return forgotPassword;
    }()
    
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system);
        loginButton.translatesAutoresizingMaskIntoConstraints = false;
        loginButton.setTitle("Login", for: .normal);
        loginButton.setTitleColor(UIColor.black, for: .normal);
        loginButton.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16);
        loginButton.backgroundColor = UIColor.appYellow;
        loginButton.layer.cornerRadius = 3;
        loginButton.layer.borderColor = UIColor.gray.cgColor;
        loginButton.addTarget(self, action: #selector(loginAttempt), for: .touchUpInside);
        return loginButton;
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
        
        setupSignUpView();
        setupLoginView();
        
        let originalText = "By completing the form, you are agreeing to our Terms Of Service and Privacy Policy";
        let attributedOriginalText = NSMutableAttributedString(string: originalText);
        let centerAlignment = NSMutableParagraphStyle();
        centerAlignment.alignment = .center;
        let termsLinkRange = attributedOriginalText.mutableString.range(of: "Terms Of Service");
        let privacyLinkRange = attributedOriginalText.mutableString.range(of: "Privacy Policy");
        attributedOriginalText.addAttribute(.link, value: termsLink, range: termsLinkRange);
        attributedOriginalText.addAttribute(.link, value: privacyLink, range: privacyLinkRange);
        attributedOriginalText.addAttribute(.paragraphStyle, value: centerAlignment, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedOriginalText.length));
        attributedOriginalText.addAttribute(.font, value: UIFont(name: "Montserrat-Regular", size: 11)!, range: NSMakeRange(0, attributedOriginalText.length));
        
        self.termsAndConditions.attributedText = attributedOriginalText;
        self.termsAndConditions.linkTextAttributes = [NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        
        setupLoadingView();
        
        if(loginBoolean){
            segmentedControl.selectedSegmentIndex = 1;
            signUpTotalView.isHidden = true;
            loginTotalView.isHidden = false;
        }
    }
    
    private func setupSignUpView(){
        self.view.addSubview(signUpTotalView);
        signUpTotalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpTotalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpTotalView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        signUpTotalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        self.signUpTotalView.addSubview(signUpTableView);
        signUpTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        signUpTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        signUpTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true;
        signUpTableView.heightAnchor.constraint(equalToConstant: 225).isActive = true;
        
        self.signUpTableView.addSubview(telephoneField);
        self.signUpTableView.addSubview(emailField);
        self.signUpTableView.addSubview(firstNameField);
        self.signUpTableView.addSubview(lastNameField);
        self.signUpTableView.addSubview(passwordField);
        
        telephoneField.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        telephoneField.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        telephoneField.topAnchor.constraint(equalTo: self.signUpTableView.topAnchor).isActive = true;
        telephoneField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        emailField.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        emailField.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        emailField.topAnchor.constraint(equalTo: self.telephoneField.bottomAnchor).isActive = true;
        emailField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        firstNameField.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        firstNameField.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        firstNameField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor).isActive = true;
        firstNameField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        lastNameField.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        lastNameField.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        lastNameField.topAnchor.constraint(equalTo: self.firstNameField.bottomAnchor).isActive = true;
        lastNameField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        passwordField.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        passwordField.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        passwordField.topAnchor.constraint(equalTo: self.lastNameField.bottomAnchor).isActive = true;
        passwordField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        self.signUpTotalView.addSubview(termsAndConditions);
        termsAndConditions.leftAnchor.constraint(equalTo: self.signUpTableView.leftAnchor).isActive = true;
        termsAndConditions.rightAnchor.constraint(equalTo: self.signUpTableView.rightAnchor).isActive = true;
        termsAndConditions.topAnchor.constraint(equalTo: self.signUpTableView.bottomAnchor, constant: 10).isActive = true;
        termsAndConditions.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        self.signUpTotalView.addSubview(signUpButton);
        signUpButton.leftAnchor.constraint(equalTo: self.signUpTotalView.leftAnchor, constant: 25).isActive = true;
        signUpButton.rightAnchor.constraint(equalTo: self.signUpTotalView.rightAnchor, constant: -25).isActive = true;
        signUpButton.topAnchor.constraint(equalTo: self.termsAndConditions.bottomAnchor, constant: 10).isActive = true;
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
    }
    
    private func setupLoginView(){
        self.view.addSubview(loginTotalView);
        loginTotalView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginTotalView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginTotalView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true;
        loginTotalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true;
        
        self.loginTotalView.addSubview(loginTableView);
        loginTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true;
        loginTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true;
        loginTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true;
        loginTableView.heightAnchor.constraint(equalToConstant: 90).isActive = true;
        
        self.loginTableView.addSubview(loginTelephoneField);
        self.loginTableView.addSubview(loginPasswordField);
        
        loginTelephoneField.leftAnchor.constraint(equalTo: self.loginTableView.leftAnchor).isActive = true;
        loginTelephoneField.rightAnchor.constraint(equalTo: self.loginTableView.rightAnchor).isActive = true;
        loginTelephoneField.topAnchor.constraint(equalTo: self.loginTableView.topAnchor).isActive = true;
        loginTelephoneField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        loginPasswordField.leftAnchor.constraint(equalTo: self.loginTableView.leftAnchor).isActive = true;
        loginPasswordField.rightAnchor.constraint(equalTo: self.loginTableView.rightAnchor).isActive = true;
        loginPasswordField.topAnchor.constraint(equalTo: self.loginTelephoneField.bottomAnchor).isActive = true;
        loginPasswordField.heightAnchor.constraint(equalToConstant: 45).isActive = true;
        
        self.loginTotalView.addSubview(forgotPassword);
        forgotPassword.leftAnchor.constraint(equalTo: self.loginTotalView.leftAnchor).isActive = true;
        forgotPassword.rightAnchor.constraint(equalTo: self.loginTotalView.rightAnchor).isActive = true;
        forgotPassword.heightAnchor.constraint(equalToConstant: 25).isActive = true;
        forgotPassword.topAnchor.constraint(equalTo: self.loginPasswordField.bottomAnchor, constant: 10).isActive = true;
        
        self.loginTotalView.addSubview(loginButton);
        loginButton.leftAnchor.constraint(equalTo: self.loginTotalView.leftAnchor, constant: 25).isActive = true;
        loginButton.rightAnchor.constraint(equalTo: self.loginTotalView.rightAnchor, constant: -25).isActive = true;
        loginButton.topAnchor.constraint(equalTo: self.forgotPassword.bottomAnchor, constant: 10).isActive = true;
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        
        loginTotalView.isHidden = true;
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.telephoneField.textField.resignFirstResponder();
        self.emailField.textField.resignFirstResponder();
        self.firstNameField.textField.resignFirstResponder();
        self.lastNameField.textField.resignFirstResponder();
        self.passwordField.textField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField){
        case self.telephoneField.textField: emailField.textField.becomeFirstResponder();break;
        case self.emailField.textField: firstNameField.textField.becomeFirstResponder();break;
        case self.firstNameField.textField: lastNameField.textField.becomeFirstResponder();break;
        case self.lastNameField.textField: passwordField.textField.becomeFirstResponder();break;
        case self.loginTelephoneField.textField: loginPasswordField.textField.becomeFirstResponder();break;
        case self.loginPasswordField.textField: self.loginAttempt();break;
        case self.passwordField.textField: self.submitFields();break;
        default: break;
        }
        return true;
    }
    
    @objc func submitFields(){
        let telephoneTextField = self.telephoneField.textField;
        let emailTextField = self.emailField.textField;
        let firstNameTextField = self.firstNameField.textField;
        let lastnameTextField = self.lastNameField.textField;
        let passwordTextField = self.passwordField.textField;
        
        self.skipButton.isEnabled = false;
//        print(telephoneTextField.text);
        
        if(telephoneTextField.text!.count < 10 || emailTextField.text!.count < 4 || firstNameTextField.text!.count < 1 || lastnameTextField.text!.count < 1 || passwordTextField.text!.count < 7){
            //show error message
            let alert = UIAlertController(title: "Fill Out all Fields", message: "Fill Out All fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
            self.skipButton.isEnabled = true;
        }else{
            //send to server
            sendToServer(telephoneSignUp: telephoneTextField.text!, emailSignUp: emailTextField.text!, firstNameSignUp: firstNameTextField.text!, lastNameSignUp: lastnameTextField.text!, passwordSignUp: passwordTextField.text!);
        }
        
    }
    
    private func sendToServer(telephoneSignUp: String!, emailSignUp: String!, firstNameSignUp: String!, lastNameSignUp: String!, passwordSignUp: String!){
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
                        
                        self.telephoneField.textField.resignFirstResponder();
                        self.emailField.textField.resignFirstResponder();
                        self.firstNameField.textField.resignFirstResponder();
                        self.lastNameField.textField.resignFirstResponder();
                        self.passwordField.textField.resignFirstResponder();
                        
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
    
    @objc func loginAttempt(){
        if(self.loginTelephoneField.textField.text!.count < 5 || self.loginPasswordField.textField.text!.count < 7){
            let alert = UIAlertController(title: "Fill Out all Fields", message: "Fill Out All fields", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        }else{
            //send to server and get result... if result is true, then dismiss and set selectedIndex = 4;
            self.loginTelephoneField.textField.resignFirstResponder();
            self.loginPasswordField.textField.resignFirstResponder();
            spinner.animating = true;
            spinner.updateAnimation();
            UIView.animate(withDuration: 0.3, animations: {
                self.darkView.alpha = 0.7;
            })
            checkPassword();
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
            self.signUpTotalView.isHidden = false;
            self.loginTotalView.isHidden = true;
        }else if(selectedIndex == 1){
            self.skipButton.isEnabled = false
            self.signUpTotalView.isHidden = true;
            self.loginTotalView.isHidden = false;
        }
    }
    
    @objc private func textDidChange(sender: TextFieldPadded){
        //get the text from numberField, analyze, and check the text
        if(sender == self.loginTelephoneField.textField){
            var numberString = self.loginTelephoneField.textField.text!;
            var num = 0;
            
            //remove characters
            numberString = numberString.replacingOccurrences(of: "(", with: "");
            numberString = numberString.replacingOccurrences(of: ")", with: "");
            numberString = numberString.replacingOccurrences(of: "-", with: "");
            
            for _ in numberString{
                num+=1;
            }
            if(num > 10){
                numberString.remove(at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            
            if(num>3){
                numberString.insert("(", at: numberString.startIndex);
                numberString.insert(")", at: numberString.index(numberString.startIndex, offsetBy: 4));
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 5));
            }
            if(num>6){
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            self.loginTelephoneField.textField.text = numberString;
        }else if(sender == self.telephoneField.textField){
            var numberString = self.telephoneField.textField.text!;
            var num = 0;
            
            //remove characters
            numberString = numberString.replacingOccurrences(of: "(", with: "");
            numberString = numberString.replacingOccurrences(of: ")", with: "");
            numberString = numberString.replacingOccurrences(of: "-", with: "");
            
            for _ in numberString{
                num+=1;
            }
            if(num > 10){
                numberString.remove(at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            
            if(num>3){
                numberString.insert("(", at: numberString.startIndex);
                numberString.insert(")", at: numberString.index(numberString.startIndex, offsetBy: 4));
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 5));
            }
            if(num>6){
                numberString.insert("-", at: numberString.index(numberString.startIndex, offsetBy: 9));
            }
            self.telephoneField.textField.text = numberString;
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
            //ask for location
            locManager.requestAlwaysAuthorization();
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
    
    @objc func forgotPasswordFunction(){
        let forgotPasswordPage = LoginForgot();
        self.navigationController?.pushViewController(forgotPasswordPage, animated: true);
    }
}
