//
//  JokePresenter .swift
//  JokeListing
//
//  Created by Anushka Tripathi on 11/09/23.
//

import Foundation
import UIKit

protocol JokePresenter: AnyObject {
    func jokedFetched(_ JokesListing: [JokeModel])
}

class JokePresenterFetching {
    weak var delegate: JokePresenter?
   private var joke = [JokeModel]()
    
    func JokesFetching() {
        
        guard let url = URL(string:  "https://geek-jokes.sameerkumar.website/api") else {return}
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _ , error) in
            guard let data = data, error == nil else {return}
            
            do {
                let jokeData = try JSONDecoder().decode(String.self, from: data)
                let joke = JokeModel(jokeName: jokeData, jokeTime: jokeData)
                
                self?.joke.append(joke)
                
                if self?.joke.count ?? 0 > 10 {
                    self?.joke.removeFirst()
                }
                
                self?.delegate?.jokedFetched(self?.joke ?? [])
                
               // print(joke.jokeName)
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
                
        }.resume()
    }
}

