//
//  NetworkManager.swift
//  PokedexToodoo
//
//  Created by user209844 on 13/01/22.
//

import Foundation

class NetworkManager {
    let domainUrlString = "https://toodoo-pokedex.herokuapp.com/api/v1"
    
    func getData(completionHandler: @escaping ([Pokemon]) -> Void) {
        let url = URL(string: domainUrlString + "/pokemons/")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else{
                print("Request Error!")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      print("Error with the response, unexpected status code: \(response)")
                      return
                  }
            
            var result: [Pokemon]?
            do {
                result = try JSONDecoder().decode([Pokemon].self, from: data)
            } catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            completionHandler(result ?? [])
        })
        task.resume()
    }
}
