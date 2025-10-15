//
//  TripTableViewCell.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import Foundation
import UIKit

class TripTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.cardBackground
        view.layer.cornerRadius = Constants.CornerRadius.card
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.08
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let destinationLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.bold(size: 20)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regular(size: 14)
        label.textColor = Constants.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let budgetLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let travelersLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regular(size: 14)
        label.textColor = Constants.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusBadge: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.success.withAlphaComponent(0.1)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semibold(size: 10)
        label.textColor = Constants.Colors.success
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Colors.primary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Constants.Colors.textSecondary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(cardView)
        cardView.addSubview(iconImageView)
        cardView.addSubview(destinationLabel)
        cardView.addSubview(dateLabel)
        cardView.addSubview(budgetLabel)
        cardView.addSubview(travelersLabel)
        cardView.addSubview(statusBadge)
        statusBadge.addSubview(statusLabel)
        cardView.addSubview(chevronImageView)
        
        iconImageView.image = UIImage(systemName: "airplane")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Spacing.small),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Spacing.small),
            
            iconImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.Spacing.medium),
            iconImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            destinationLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Spacing.medium),
            destinationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.Spacing.medium),
            destinationLabel.trailingAnchor.constraint(equalTo: statusBadge.leadingAnchor, constant: -Constants.Spacing.small),
            
            dateLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.Spacing.medium),
            dateLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Constants.Spacing.small),
            
            budgetLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.Spacing.small),
            budgetLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.Spacing.medium),
            budgetLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Constants.Spacing.medium),
            
            travelersLabel.centerYAnchor.constraint(equalTo: budgetLabel.centerYAnchor),
            travelersLabel.leadingAnchor.constraint(equalTo: budgetLabel.trailingAnchor, constant: Constants.Spacing.medium),
            
            statusBadge.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.Spacing.medium),
            statusBadge.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Constants.Spacing.small),
            statusBadge.heightAnchor.constraint(equalToConstant: 20),
            
            statusLabel.topAnchor.constraint(equalTo: statusBadge.topAnchor, constant: 3),
            statusLabel.leadingAnchor.constraint(equalTo: statusBadge.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: statusBadge.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: statusBadge.bottomAnchor, constant: -3),
            
            chevronImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.Spacing.medium),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Configuration
    func configure(with trip: Trip) {
        destinationLabel.text = trip.destination
        dateLabel.text = trip.dateRange
        budgetLabel.text = trip.formattedBudget
        travelersLabel.text = "• \(trip.travelersText)"
        statusLabel.text = (trip.status ?? "planned").uppercased()
        
        // Animate on appearance
        cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: Constants.Animation.medium, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            self.cardView.transform = .identity
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        destinationLabel.text = nil
        dateLabel.text = nil
        budgetLabel.text = nil
        travelersLabel.text = nil
        statusLabel.text = nil
    }
}
