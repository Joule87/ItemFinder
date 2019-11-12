//
//  ItemFinderViewController.swift
//  ItemFinder
//
//  Created by Julio Collado on 11/9/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class ItemFinderViewController: BaseViewController {
    //MARK:- Outlets
    @IBOutlet weak var itemTableView: UITableView!
    
    //MARK:- Properties
    var presenter: ItemFinderPresenterDelegate?
    private let debouncer = Debouncer(timeInterval: 0.5)
    
    private lazy var itemNotFoundView: UIView = {
        let alpha: CGFloat = 0.2
        let viewColor: UIColor = .black
        let emptyView = UIView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        [emptyView.widthAnchor.constraint(equalToConstant: CGFloat(200)),
         emptyView.heightAnchor.constraint(equalToConstant: CGFloat(200))].forEach{$0.isActive = true}
        emptyView.layer.cornerRadius = 10
        emptyView.backgroundColor = viewColor.withAlphaComponent(alpha)
        
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "alert.notFound".localized
        
        let stack = UIStackView(arrangedSubviews: [label])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.contentMode = .scaleAspectFit
        
        emptyView.addSubview(stack)
        
        [stack.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
         stack.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
         stack.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
         stack.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)].forEach{$0.isActive = true}
        
        return emptyView
    }()
    
    //MARK:- View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIElements()
    }
    
    //MARK:- View Controller Functions
    ///Set initial configuration for all UI elements
    func setupUIElements() {
        setupSearchBar()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    ///Add a SearchBar to the currrent NavigationBar
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.placeholder = "finder.searchBar.placeholder".localized
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    //MARK:- Actions
    
    //MARK:- Navigation
    
}

extension ItemFinderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ItemFinderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemTableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as! ItemTableViewCell
        guard let item = presenter?.itemList[indexPath.row] else {
            return cell
        }
        
        return cell
    }
    
}

extension ItemFinderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            debouncer.invalidateTimer()
            return
        }
        debouncer.handler = {
            self.toggleLoading(isEnable: true)
            self.presenter?.fetchItems(query, 0)
        }
        debouncer.renewTimer()
    }

    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchBarCharacterLimit = 19
        if let searchBarText = searchBar.text, searchBarText.count > searchBarCharacterLimit {
            debouncer.invalidateTimer()
            warningMessage(title: "alert.title.warning".localized, message: "alert.character.limit".localized, actionTitle: "alert.action.ok".localized)
            return false
        }
        return true
    }
    
}

extension ItemFinderViewController: ItemFinderViewDelegate {
    func itemRequestSuccessed() {
        toggleLoading(isEnable: false)
        itemTableView.reloadData()
        guard let presenter = presenter else { return }
        if presenter.itemList.isEmpty {
            self.view.addSubview(itemNotFoundView)
            [itemNotFoundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
             itemNotFoundView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)].forEach{ $0.isActive = true }
        } else {
            itemNotFoundView.removeFromSuperview()
        }
    }
    
    func itemRequestFailed(_ error: Error) {
        toggleLoading(isEnable: false)
        //TODO:- Handle Error
    }
    
    
}
