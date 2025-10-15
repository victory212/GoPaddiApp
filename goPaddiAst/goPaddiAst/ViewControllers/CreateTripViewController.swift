//
//  CreateTripViewController.swift
//  goPaddiAst
//
//  Created by Okoi Victory Ebri on 14/10/2025.
//

import UIKit


protocol CreateTripDelegate: AnyObject {
    func didCreateTrip(_ trip: Trip)
}

class CreateTripViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: CreateTripDelegate?
    private var tripToEdit: Trip?
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create New Trip"
        label.font = Constants.Fonts.bold(size: 28)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let destinationLabel: UILabel = {
        let label = UILabel()
        label.text = "Destination"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var destinationTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Constants.Strings.destinationPlaceholder
        textField.autocapitalizationType = .words
        return textField
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Start Date"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startDateTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "YYYY-MM-DD"
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)
        textField.inputView = datePicker
        return textField
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.text = "End Date"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endDateTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "YYYY-MM-DD"
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)
        textField.inputView = datePicker
        return textField
    }()
    
    private let budgetLabel: UILabel = {
        let label = UILabel()
        label.text = "Budget ($)"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var budgetTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Constants.Strings.budgetPlaceholder
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let travelersLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of Travelers"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var travelersTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = Constants.Strings.travelersPlaceholder
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description (Optional)"
        label.font = Constants.Fonts.semibold(size: 16)
        label.textColor = Constants.Colors.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionTextView: CustomTextView = {
        let textView = CustomTextView()
        textView.placeholder = Constants.Strings.descriptionPlaceholder
        return textView
    }()
    
    private lazy var createButton: CustomButton = {
        let button = CustomButton(title: Constants.Strings.create, style: .primary)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: CustomButton = {
        let button = CustomButton(title: Constants.Strings.cancel, style: .outline)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let loadingView = LoadingView(message: "Creating trip...")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupKeyboardHandling()
        
        if let trip = tripToEdit {
            populateFields(with: trip)
            titleLabel.text = "Edit Trip"
            createButton.setTitle(Constants.Strings.update, for: .normal)
        }
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = Constants.Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(destinationLabel)
        contentView.addSubview(destinationTextField)
        contentView.addSubview(startDateLabel)
        contentView.addSubview(startDateTextField)
        contentView.addSubview(endDateLabel)
        contentView.addSubview(endDateTextField)
        contentView.addSubview(budgetLabel)
        contentView.addSubview(budgetTextField)
        contentView.addSubview(travelersLabel)
        contentView.addSubview(travelersTextField)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextView)
        contentView.addSubview(createButton)
        contentView.addSubview(cancelButton)
        
        // Add toolbar for done button on keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        budgetTextField.inputAccessoryView = toolbar
        travelersTextField.inputAccessoryView = toolbar
        startDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputAccessoryView = toolbar
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Spacing.large),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            destinationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Spacing.large),
            destinationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            destinationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            destinationTextField.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: Constants.Spacing.small),
            destinationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            destinationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            startDateLabel.topAnchor.constraint(equalTo: destinationTextField.bottomAnchor, constant: Constants.Spacing.medium),
            startDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            startDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            startDateTextField.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: Constants.Spacing.small),
            startDateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            startDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            endDateLabel.topAnchor.constraint(equalTo: startDateTextField.bottomAnchor, constant: Constants.Spacing.medium),
            endDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            endDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            endDateTextField.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: Constants.Spacing.small),
            endDateTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            endDateTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            budgetLabel.topAnchor.constraint(equalTo: endDateTextField.bottomAnchor, constant: Constants.Spacing.medium),
            budgetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            budgetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            budgetTextField.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: Constants.Spacing.small),
            budgetTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            budgetTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            travelersLabel.topAnchor.constraint(equalTo: budgetTextField.bottomAnchor, constant: Constants.Spacing.medium),
            travelersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            travelersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            travelersTextField.topAnchor.constraint(equalTo: travelersLabel.bottomAnchor, constant: Constants.Spacing.small),
            travelersTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            travelersTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: travelersTextField.bottomAnchor, constant: Constants.Spacing.medium),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.Spacing.small),
            descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 100),
            
            createButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: Constants.Spacing.extraLarge),
            createButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            createButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            
            cancelButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: Constants.Spacing.medium),
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Spacing.medium),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Spacing.medium),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Spacing.large)
        ])
    }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @objc private func startDateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateTextField.text = formatter.string(from: sender.date)
        
        if let endPicker = endDateTextField.inputView as? UIDatePicker {
            endPicker.minimumDate = sender.date
        }
    }
    
    @objc private func endDateChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        endDateTextField.text = formatter.string(from: sender.date)
    }
    
    @objc private func createButtonTapped() {
        guard validateFields() else { return }
        
        let tripRequest = CreateTripRequest(
            destination: destinationTextField.text!,
            startDate: startDateTextField.text!,
            endDate: endDateTextField.text!,
            budget: Double(budgetTextField.text!) ?? 0,
            travelers: Int(travelersTextField.text!) ?? 1,
            description: descriptionTextView.text.isEmpty ? nil : descriptionTextView.text,
            status: "planned"
        )
        
        loadingView.show(in: view)
        createButton.setLoading(true)
        
        if let trip = tripToEdit, let id = trip.id {
            updateTrip(id: id, request: tripRequest)
        } else {
            createTrip(request: tripRequest)
        }
    }
    
    private func createTrip(request: CreateTripRequest) {
        APIService.shared.createTrip(trip: request) { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.hide()
            self.createButton.setLoading(false)
            
            switch result {
            case .success(let trip):
                self.showSuccessAlert(message: Constants.Strings.tripCreated) {
                    self.delegate?.didCreateTrip(trip)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func updateTrip(id: String, request: CreateTripRequest) {
        APIService.shared.updateTrip(id: id, trip: request) { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.hide()
            self.createButton.setLoading(false)
            
            switch result {
            case .success(let trip):
                self.showSuccessAlert(message: Constants.Strings.tripUpdated) {
                    self.delegate?.didCreateTrip(trip)
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                self.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        scrollView.contentInset.bottom = keyboardFrame.height
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    // MARK: - Helper Methods
    private func validateFields() -> Bool {
        var isValid = true
        
        if destinationTextField.text?.isEmpty ?? true {
            destinationTextField.setError(true)
            isValid = false
        } else {
            destinationTextField.setError(false)
        }
        
        if startDateTextField.text?.isEmpty ?? true {
            startDateTextField.setError(true)
            isValid = false
        } else {
            startDateTextField.setError(false)
        }
        
        if endDateTextField.text?.isEmpty ?? true {
            endDateTextField.setError(true)
            isValid = false
        } else {
            endDateTextField.setError(false)
        }
        
        if budgetTextField.text?.isEmpty ?? true || Double(budgetTextField.text!) == nil {
            budgetTextField.setError(true)
            isValid = false
        } else {
            budgetTextField.setError(false)
        }
        
        if travelersTextField.text?.isEmpty ?? true || Int(travelersTextField.text!) == nil {
            travelersTextField.setError(true)
            isValid = false
        } else {
            travelersTextField.setError(false)
        }
        
        if !isValid {
            showErrorAlert(message: Constants.Strings.validationError)
        }
        
        return isValid
    }
    
    private func populateFields(with trip: Trip) {
        destinationTextField.text = trip.destination
        startDateTextField.text = trip.startDate
        endDateTextField.text = trip.endDate
        budgetTextField.text = String(trip.budget)
        travelersTextField.text = String(trip.travelers)
        descriptionTextView.text = trip.description
    }
    
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
    
    // MARK: - Public Methods
    func setTripToEdit(_ trip: Trip) {
        self.tripToEdit = trip
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
