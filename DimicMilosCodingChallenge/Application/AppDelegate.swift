//
//  AppDelegate.swift
//  DimicMilosCodingChallenge
//
//  Created by Dimic Milos on 8/23/19.
//  Copyright © 2019 Dimic Milos. All rights reserved.
//

import os
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator!
    
    let networkService = NetworkingService()
    let parserService = ParserService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        os_log(.info, log: .sequence, "function: %s, line: %i, \nfile: %s", #function, #line, #file)

        window = UIWindow()
        window?.makeKeyAndVisible()
        
        applicationCoordinator = ApplicationCoordinator(window: window!, vehicleObtainable: networkService, parserService: parserService, rootViewController: MainNavigationController())
        applicationCoordinator.start()
        return true
    }
}

/*
 
 Even this assignment represents just a micro app and most of the techniques used here are overkill for this app size, my intention was to show how would I do it in a larger app. I will list some key points:
 
 1. Coordinator pattern implemented since it makes ViewControllers completely relaxed from business logic and lets them do their primary job :)
 2. Coordinator pattern implemented to demonstrate how easy is to change contexts and jump from one part to the other part of the app. In this case from MapFlow to ListFlow and vice versa.
 3. IMPORT of different MODULES in different files are kept on the minimum (ex: CoreLocation, MapKit…)
 4. No 3rd party libraries have been used
 5. OS_LOG is something I find useful while debugging and also as an essential part of creating good Analytics of user behavior and tracking errors (this is usually sent to BE for further analysis). Different message types make it easy to filter out noise. Downside is it creates extra code, but it gives a lot more than it takes :)
 6. Network calls are kept on minimum. If data can be used in multiple occasions it will not be requested from BE (ex: switching from MAP to LIST flow)
 7. Changing bounds on mapView will be mirrored in the list view
 8. Annotations are clickable and have useful info :)
 9. Filter by fleet type is also implemented thru reusable filterView
 10. Map position is tracked so change of context doesn’t change the bounds
 11. Tested ViewModel, ViewController and Coordinator with special care
 12. I would greatly appreciate feedback. Thank you for the time invested!
 
 */
