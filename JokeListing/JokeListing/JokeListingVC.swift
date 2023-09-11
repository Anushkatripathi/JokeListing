//
//  JokeListingVC.swift
//  JokeListing
//
//  Created by Anushka Tripathi on 11/09/23.
//

import Foundation
import UIKit


class JokeListingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let jokePresenter = JokePresenterFetching()
    var jokes: [JokeModel] = []

    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        
        self.tableView.register(UINib(nibName:String(describing: JokeListingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JokeListingTableViewCell.self))
        
        self.jokePresenter.delegate = self
        self.jokePresenter.JokesFetching()
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.jokePresenter.JokesFetching()
        }
    }
    
}

extension JokeListingVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  let cell = tableView.dequeueReusableCell(withIdentifier: "JokeListingTableViewCell", for: indexPath) as? JokeListingTableViewCell {
            
            let joke = jokes[indexPath.row]
            cell.jokeName.text = joke.jokeName
            
            return cell
        }
        
        return UITableViewCell()
    }

}

extension JokeListingVC: JokePresenter {
    func jokedFetched(_ JokesListing: [JokeModel]) {
        self.jokes = JokesListing
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
