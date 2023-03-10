//
//  NetworkLogger.swift
//  Weather
//
//  Created by Muhammad Jamiil Angnoo on 03/02/2023.
//

import Foundation
import Alamofire

class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.steeve.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print("Api Request: \(request.description)")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print("Api Response received: \(json)")
        }
    }
}
