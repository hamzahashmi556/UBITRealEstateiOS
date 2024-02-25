//
//  SignUpView.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var onboardingVM: OnboardingViewModel
        
    @State var email = ""
    @State var password = ""
    @State var firstName = ""
    @State var lastName = ""
    
    @State var selectedImage: UIImage? = nil
    
    @State var showPassword = false
    
    @State var isPresentImagePicker = false
    
    @FocusState var focusPassword: Bool
        
    var body: some View {
        
        ZStack {

            ScrollView {
                
                VStack(spacing: 10) {
                    
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .padding()
                            .foregroundStyle(.accent)
                    }
                    else {
                        Button(action: {
                            self.isPresentImagePicker.toggle()
                        }, label: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .padding()
                                .foregroundStyle(.accent)
                        })
                    }
                    
                    VStack(spacing: 20, content: {
                        SignUpField(title: "Email", placeholder: "Enter Email", text: $email)
                        
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
                        
                        SignUpField(title: "FirstName", placeholder: "Enter First Name", text: $firstName)
                        
                        SignUpField(title: "Last Name", placeholder: "Enter Last Name", text: $lastName)
                    })
                    
                    Spacer()
                    
                    Button {
                        // Perform login action
                        self.onboardingVM.signUpUser(email: email, password: password, firstName: firstName, lastName: lastName, selectedImage: selectedImage)
                    } label: {
                        AppButton(title: "Create Account", textColor: .white)
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
    
    func SignUpField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(.callout)
                .foregroundStyle(.black.opacity(0.8))
            
            RoundedTextField(title: placeholder, text: text)
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignUpView()
        .environmentObject(OnboardingViewModel())
}
