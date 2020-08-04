//
//  YPFindLocalController+LocationDelegate.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import Foundation
import CoreLocation


extension YPFindLocalController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.localLabel.text = "Error while updating location " + error.localizedDescription
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            guard error == nil else {
                self.localLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks!.first
                self.displayLocationInfo(pm)
            } else {
                self.localLabel.text = "Problem with the data received from geocoder"
            }
        }
    }
    
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
    //
    //            if (error != nil) {
    //                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
    //                return
    //            }
    //
    //            if placemarks!.count > 0 {
    //                let pm = placemarks![0]
    //                self.displayLocationInfo(pm)
    //            } else {
    //                self.locationLabel.text = "Problem with the data received from geocoder"
    //            }
    //        })
    //    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            self.localLabel.text = postalCode! + " " + locality!
            
            self.localLabel.text?.append("\n" + administrativeArea! + ", " + country!)
        }
        
    }
}
