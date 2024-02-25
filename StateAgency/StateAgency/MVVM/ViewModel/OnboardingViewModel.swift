//
//  OnboardingViewModel.swift
//  StateAgency
//
//  Created by Hamza Hashmi on 25/02/2024.
//

import Foundation
import FirebaseAuth
import SwiftUI

final class OnboardingViewModel: ObservableObject {
        
    @Published var userState: LoginState = Auth.auth().currentUser == nil ? .login : .home
    
    @Published var isLoading = false
    
    @Published var isPresentLogin = false
    @Published var isPresentSignup = false
    
    
    @Published var errorMessage = ""
    @Published var showError = false
    
    init() {
        self.addAuthenticationListener()
    }
    
    private func addAuthenticationListener() {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            guard let _ = Auth.auth().currentUser else {
                self.userState = .login
                return
            }
            
            self.userState = .home
            
        }
    }
    
    func loginUser(email: String, password: String) {
        
        guard !email.isEmpty else {
            self.present(error: "Please Enter Email")
            return
        }
        
        guard email.isValidEmail() else {
            self.present(error: "Email is not valid, Please Enter Correct Email Address")
            return
        }
        
        guard !password.isEmpty else {
            self.present(error: "Password can not be empty")
            return
        }
            
        self.isLoading = true
            
        Task { @MainActor in
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                self.isLoading = false
            }
            catch {
                self.isLoading = false
                self.present(error: "Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUpUser(email: String, password: String, firstName: String, lastName: String, selectedImage: UIImage?) {
        
    }
    
    func forgotPassword(email: String) {
        
        guard !email.isEmpty else {
            self.present(error: "Please Enter Email")
            return
        }
        
        guard email.isValidEmail() else {
            self.present(error: "Email is not valid, Please Enter Correct Email Address")
            return
        }
        
        self.isLoading = true

        Task { @MainActor in
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
            }
            catch {
                self.isLoading = false
                self.present(error: "Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func present(error: String) {
        self.errorMessage = error
        self.showError = true
    }
}
