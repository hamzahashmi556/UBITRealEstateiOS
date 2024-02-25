//
//  OnboardingViewModel.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    @Published var titles = [
        "Welcome to UBIT Estate Agency",
        "Powerful Search Engine for properties",
        "Buy/Sell or Rent your house, apartments, flats, portions etc"
    ]
    
    @Published var subTitles = [
        "Official Estate Agency of UBIT 4th Year students",
        "We are developing powerful searching for users to find their ideal place for home",
        "You can post the ad to rent or sell your place or search with our app to buy or rent a new place"
    ]
    
    @Published var images = [
        "house.lodge.circle.fill",
        "location.magnifyingglass",
        "figure.2.circle.fill"
    ]
    
    @Published var isPresentLogin = false
}
