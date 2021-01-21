//
//  DetailTableViewController.swift
//  AlarmCoreData
//
//  Created by Chris Withers on 1/21/21.
//

import UIKit

class DetailTableViewController: UITableViewController {

    
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabled: UIButton!
    
    var isAlarmOn: Bool = true
    
    var alarm: Alarm?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    @IBAction func alarmIsEnabledButtonTapped(_ sender: UIButton) {
        isAlarmOn.toggle()
        designIsEnabledButton()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let alarmTitle = alarmTitleTextField.text, !alarmTitle.isEmpty else { return }
        
        if let selectedAlarm = alarm {
            AlarmController.shared.update(alarm: selectedAlarm, newTitle: alarmTitle, newFireDate: alarmFireDatePicker.date, isEnabled: isAlarmOn)
        }else {
            AlarmController.shared.createAlarm(withTitle: alarmTitle, isEnabled: isAlarmOn, fireDate: alarmFireDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    func updateView(){
        guard let selectedAlarm = alarm else { return }
        
        isAlarmOn = selectedAlarm.isEnabled
        alarmTitleTextField.text = selectedAlarm.title
        alarmFireDatePicker.date = selectedAlarm.fireDate ?? Date()
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabled.backgroundColor = .white
            alarmIsEnabled.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabled.backgroundColor = .darkGray
            alarmIsEnabled.setTitle("Disabled", for: .normal)
        }
    }
    
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
