//
//  HomeViewController.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var featureStackView: UIStackView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = Constants.Colors.background
        
        // Title setup
        titleLabel?.text = "Welcome to\nTripPlanner ✈️"
        titleLabel?.font = Constants.Fonts.bold(size: 36)
        titleLabel?.textColor = Constants.Colors.textPrimary
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        
        // Subtitle setup
        subtitleLabel?.text = "Plan your perfect journey with ease"
        subtitleLabel?.font = Constants.Fonts.regular(size: 18)
        subtitleLabel?.textColor = Constants.Colors.textSecondary
        subtitleLabel?.numberOfLines = 0
        subtitleLabel?.textAlignment = .center
        
        // Button setup
        getStartedButton?.backgroundColor = Constants.Colors.primary
        getStartedButton?.setTitle("Get Started", for: .normal)
        getStartedButton?.setTitleColor(.white, for: .normal)
        getStartedButton?.titleLabel?.font = Constants.Fonts.semibold(size: 18)
        getStartedButton?.layer.cornerRadius = Constants.CornerRadius.button
        getStartedButton?.layer.shadowColor = UIColor.black.cgColor
        getStartedButton?.layer.shadowOffset = CGSize(width: 0, height: 4)
        getStartedButton?.layer.shadowRadius = 8
        getStartedButton?.layer.shadowOpacity = 0.15
        
        // Feature stack view setup
        setupFeatures()
    }
    
    private func setupFeatures() {
        featureStackView?.axis = .vertical
        featureStackView?.spacing = Constants.Spacing.medium
        featureStackView?.distribution = .fillEqually
        
        let features = [
            ("📍", "Track Destinations", "Save and organize all your travel destinations"),
            ("💰", "Manage Budget", "Keep track of your travel expenses"),
            ("👥", "Group Travel", "Plan trips with friends and family")
        ]
        
        for feature in features {
            let featureView = createFeatureView(icon: feature.0, title: feature.1, description: feature.2)
            featureStackView?.addArrangedSubview(featureView)
        }
    }
    
    private func createFeatureView(icon: String, title: String, description: String) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = Constants.Colors.cardBackground
        containerView.layer.cornerRadius = Constants.CornerRadius.card
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.08
        
        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 32)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Constants.Fonts.semibold(size: 16)
        titleLabel.textColor = Constants.Colors.textPrimary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descLabel = UILabel()
        descLabel.text = description
        descLabel.font = Constants.Fonts.regular(size: 14)
        descLabel.textColor = Constants.Colors.textSecondary
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        
        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Spacing.medium),
            iconLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Spacing.medium),
            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: Constants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: Constants.Spacing.medium),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.Spacing.medium),
            descLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.Spacing.medium)
        ])
        
        return containerView
    }
    
    private func animateContent() {
        // Animate title
        titleLabel?.alpha = 0
        titleLabel?.transform = CGAffineTransform(translationX: 0, y: -20)
        
        // Animate subtitle
        subtitleLabel?.alpha = 0
        subtitleLabel?.transform = CGAffineTransform(translationX: 0, y: -20)
        
        // Animate button
        getStartedButton?.alpha = 0
        getStartedButton?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        // Animate features
        featureStackView?.alpha = 0
        featureStackView?.transform = CGAffineTransform(translationX: 0, y: 20)
        
        UIView.animate(withDuration: 0.6, delay: 0.1, options: .curveEaseOut) {
            self.titleLabel?.alpha = 1
            self.titleLabel?.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.2, options: .curveEaseOut) {
            self.subtitleLabel?.alpha = 1
            self.subtitleLabel?.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut) {
            self.featureStackView?.alpha = 1
            self.featureStackView?.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.getStartedButton?.alpha = 1
            self.getStartedButton?.transform = .identity
        }
    }
    
    // MARK: - Actions
    @IBAction func getStartedButtonTapped(_ sender: UIButton) {
        // Animate button tap
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }
        
        // Navigate to trip list using storyboard instantiation
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tripListVC = storyboard.instantiateViewController(withIdentifier: "TripListViewController") as? TripListViewController {
            navigationController?.pushViewController(tripListVC, animated: true)
        } else {
            print("ERROR: Could not instantiate TripListViewController")
        }
    }
}
