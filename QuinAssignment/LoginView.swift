//
//  ContentView.swift
//  QuinAssignment
//
//  Created by Praveen Kumar on 16/12/20.
//

import SwiftUI


struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var isEmailValid : Bool   = true
    @State private var error = ""
    @State var isLoginValid = false
    var body: some View {
        
        VStack(alignment : .center) {
            Form {
                
                let binding = Binding<String>(get: {
                    self.login
                }, set: {
                    self.login = $0
                    if validateEmail(email: self.login) == false {
                        self.error = "Invalid Email"
                    } else {
                        self.error = ""
                    }
                })
                
                Text(error)
                    .font(.callout)
                    .foregroundColor(.red)
                TextField("  Login", text: binding)
                .autocapitalization(.none)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                SecureField("  Password", text: $password)
                .autocapitalization(.none)
                .textContentType(.password)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                
                Button(action : {
                    if validate(login: self.login, pass: self.password) {
                        isLoginValid = true
                        Defaults.isLoggedIn = true
                        error = ""
                    } else {
                        error = "Invalid Login & Password"
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Login")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
                NavigationLink(destination : SearchMapView(), isActive : $isLoginValid) {
                    EmptyView()
                }.hidden()
            }
        }
    }
}

func validateEmail(email : String ) -> Bool {
    let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
    return emailPredicate.evaluate(with: email)
}

func validate(login : String, pass : String) -> Bool {
    return login == "abc@quin.design" && pass == "Quin123"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
