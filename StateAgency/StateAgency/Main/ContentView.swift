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
        
        NavigationStack {
            ZStack {
                switch onboardingVM.userState {
                case .login:
                    LandingView()
                case .newUser:
                    OnboardingTutorialView()
                case .home:
                    TabbarView()
                }
            }
            .navigationDestination(isPresented: $onboardingVM.isPresentLogin) {
                LoginView()
            }
            .navigationDestination(isPresented: $onboardingVM.isPresentSignup) {
                SignUpView()
            }

        }
        .environmentObject(onboardingVM)
    }
}

#Preview {
    ContentView()
}
