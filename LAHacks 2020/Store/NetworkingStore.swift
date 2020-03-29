//
//  NetworkingStore.swift
//  LAHacks 2020
//
//  Created by Matthew Krager on 3/28/20.
//  Copyright © 2020 Matthew Krager. All rights reserved.
//

import UIKit
import Alamofire

class NetworkingStore: NSObject {
    static var shared = NetworkingStore()
    private override init() { }
    
    var url = "http://192.168.1.174:5000/"
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func uploadAudio(word: String, callback: @escaping (Double) -> Void) {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let stringVersion = audioFilename.path
        let encodedSound = FileManager.default.contents(atPath: stringVersion)
        let encodedBase64Sound = encodedSound!.base64EncodedString()
        
        var parameters = Dictionary<String, Any>()
        parameters["base"] = encodedBase64Sound
        parameters["word"] = word
        
        Alamofire.request(url + "upload", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let jsonDecoder = JSONDecoder()
            guard let data = response.data else {
                return
            }
            if let result = response.result.value {
                let JSON = result as! Dictionary<String, Any>
                callback((JSON["score"] as? Double) ?? 0.0)
            }
            print(data)
        }
    }
}
