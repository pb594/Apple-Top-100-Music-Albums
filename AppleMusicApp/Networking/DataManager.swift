//
//  DataManager.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 19/07/22.
//

import Foundation

class DataManager {
    
    class func fetch(requestURL:URL,requestType:String,parameter:[String:AnyObject]?,success:@escaping (_ data : NSDictionary)->Void,failure:@escaping (_ err:NSError)-> Void ){
        var urlRequest = URLRequest.init(url: requestURL)
        urlRequest.cachePolicy = .reloadIgnoringLocalCacheData
        urlRequest.timeoutInterval = 60
        urlRequest.httpMethod = String(describing: requestType)
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        //Post URL parameters set as URL body
        if let params = parameter{
            do{
                let parameterData = try JSONSerialization.data(withJSONObject:params, options:.prettyPrinted)
                urlRequest.httpBody = parameterData
            }catch{
                
                failure(error as NSError)
                
            }
        }
        //URL Task to get data
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let objError = error{
                failure(objError as NSError)
            }
            if let objData = data,let objURLResponse = response as? HTTPURLResponse{
                //We have data validate for JSON and convert in JSON
                do{
                    let objResposeJSON = try JSONSerialization.jsonObject(with: objData, options: .mutableContainers) as? NSDictionary
                    //Check for valid status code 200 else fail with error
                    if objURLResponse.statusCode == 200{
                        success(objResposeJSON!)
                    }
                }catch{
                    failure(error as NSError)
                }
            }
        }.resume()
    }
    
}
