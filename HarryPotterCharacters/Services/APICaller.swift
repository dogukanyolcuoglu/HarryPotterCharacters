//
//  Service.swift
//  HarryPotterCharacters
//
//  Created by Dogukan Yolcuoglu on 30.07.2021.
//

import Foundation

final class APICaller {
    
    struct Constants {
        static let url = "http://hp-api.herokuapp.com/api/characters"
    }
    
    // Fetch Data from API
    func downloadCharacters(completion: @escaping ([Character]?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: URL(string: Constants.url)!) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("HTTP error!")
                return
            }
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode([Character].self, from: data)
                    completion(result)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
}
