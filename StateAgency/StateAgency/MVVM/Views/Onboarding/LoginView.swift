//
//  LoginView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var onboardingVM: OnboardingViewModel
        
    @State var email = ""
    @State var password = ""
    
    @State var showPassword = false
    
    @FocusState var focusPassword: Bool
        
    var body: some View {
        
        ZStack {

            VStack(spacing: 10) {
                
                Image(.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding()

                VStack(alignment: .leading) {
                    
                    Text("Email")
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.8))
                    
                    RoundedTextField(title: "Enter Email", text: $email)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack(alignment: .leading) {
                    
                    Text("Password")
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.8))
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .opacity(0.1)
                        
                        if showPassword {
                            TextField("Entert Password", text: $password)
                                .focused($focusPassword)
                                .frame(height: 50)
                                .padding(.leading)
                        }
                        else {
                            SecureField("Entert Password", text: $password)
                                .focused($focusPassword)
                                .frame(height: 50)
                                .padding(.leading)
                        }
                        
                        HStack {
                            Spacer()
                        }
                    }
                    .frame(height: 50)
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    
                    Button("Forgot Password") {
                        self.onboardingVM.forgotPassword(email: email)
                    }
                    .padding(.trailing)
                }
                
                Spacer()
                
                Button {
                    // Perform login action
                    self.onboardingVM.loginUser(email: email, password: password)
                } label: {
                    AppButton(title: "Sign in", textColor: .white)
                }
                .padding(.bottom)
                
                HStack {
                    Text("Don't have an account,")
                    
                    Button(action: {
                        if self.onboardingVM.isPresentSignup {
                            self.onboardingVM.isPresentLogin = false
                        }
                        else {
                            self.onboardingVM.isPresentSignup = true
                        }
                    }, label: {
                        Text("sign up")
                            .underline()
                    })
                }
                .padding(.bottom)
            }
            .alert(isPresented: $onboardingVM.showError) {
                Alert(title: Text("Error"), message: Text(onboardingVM.errorMessage), dismissButton: .default(Text("OK")))
            }
            
            if onboardingVM.isLoading {
                ProgressView("Loading...")
            }
        }
        .navigationTitle("Login")
    }
}

struct RoundedTextField: View {
    
    @State var title: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .opacity(0.1)
            
            TextField(title, text: $text)
                .frame(height: 50)
                .padding(.leading)
        }
        .frame(height: 50)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environmentObject(OnboardingViewModel())
}
