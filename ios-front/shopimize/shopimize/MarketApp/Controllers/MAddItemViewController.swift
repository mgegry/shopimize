//
//  MAddItemViewController.swift
//  shopimize
//
//  Created by Mircea Egry on 18/03/2022.
//

import UIKit

class MAddItemViewController: UIViewController {

    /// price date-added is-active photo name description markets shop
    
    let addItemView = AddItemView()
    
    override func loadView() {
        view = addItemView
        view.backgroundColor = .white
        addItemView.marketPicker.delegate = self
        addItemView.marketPicker.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
}

extension MAddItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "fuata"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}
