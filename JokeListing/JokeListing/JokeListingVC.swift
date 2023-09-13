//
//  JokeListingVC.swift
//  JokeListing
//
//  Created by Anushka Tripathi on 11/09/23.
//

import Foundation
import UIKit


class JokeListingVC: UIViewController {
    
    let tableView = UITableView()
    let label = UILabel()
    
    let jokePresenter = JokePresenterFetching()
    var jokes: [JokeModel] = []
    
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = .black
        
        self.label.text = "Unlimint Jokes"
        self.label.textAlignment = .center
        self.label.textColor = UIColor(red: 210 / 255, green: 245 / 255, blue: 97 / 255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = .black
        
        self.view.addSubview(label)
        self.view.addSubview(tableView)
        
        self.tableView.register(UINib(nibName:String(describing: JokeListingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: JokeListingTableViewCell.self))
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
