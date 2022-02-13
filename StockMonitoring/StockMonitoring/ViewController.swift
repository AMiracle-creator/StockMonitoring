//
//  ViewController.swift
//  StockMonitoring
//
//  Created by Амир Гайнуллин on 12.02.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let iconTopAnchor: CGFloat = 64
        static let iconSizeMultiply: CGFloat = 0.1
        static let defaultInset: CGFloat = 16
    }
    
    // MARK: Private

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "alba.png")
        return imageView
    }()
    
    private let companyNameLabel: UILabel = {
        let companyName = UILabel()
        companyName.translatesAutoresizingMaskIntoConstraints = false
        companyName.text = "Company Name"
        return companyName
    }()
    
    private let companyNameValueLabel: UILabel = {
        let companyNameValue = UILabel()
        companyNameValue.translatesAutoresizingMaskIntoConstraints = false
        companyNameValue.text = "Apple"
        return companyNameValue
    }()
    
    private let symbolLabel: UILabel = {
        let symbol = UILabel()
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.text = "Symbol"
        return symbol
    }()
    
    private let symboValuelLabel: UILabel = {
        let symbolValue = UILabel()
        symbolValue.translatesAutoresizingMaskIntoConstraints = false
        symbolValue.text = "AAPL"
        return symbolValue
    }()
    
    private let priceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "Price"
        return price
    }()
    
    private let priceValueLabel: UILabel = {
        let priceValue = UILabel()
        priceValue.translatesAutoresizingMaskIntoConstraints = false
        priceValue.text = "Price"
        return priceValue
    }()
    
    private let priceChangeLabel: UILabel = {
        let priceChange = UILabel()
        priceChange.translatesAutoresizingMaskIntoConstraints = false
        priceChange.text = "Price change"
        return priceChange
    }()
    
    private let priceChangeValueLabel: UILabel = {
        let priceChangeValue = UILabel()
        priceChangeValue.translatesAutoresizingMaskIntoConstraints = false
        priceChangeValue.text = "Price change value"
        return priceChangeValue
    }()
    
    private let companyPicker: UIPickerView = {
        let companyPicker = UIPickerView()
        companyPicker.translatesAutoresizingMaskIntoConstraints = false
        return companyPicker
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegates()
        activateConstraints()
    }


    // MARK: Private methods
    
    private func setupDelegates() {
        companyPicker.delegate = self
        companyPicker.dataSource = self
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(iconView)
        view.addSubview(companyNameLabel)
        view.addSubview(companyNameValueLabel)
        view.addSubview(symbolLabel)
        view.addSubview(symboValuelLabel)
        view.addSubview(companyPicker)
        view.addSubview(priceLabel)
        view.addSubview(priceChangeLabel)
        view.addSubview(priceChangeValueLabel)
        view.addSubview(priceValueLabel)
        companyNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        companyNameValueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.iconTopAnchor),
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.iconSizeMultiply),
            iconView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.iconSizeMultiply),
            companyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultInset),
            companyNameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Constants.defaultInset),
            companyNameValueLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Constants.defaultInset),
            companyNameValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultInset),
            symbolLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultInset),
            symbolLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: Constants.defaultInset),
            symboValuelLabel.topAnchor.constraint(equalTo: companyNameValueLabel.bottomAnchor, constant: Constants.defaultInset),
            symboValuelLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultInset),
            priceLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: Constants.defaultInset),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultInset),
            priceValueLabel.topAnchor.constraint(equalTo: symboValuelLabel.bottomAnchor, constant: Constants.defaultInset),
            priceValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultInset),
            priceChangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultInset),
            priceChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Constants.defaultInset),
            priceChangeValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultInset),
            priceChangeValueLabel.topAnchor.constraint(equalTo: priceValueLabel.bottomAnchor, constant: Constants.defaultInset),
            companyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.defaultInset),
            companyPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            companyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "Test \(row)"
    }
}
