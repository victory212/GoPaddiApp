//
//  TripDetailViewController.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import UIKit

import UIKit

class TripDetailViewController: UIViewController {
    // MARK: - Properties
    private var trip: Trip
    weak var delegate: CreateTripDelegate?
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.primary
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.CornerRadius.large
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let destinationLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.bold(size: 32)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regular(size: 16)
        label.textColor = .white
        label.alpha = 0.9
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.cardBackground
        view.layer.cornerRadius = Constants.CornerRadius.card
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let budgetIconView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.accent.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let budgetIconLabel: UILabel = {
        let label = UILabel()
        label.text = "💰"
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let budgetTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Budget"
        label.font = Constants.Fonts.medium(size: 14)
        label.textColor = Constants.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let budgetValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.bold(size: 24)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let travelersIconView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.primary.withAlphaComponent(0.1)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let travelersIconLabel: UILabel = {
        let label = UILabel()
        label.text = "👥"
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let travelersTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Travelers"
        label.font = Constants.Fonts.medium(size: 14)
        label.textColor = Constants.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let travelersValueLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.bold(size: 24)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = Constants.Fonts.bold(size: 20)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regular(size: 16)
        label.textColor = Constants.Colors.textSecondary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusBadge: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.success.withAlphaComponent(0.1)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semibold(size: 12)
        label.textColor = Constants.Colors.success
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: CustomButton = {
        let button = CustomButton(title: Constants.Strings.edit, style: .primary)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteButton: CustomButton = {
        let button = CustomButton(title: Constants.Strings.delete, style: .outline)
        button.setTitleColor(Constants.Colors.error, for: .normal)
        button.layer.borderColor = Constants.Colors.error.cgColor
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        populateData()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = Constants.Colors.background
        
        view.addSubview(headerView)
        headerView.addSubview(destinationLabel)
        headerView.addSubview(dateLabel)
        headerView.addSubview(statusBadge)
        statusBadge.addSubview(statusLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(cardView)
        cardView.addSubview(budgetIconView)
        budgetIconView.addSubview(budgetIconLabel)
        cardView.addSubview(budgetTitleLabel)
        cardView.addSubview(budgetValueLabel)
        
        cardView.addSubview(travelersIconView)
        travelersIconView.addSubview(travelersIconLabel)
        cardView.addSubview(travelersTitleLabel)
        cardView.addSubview(travelersValueLabel)
        
        contentView.addSubview(descriptionTitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(deleteButton)
        
        // Navigation setup
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            destinationLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Constants.Spacing.large),
            destinationLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Constants.Spacing.large),
            destinationLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -Constants.Spacing.small),
            
            dateLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Constants.Spacing.large),
            dateLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Constants.Spacing.large),
            dateLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -Constants.Spacing.large),
            
            statusBadge.topAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.topAnchor, constant: Constants.Spacing.medium),
            statusBadge.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Constants.Spacing.large),
            statusBadge.heightAnchor.constraint(equalToConstant: 24),
            
            statusLabel.topAnchor.constraint(equalTo: statusBadge.topAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: statusBadge.leadingAnchor, constant: 12),
            statusLabel.trailingAnchor.constraint(equalTo: statusBadge.trailingAnchor, constant: -12),
            statusLabel.bottomAnchor.constraint(equalTo: statusBadge.bottomAnchor, constant: -4),
            
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Spacing.large),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            cardView.heightAnchor.constraint(equalToConstant: 120),
            
            budgetIconView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Spacing.medium),
            budgetIconView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Spacing.medium),
            budgetIconView.widthAnchor.constraint(equalToConstant: 48),
            budgetIconView.heightAnchor.constraint(equalToConstant: 48),
            
            budgetIconLabel.centerXAnchor.constraint(equalTo: budgetIconView.centerXAnchor),
            budgetIconLabel.centerYAnchor.constraint(equalTo: budgetIconView.centerYAnchor),
            
            budgetTitleLabel.topAnchor.constraint(equalTo: budgetIconView.topAnchor),
            budgetTitleLabel.leadingAnchor.constraint(equalTo: budgetIconView.trailingAnchor, constant: Constants.Spacing.medium),
            
            budgetValueLabel.topAnchor.constraint(equalTo: budgetTitleLabel.bottomAnchor, constant: 4),
            budgetValueLabel.leadingAnchor.constraint(equalTo: budgetIconView.trailingAnchor, constant: Constants.Spacing.medium),
            
            travelersIconView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Spacing.medium),
            travelersIconView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Spacing.medium),
            travelersIconView.widthAnchor.constraint(equalToConstant: 48),
            travelersIconView.heightAnchor.constraint(equalToConstant: 48),
            
            travelersIconLabel.centerXAnchor.constraint(equalTo: travelersIconView.centerXAnchor),
            travelersIconLabel.centerYAnchor.constraint(equalTo: travelersIconView.centerYAnchor),
            
            travelersTitleLabel.topAnchor.constraint(equalTo: travelersIconView.topAnchor),
            travelersTitleLabel.trailingAnchor.constraint(equalTo: travelersIconView.leadingAnchor, constant: -Constants.Spacing.medium),
            
            travelersValueLabel.topAnchor.constraint(equalTo: travelersTitleLabel.bottomAnchor, constant: 4),
            travelersValueLabel.trailingAnchor.constraint(equalTo: travelersIconView.leadingAnchor, constant: -Constants.Spacing.medium),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Constants.Spacing.large),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: Constants.Spacing.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            editButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.Spacing.extraLarge),
            editButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            deleteButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: Constants.Spacing.medium),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Spacing.large)
        ])
    }
    
    // MARK: - Data Population
    private func populateData() {
        destinationLabel.text = trip.destination
        dateLabel.text = trip.dateRange
        budgetValueLabel.text = trip.formattedBudget
        travelersValueLabel.text = String(trip.travelers)
        descriptionLabel.text = trip.description ?? "No description available"
        statusLabel.text = (trip.status ?? "planned").uppercased()
    }
    
    // MARK: - Actions
    @objc private func editButtonTapped() {
        let createVC = CreateTripViewController()
        createVC.setTripToEdit(trip)
        createVC.delegate = self
        let navController = UINavigationController(rootViewController: createVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        let alert = UIAlertController(
            title: "Delete Trip",
            message: "Are you sure you want to delete this trip? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteTrip()
        })
        
        present(alert, animated: true)
    }
    
    private func deleteTrip() {
        guard let tripId = trip.id else { return }
        
        let loadingView = LoadingView(message: "Deleting trip...")
        loadingView.show(in: view)
        
        APIService.shared.deleteTrip(id: tripId) { [weak self] result in
            loadingView.hide()
            
            switch result {
            case .success:
                self?.showSuccessAlert(message: Constants.Strings.tripDeleted) {
                    self?.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Helper Methods
    private func showSuccessAlert(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: Constants.Strings.successTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        })
        present(alert, animated: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: Constants.Strings.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - CreateTripDelegate
extension TripDetailViewController: CreateTripDelegate {
    func didCreateTrip(_ trip: Trip) {
        self.trip = trip
        populateData()
        delegate?.didCreateTrip(trip)
    }
}
