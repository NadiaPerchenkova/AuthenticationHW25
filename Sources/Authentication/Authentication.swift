import Foundation
import SwiftKeychainWrapper

enum AuthError: Error {
    case notExist
    case alreadyExist
    case wrongPassword
    case somethingWentWrong
}

class MyAuthentication {
    
    static let shared = MyAuthentication()
    private init() {}
    
    
    func logIn(email: String, password: String) -> Result<Bool, AuthError> {
        
        let passwordKeycain: String? = KeychainWrapper.standard.string(forKey: email)
        
        if passwordKeycain == nil {
            return .failure(.notExist)
        } else if passwordKeycain != password {
            return .failure(.wrongPassword)
        }
        return .success(true)
    }
    
    func signUp(email: String, password: String) -> Result<Bool, AuthError> {
        
        let passwordKeycain: String? = KeychainWrapper.standard.string(forKey: email)
        
        if passwordKeycain == password {
            return .failure(.alreadyExist)
        }
        
        let saveSuccessful: Bool = KeychainWrapper.standard.set(password, forKey: email)
        
        if !saveSuccessful {
            return .failure(.somethingWentWrong)
        }
        
        return .success(true)
    }
}
