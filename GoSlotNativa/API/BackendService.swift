//
//  BackendService.swift
//  GoSlotNativa
//
//  Created by Alejandro on 17/11/21.
//

import SwiftUI

struct BackendService {
    
    static func uploadPostBackend() {
            
            guard let url = URL(string: "https://api.goslot.es/posts") else {return}

        /*    var urlSessionConfiguration = URLSessionConfiguration.default
            var urlSession = URLSession(configuration: urlSessionConfiguration)*/
        
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(response!)
        }.resume()

    }
}
