//
//  AppDelegate.swift
//  Pokemon
//
//  Created by Riccardo Baratto on 08/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        window = UIWindow(frame: UIScreen.main.bounds)
        let pokemonListVC = PokemonListViewController() as UIViewController
        let navigationController = UINavigationController(rootViewController: pokemonListVC)
        window?.rootViewController = navigationController
        
        return true
    }

}

