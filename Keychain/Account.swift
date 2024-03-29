//
//  Account.swift
//  Keychain
//
//  Created by Justin Williams on 9/15/14.
//  Copyright (c) 2014 Second Gear. All rights reserved.
//

import Foundation
import Security

public class Account
{
    public var userName : String
    public var secret: String?
    
    private var keychain : Keychain?
    
    // MARK: Initializers
    // ========================================================
    // Initializers
    // ========================================================
    public init(userName: String, secret: String, keychain: Keychain)
    {
        self.userName = userName
        self.secret = secret
        self.keychain = keychain
    }

    public init(userName: String, secret: String)
    {
        self.userName = userName
        self.secret = secret
    }
    
    public init(userName: String)
    {
        self.userName = userName
    }
    
    // MARK: Public Methods
    // ========================================================
    // Public Methods
    // ========================================================
    public func isValid() -> Bool
    {
        return !self.userName.isEmpty
    }
    
    public func attributes() -> NSMutableDictionary
    {
        let GenericPasswordAttribute: String! = kSecClassGenericPassword as String
        let AccountAttribute: String! = kSecAttrAccount as String
        let ClassAttribute: String! = kSecClass as String
        let ValueDataAttribute: String! = kSecValueData as String
        
        var attributes = [
            ClassAttribute : GenericPasswordAttribute,
            AccountAttribute : userName,
        ] as NSMutableDictionary
        
        var passwordData: NSData = NSData()
        if let password = self.secret
        {
            passwordData = password.dataUsingEncoding(NSUTF8StringEncoding)!
            attributes[ValueDataAttribute] = passwordData
        }
        
        return attributes;
    }
}