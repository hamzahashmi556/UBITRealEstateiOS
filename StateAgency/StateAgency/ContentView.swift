//
//  ContentView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var onboardingVM = OnboardingViewModel()

    var body: some View {
        OnboardingTutorialView(onboardingVM: onboardingVM)
    }
}

#Preview {
    ContentView()
}
