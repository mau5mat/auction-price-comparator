//
//  FormViewController.swift
//  AuctioneerCalculator
//
//  Created by Matt Roberts on 24/09/2018.
//  Copyright © 2018 Matt Roberts. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
  
  private var localePicker = UIPickerView()
  private var realmPicker = UIPickerView()
  private var webRequest = WebRequestService()
  
  @IBOutlet weak var formTitleText: UILabel!
  @IBOutlet weak var localeButton: UIButton!
  @IBOutlet weak var localeTextField: UITextField!
  @IBOutlet weak var realmButton: UIButton!
  @IBOutlet weak var realmTextField: UITextField!
  @IBOutlet weak var saveSettings: UIButton!
  
  private var selectedRealm: Realm?
  private var selectedLocale: Locale?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPickerView()
    self.realmTextField.delegate = self
    self.localeTextField.delegate = self
    
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == self.localeTextField {
      self.realmTextField.resignFirstResponder()
    } else {
      self.localeTextField.resignFirstResponder()
    }
    return true
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == localePicker {
      return Locale.allLocales.count
    }
    return Realm.allRealms.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == localePicker {
      return Locale.allLocales[row].rawValue
    }
    return Realm.allRealms[row].displayName
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView == localePicker {
      // localeTextField.text = Locale.allLocales[row].rawValue
      self.selectedLocale = Locale.allLocales[row]
      self.localeTextField.text = selectedLocale?.rawValue
      self.localePicker.reloadAllComponents()
    } else {
      self.selectedRealm = Realm.allRealms[row]
      self.realmTextField.text = selectedRealm?.displayName
      self.realmPicker.reloadAllComponents()
    }
  }
  
  
  @IBAction func buttonPressed(_ sender: Any) {
    performSegue(withIdentifier: "FormViewToCompareView", sender: nil)
    webRequest.requestCurrentAuctionData(withRealm: selectedRealm!, withLocale: selectedLocale!)
    // How to make this take the users input if Realm and Locale are enums?
    
  }
  
  @objc func cancelPickerView() {
    self.realmTextField?.resignFirstResponder()
    self.localeTextField?.resignFirstResponder()
  }
  
  
  func setupPickerView() {
    realmPicker.dataSource = self
    realmPicker.delegate = self
    localePicker.dataSource = self
    localePicker.delegate = self
    
    self.localeTextField.inputView = self.localePicker
    self.realmTextField.inputView = self.realmPicker
    
    let toolbar = UIToolbar()
    toolbar.barStyle = .default
    let cancelButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.cancelPickerView))
    let flexibleButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.isUserInteractionEnabled = true
    toolbar.isTranslucent = false
    toolbar.tintColor = UIColor.black
    toolbar.setItems([cancelButton, flexibleButton], animated: false)
    toolbar.sizeToFit()
    localeTextField.inputAccessoryView = toolbar
    realmTextField.inputAccessoryView = toolbar
  }
}

