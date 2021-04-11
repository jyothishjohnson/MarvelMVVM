//
//  ViewController.swift
//  HackerNewApiDemo
//
//  Created by jyothish.johnson on 26/03/21.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var isLoading : Bool = false
    
    var marvelCharactersData : [MarvelCharacter] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indicatorStyle = .white
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: "MarvelCharacterCell", bundle: .main), forCellReuseIdentifier: "characterCell")
        
        isLoading = true
        MCharacterListViewModel.loadNewsList{ [weak self] characters in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.marvelCharactersData = characters
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
        marvelCharactersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? MarvelCharacterCell else {
            fatalError()
        }
        
        cell.characterName = marvelCharactersData[indexPath.row].name
        let imagePath = "\(marvelCharactersData[indexPath.row].thumbnail?.path ?? "").\(marvelCharactersData[indexPath.row].thumbnail?.extension ?? "")"
        cell.imageURL = imagePath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight * 0.75 && !isLoading) {
            loadMore()
        }
    }
    
    func loadMore(){
        print(#function)
        isLoading = true
        MCharacterListViewModel.loadNewsList(offset: marvelCharactersData.count){
            [weak self] characters in
            
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.marvelCharactersData.append(contentsOf: characters)
                self?.tableView.reloadData()
            }

        }
    }

}
