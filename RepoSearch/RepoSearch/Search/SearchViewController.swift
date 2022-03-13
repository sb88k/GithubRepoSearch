//
//  SearchViewController.swift
//  RepoSearch
//
//  Created by Sun Bin Kim on 13.03.22.
//

import UIKit
import DomainLayer
import Dependencies

final class SearchViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: "RepositoryTableViewCell")
        
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.autocorrectionType = .no
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.placeholder = "Enter Search Text"
        
        controller.searchResultsUpdater = self
        
        return controller
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        spinner.startAnimating()
        
        return spinner
    }()
    
    private lazy var rateLimitedLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Rate Limit Reached"
        
        return label
    }()
    
    private lazy var endOfResultLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "End of Result"
        
        return label
    }()
    
    private var hasMorePage = false
    private var currentQuery: String?
    private var currentPage = 0
    
    private var repositories = [Repository]()
    
    private let dependencies: ViewControllerDependencies
    
    init(dependencies: ViewControllerDependencies) {
        self.dependencies = dependencies
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
}


extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        repositories = []
        
        tableView.reloadData()
        
        guard
            let query = searchController.searchBar.text,
            !query.isEmpty
        else {
            currentQuery = nil
            return
        }
        
        hasMorePage = true
        currentQuery = query
        currentPage = 1
        
        tableView.tableFooterView = loadingIndicator
        
        dependencies.repoSearchUseCase.search(with: query, page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories
                    
                    self?.tableView.reloadData()
                    
                    self?.tableView.tableFooterView = UIView()
                    
                case .failure(let error):
                    if case RepoSearchUseCaseError.noMorePage = error {
                        self?.hasMorePage = false
                        self?.tableView.tableFooterView = self?.endOfResultLabel
                        
                    } else if case RepoSearchUseCaseError.rateLimited = error {
                        self?.tableView.tableFooterView = self?.rateLimitedLabel
                        
                    }
                }
            }
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == repositories.count - 1 {
            guard
                hasMorePage,
                let currentQuery = currentQuery
            else {
                return
            }
            
            tableView.tableFooterView = loadingIndicator
            
            currentPage += 1
            
            dependencies.repoSearchUseCase.search(with: currentQuery, page: currentPage) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let repositories):
                        self?.repositories.append(contentsOf: repositories)
                        
                        self?.tableView.reloadData()
                        
                    case .failure(let error):
                        if case RepoSearchUseCaseError.noMorePage = error {
                            self?.hasMorePage = false
                            
                            self?.tableView.tableFooterView = self?.endOfResultLabel
                            
                        } else if case RepoSearchUseCaseError.rateLimited = error {
                            self?.tableView.tableFooterView = self?.rateLimitedLabel
                            
                        }
                    }
                }
            }
            
        }
        
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        cell.configure(with: repositories[indexPath.row])
        
        return cell
    }
    
}

private extension SearchViewController {
    
    func layout() {
        title = "Github Repo Search"
        
        navigationItem.searchController = searchController
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

