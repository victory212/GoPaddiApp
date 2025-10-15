//
//  CustomComponents.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import Foundation
import UIKit

// MARK: - Custom Button
class CustomButton: UIButton {
    
    enum ButtonStyle {
        case primary
        case secondary
        case outline
    }
    
    private let style: ButtonStyle
    
    init(title: String, style: ButtonStyle = .primary) {
        self.style = style
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        self.style = .primary
        super.init(coder: coder)
        setupButton(title: "Button")
    }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        titleLabel?.font = Constants.Fonts.semibold(size: 16)
        layer.cornerRadius = Constants.CornerRadius.button
        translatesAutoresizingMaskIntoConstraints = false
        
        switch style {
        case .primary:
            backgroundColor = Constants.Colors.primary
            setTitleColor(.white, for: .normal)
        case .secondary:
            backgroundColor = Constants.Colors.secondary
            setTitleColor(Constants.Colors.textPrimary, for: .normal)
        case .outline:
            backgroundColor = .clear
            setTitleColor(Constants.Colors.primary, for: .normal)
            layer.borderWidth = 2
            layer.borderColor = Constants.Colors.primary.cgColor
        }
        
        // Add shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        // Height constraint
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Tap animation
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
    
    func setLoading(_ loading: Bool) {
        isEnabled = !loading
        if loading {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = style == .primary ? .white : Constants.Colors.primary
            activityIndicator.tag = 999
            activityIndicator.startAnimating()
            activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
            addSubview(activityIndicator)
            titleLabel?.alpha = 0
        } else {
            viewWithTag(999)?.removeFromSuperview()
            titleLabel?.alpha = 1
        }
    }
}

// MARK: - Custom Text Field
class CustomTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField() {
        font = Constants.Fonts.regular(size: 16)
        textColor = Constants.Colors.textPrimary
        backgroundColor = Constants.Colors.secondary
        layer.cornerRadius = Constants.CornerRadius.medium
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.border.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Placeholder color
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: Constants.Colors.textSecondary]
        )
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func setError(_ hasError: Bool) {
        UIView.animate(withDuration: Constants.Animation.short) {
            self.layer.borderColor = hasError ? Constants.Colors.error.cgColor : Constants.Colors.border.cgColor
            self.layer.borderWidth = hasError ? 2 : 1
        }
    }
}

// MARK: - Custom Text View
class CustomTextView: UITextView {
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.regular(size: 16)
        label.textColor = Constants.Colors.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
    }
    
    private func setupTextView() {
        font = Constants.Fonts.regular(size: 16)
        textColor = Constants.Colors.textPrimary
        backgroundColor = Constants.Colors.secondary
        layer.cornerRadius = Constants.CornerRadius.medium
        layer.borderWidth = 1
        layer.borderColor = Constants.Colors.border.cgColor
        textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderLabel)
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        delegate = self
    }
}

extension CustomTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}

// MARK: - Loading View
class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = Constants.Colors.primary
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.medium(size: 16)
        label.textColor = Constants.Colors.textSecondary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(message: String = "Loading...") {
        super.init(frame: .zero)
        messageLabel.text = message
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        addSubview(activityIndicator)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func show(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func hide() {
        removeFromSuperview()
    }
}
