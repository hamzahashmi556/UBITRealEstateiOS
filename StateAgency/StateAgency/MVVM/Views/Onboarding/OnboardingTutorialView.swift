//
//  OnboardingTutorialView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct OnboardingTutorialView: View {
    
    @ObservedObject var onboardingVM: OnboardingViewModel
    
    @State var selectedPage = 0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            TabView(selection: $selectedPage) {
                ForEach(0...2, id: \.self) { index in
                    VStack {
                        
                        
                        Image(systemName: onboardingVM.images[index])
                            .resizable()
                            .frame(width: 200, height: 200)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.accent)
                        
                        
                        Text(onboardingVM.titles[index])
                            .font(.title)
                            .fontWeight(.bold)
                        
                        
                        Text(onboardingVM.subTitles[index])
                            .font(.title2)
                            .padding(.top)
                        
                        
                    }
                    .padding(.horizontal)
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .multilineTextAlignment(.center)
            
            Button("Skip") {
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    OnboardingTutorialView(onboardingVM: OnboardingViewModel())
}
