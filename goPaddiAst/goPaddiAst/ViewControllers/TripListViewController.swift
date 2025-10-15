//
//  TripListViewController.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import UIKit

import UIKit

class TripListViewController: UIViewController {
    
    // MARK: - IBOutlets (Connect these in Storyboard)
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: - Properties
    private var trips: [Trip] = []
    private let refreshControl = UIRefreshControl()
    private let loadingView = LoadingView(message: "Loading trips...")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadTrips()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "My Trips"
        view.backgroundColor = Constants.Colors.background
        
        // Configure navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add button setup (if created programmatically)
        let addBarButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addBarButton
        
        // If addButton is from storyboard
        addButton?.layer.cornerRadius = Constants.CornerRadius.button
        addButton?.backgroundColor = Constants.Colors.primary
        addButton?.setTitleColor(.white, for: .normal)
        addButton?.titleLabel?.font = Constants.Fonts.semibold(size: 16)
        
        // Empty state setup
        emptyStateView?.isHidden = true
        emptyStateLabel?.text = "No trips yet!\nTap + to create your first trip"
        emptyStateLabel?.textAlignment = .center
        emptyStateLabel?.numberOfLines = 0
        emptyStateLabel?.font = Constants.Fonts.regular(size: 16)
        emptyStateLabel?.textColor = Constants.Colors.textSecondary
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = Constants.Colors.background
        tableView?.separatorStyle = .none
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = 120
        
        // Register cell
        tableView?.register(TripTableViewCell.self, forCellReuseIdentifier: Constants.Identifiers.tripCell)
        
        // Pull to refresh
        refreshControl.addTarget(self, action: #selector(refreshTrips), for: .valueChanged)
        tableView?.refreshControl = refreshControl
    }
    
    // MARK: - Data Loading
    private func loadTrips() {
        loadingView.show(in: view)
        
        APIService.shared.getAllTrips { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.hide()
            self.refreshControl.endRefreshing()
            
            switch result {
            case .success(let trips):
                self.trips = trips
                self.updateUI()
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @objc private func refreshTrips() {
        loadTrips()
    }
    
    private func updateUI() {
        tableView?.reloadData()
        emptyStateView?.isHidden = !trips.isEmpty
        tableView?.isHidden = trips.isEmpty
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        showCreateTripScreen()
    }
    
    private func showCreateTripScreen() {
        let createVC = CreateTripViewController()
        createVC.delegate = self
        let navController = UINavigationController(rootViewController: createVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: - Helper Methods
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: Constants.Strings.errorTitle,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.loadTrips()
        })
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension TripListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.tripCell,
            for: indexPath
        ) as? TripTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: trips[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TripListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let trip = trips[indexPath.row]
        let detailVC = TripDetailViewController(trip: trip)
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.deleteTrip(at: indexPath)
            completion(true)
        }
        
        deleteAction.backgroundColor = Constants.Colors.error
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completion in
            self?.editTrip(at: indexPath)
            completion(true)
        }
        
        editAction.backgroundColor = Constants.Colors.primary
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    private func deleteTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        
        guard let tripId = trip.id else { return }
        
        let alert = UIAlertController(
            title: "Delete Trip",
            message: "Are you sure you want to delete '\(trip.destination)'?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.performDelete(tripId: tripId, at: indexPath)
        })
        
        present(alert, animated: true)
    }
    
    private func performDelete(tripId: String, at indexPath: IndexPath) {
        loadingView.show(in: view)
        
        APIService.shared.deleteTrip(id: tripId) { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.hide()
            
            switch result {
            case .success:
                self.trips.remove(at: indexPath.row)
                self.tableView?.deleteRows(at: [indexPath], with: .fade)
                self.updateUI()
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func editTrip(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        let createVC = CreateTripViewController()
        createVC.setTripToEdit(trip)
        createVC.delegate = self
        let navController = UINavigationController(rootViewController: createVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
}

// MARK: - CreateTripDelegate
extension TripListViewController: CreateTripDelegate {
    func didCreateTrip(_ trip: Trip) {
        loadTrips()
    }
}
