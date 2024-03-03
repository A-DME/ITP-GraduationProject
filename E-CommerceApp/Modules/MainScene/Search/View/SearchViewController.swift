//
//  SearchViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 03/03/2024.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTable: UITableView!
    
   var result : Products?
    var filteredItems :[Product]?
    var indicator : UIActivityIndicatorView?
   var searchViewModel : SearchViewModel?
    var searchWord : String = ""
    var searching : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        result = Products(products: [])
        filteredItems = []
        setIndicator()
        loadData()
    }
    

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searching = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searching = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchWord = searchBar.text ?? ""
        print("Search text: \(searchWord)")
        searchingResult()
    }
    
    
  
    func searchingResult(){
        if searching == false{
            filteredItems = result?.products
        }else{
            if searchWord.isEmpty{
                filteredItems = result?.products
            }else{
                filteredItems = result?.products.filter { $0.title.lowercased().contains(searchWord.lowercased()) }
            }
        }
        
        checkIfNoItems()
        resultTable.reloadData()
    }
    func checkIfNoItems(){
        if (filteredItems?.count  == 0) {
            resultTable.setEmptyMessage("No Items Found")
        } else {
            resultTable.restor()
        }
    }
    func loadData(){
        searchViewModel = SearchViewModel()
        searchViewModel?.loadData()
        searchViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.display()
                self?.filteredItems = self?.result?.products
                self?.resultTable.reloadData()
                
            }
        }
    }
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.resultTable.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
    }
    func display() {
        indicator?.stopAnimating()
        result = searchViewModel?.getAllData()
        
        
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredItems?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTable.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = filteredItems?[indexPath.row].title.split(separator: "|").dropFirst().first.map(String.init)
        cell.detailTextLabel?.text = filteredItems?[indexPath.row].vendor
        let url = URL(string:filteredItems?[indexPath.row].image.src ?? "")
        cell.imageView?.kf.setImage(with: url,placeholder: UIImage(named: "placeHolder"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}
