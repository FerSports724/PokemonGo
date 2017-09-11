//
//  ViewController.swift
//  PokemonGo
//
//  Created by Fernando Vazquez Bernal on 04/08/17.
//  Copyright © 2017 Fernando Vazquez Bernal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var MapView: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    let mapDistance:CLLocationDistance = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            print("Estoy listo, estoy listo.")
            self.MapView.showsUserLocation = true
            self.manager.startUpdatingLocation()
        }else{
            self.manager.requestWhenInUseAuthorization()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    //MARK: CoreLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if updateCount < 4{
            if let coordinate = self.manager.location?.coordinate{
                let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, mapDistance, mapDistance)
                
                self.MapView.setRegion(region, animated: true)
                
                updateCount += 1
            }

        }else{
            
            self.manager.stopUpdatingLocation()
            
        }
        
    }
    
    @IBAction func brujula(_ sender: UIButton) {
        
        if let coordinate = self.manager.location?.coordinate{
            let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, mapDistance, mapDistance)
            
            self.MapView.setRegion(region, animated: true)
        }
        
        
        
    }
    
}

