//
//  ViewController.swift
//  FindAndNotify
//
//  Created by Nicole Chung on 2015-11-28.
//  Copyright © 2015 Nicole Chung. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var streetNumber: UITextField!
    
    @IBOutlet weak var streetName: UITextField!
    
    @IBOutlet weak var streetPicker: UIPickerView!
    
    let pickerData = ["Avenue", "Boulevard", "Circle", "Court", "Lane", "Plaza", "Quay, ","Road", "Street", "Terrace", "Walk"]
    
    var streetType:String?
    
    
    @IBAction func submit(sender: AnyObject) {
        let streetNumberVal = streetNumber!.text;
        let streetNameVal = streetName!.text;
        
        
        let address = "\(streetNumberVal) \(streetNameVal) \(streetType), Toronto, ON, Canada"
        
        let geocoder = CLGeocoder();
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if ((error) != nil) {
                print("Error", error);
            }
            
            if let placemark = placemarks?.first {
                let location = placemark.location
                let coords = location?.coordinate;
                print("----result----");
                print(coords?.longitude);
                print(coords?.latitude);
                
            }
        });
        
        print(address);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        streetPicker.dataSource = self;
        streetPicker.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row];
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        streetType = pickerData[row];
    }


}

