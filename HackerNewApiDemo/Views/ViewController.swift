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
        
        registerCells()
        
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
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return marvelCharactersData.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IconCells.MarvelCharacterCell.rawValue, for: indexPath) as? MarvelCharacterCell else {
                fatalError()
            }
            
            cell.characterName = marvelCharactersData[indexPath.row].name
            let imagePath = "\(marvelCharactersData[indexPath.row].thumbnail?.path ?? "").\(marvelCharactersData[indexPath.row].thumbnail?.extension ?? "")"
            cell.imageURL = imagePath
            
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IconCells.LoadingCell.rawValue, for: indexPath) as? LoadingCell else {
                fatalError()
            }
            cell.isLoading = isLoading
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight * 0.75 && !isLoading && MCharacterListViewModel.currentTotal > marvelCharactersData.count) {
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


//MARK: - Register cells

extension ViewController {
    
    private enum IconCells: String, CaseIterable{
        case MarvelCharacterCell
        case LoadingCell
    }
    
    func registerCells(){
        IconCells.allCases.forEach { (icon) in
            tableView.register(UINib(nibName: icon.rawValue, bundle: .main), forCellReuseIdentifier: icon.rawValue)
        }
    }
}
