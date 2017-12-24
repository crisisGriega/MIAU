//
//  MarvelAPI.swift
//  MIAU
//
//  Created by Gerardo on 24/12/2017.
//  Copyright © 2017 crisisGriega. All rights reserved.
//

import Foundation


class MarvelAPIConnector {
    
    static let `default`: MarvelAPIConnector = MarvelAPIConnector ();
    
    private init() { }
    
    lazy private var configuration: NSDictionary = {
        guard
            let envConfig = Bundle.main.infoDictionary?["Configuration"] as? String,
            let apiConfigFilePath = Bundle.main.path(forResource: "APIConfiguration", ofType: "plist"),
            let apiConfigFile = NSDictionary(contentsOfFile: apiConfigFilePath),
            let apiConfigDict = apiConfigFile.value(forKey: envConfig) as? NSDictionary else
        {
            fatalError("Couldn't read API configuration file");
        }
        
        return apiConfigDict;
    }();
    
    func urlFor(_ resource: MarvelEntityType, id: String? = nil, args: [String: String]? = nil) -> String {
        var baseURL: String =  self.baseURL.appending("/\(self.version)/\(self.visibility)/\(resource)");
        
        if let _id = id {
            baseURL.append("/\(_id)")
        }
        
        // Adding authorization parameters
        let timeStamp = String(describing: Date().timeIntervalSince1970);
        
        let hash = "\(timeStamp)\(self.privateKey)\(self.publicKey)".toMD5();
        
        baseURL.append("?apikey=\(self.publicKey)&hash=\(hash)&ts=\(timeStamp)");
        
        if let _args = args {
            for arg in _args {
                baseURL.append("&\(arg.key)=\(arg.value)");
            }
        }
        
        
        return baseURL;
    }
}


// MARK: Private
private extension MarvelAPIConnector {
    var baseURL: String {
        return self.configurationValue("url");
    }
    
    var version: String {
        return self.configurationValue("version")
    }
    
    var visibility: String {
        return self.configurationValue("visibility");
    }
    
    var publicKey: String {
        return self.configurationValue("key");
    }
    
    var privateKey: String {
        return self.configurationValue("private-key");
    }
    
    func configurationValue(_ value: String) -> String {
        guard let _value = self.configuration.value(forKey: value) as? String else {
            fatalError("Couldn't read API \(value)");
        }
        
        return _value;
    }
}
