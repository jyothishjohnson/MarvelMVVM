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
    var searchFilteredData : [MarvelCharacter] = []
    var favCharactersData : Set<MarvelCharacter> = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indicatorStyle = .white
        tableView.tableFooterView = UIView()
        
        registerCells()
        
        isLoading = true
        
//        MCharacterListViewModel.deleteEntity(name: "MCharacter")
        
//        let character = MCharacter(context: context)
//        character.name = "Jyo"
//        character.id = 1
//        character.imageURL = "imageURL.jpg"
//
//        do {
//            try context.save()
//        }catch {
//            print(error.localizedDescription)
//        }
        
        MCharacterListViewModel.fetchFavouriteCharacter{ count in
            print(count, "#####")
        }.forEach({ (character) in
            favCharactersData.insert(character)
        })
        
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
        if searchController.isActive{
            return 1
        }else{
            if isLoading {
                return 2
            }
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if searchController.isActive{
                return searchFilteredData.count
            }else {
                return marvelCharactersData.count
            }
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: IconCells.MarvelCharacterCell.rawValue, for: indexPath) as? MarvelCharacterCell else {
                fatalError()
            }
            let character = searchController.isActive ? searchFilteredData[indexPath.row] : marvelCharactersData[indexPath.row]
            
            cell.characterName = character.name
            cell.imageURL = character.imageURL
            
            if favCharactersData.contains(character){
                cell.accessoryType = .checkmark
            }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight * 0.75 && !isLoading &&
                MCharacterListViewModel.currentTotal > marvelCharactersData.count &&
                !searchController.isActive) {
            isLoading = true
            tableView.reloadData()
            loadMore()
        }
    }
    
    func loadMore(){
        print(#function)
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

//MARK: - Add/Delete from CoreData

extension ViewController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if marvelCharactersData.indices.contains(indexPath.row){
            print(indexPath.row)
            let character = marvelCharactersData[indexPath.row]
            if favCharactersData.contains(character){
                
                MCharacterListViewModel.deleteFavCharacter(character: character)
                favCharactersData.remove(character)
                cell?.accessoryType = .none
            }else {
                
                MCharacterListViewModel.addFavCharacter(character: character)
                favCharactersData.insert(character)
                cell?.accessoryType = .checkmark
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

extension ViewController: UISearchResultsUpdating{
    
    func setUpSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        guard searchController.isActive else {
            tableView.reloadData()
            return
        }
        let searchBar = searchController.searchBar
        let text = searchBar.text
        if let searchText = text, !searchText.isEmpty {
            search(for: searchText)
        }
    }
    
    func search(for searchString : String){
        searchFilteredData = marvelCharactersData.filter({ (character) -> Bool in
            (character.name?.hasPrefix(searchString) ?? false)
        })
        tableView.reloadData()
    }
}
