//
//  ViewController.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 26/03/21.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var marvelCharacter : [MarvelCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indicatorStyle = .white
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "MarvelCharacterCell", bundle: .main), forCellReuseIdentifier: "characterCell")
        
        NewsListViewModel().loadNewsList{ [weak self] characters in
            DispatchQueue.main.async {
                self?.marvelCharacter = characters
                self?.tableView.reloadData()
            }

        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marvelCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? MarvelCharacterCell else {
            fatalError()
        }
        
        cell.characterName = marvelCharacter[indexPath.row].name
        let imagePath = "\(marvelCharacter[indexPath.row].thumbnail?.path ?? "").\(marvelCharacter[indexPath.row].thumbnail?.extension ?? "")"
        cell.imageURL = imagePath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
