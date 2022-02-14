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
        static let activityIndicatorTopAnchor: CGFloat = 64

    }
    
    private let companies: [String: String] = ["Apple": "AAPL","Microsoft": "MSFT",
                                               "Google": "GOOG", "Amazon": "AMZN", "Facebook": "FB"]
    
    // MARK: Private

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        return priceChangeValue
    }()
    
    private let companyPicker: UIPickerView = {
        let companyPicker = UIPickerView()
        companyPicker.translatesAutoresizingMaskIntoConstraints = false
        return companyPicker
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegates()
        activateConstraints()
        
        self.activityIndicator.hidesWhenStopped = true
        
        self.requestQuoteUpdate()
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
        view.addSubview(activityIndicator)
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
            activityIndicator.topAnchor.constraint(equalTo: priceChangeLabel.bottomAnchor, constant: Constants.activityIndicatorTopAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            companyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.defaultInset),
            companyPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            companyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func requestQuote(for symbol: String) {
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?&token=" + "pk_d723958d1ae7468a8a9b123180795903")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response,  error in
            guard
               error == nil,
               (response as? HTTPURLResponse)?.statusCode == 200,
               let data = data
            else {
                print("Network error")
                return
            }

            self.parseQuote(data: data)
        }
        
        dataTask.resume()
    }
    
    private func requestIcon(for symbol: String) {
        let url = URL(string:  "https://cloud.iexapis.com/stable/stock/\(symbol)/logo?&token=pk_d723958d1ae7468a8a9b123180795903")!
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response,  error in
            guard
               error == nil,
               (response as? HTTPURLResponse)?.statusCode == 200,
               let data = data
            else {
                print("Network error")
                return
            }
            
            self.downloadIcon(data: data)
        }
        
        dataTask.resume()
    }
    
    private func downloadIcon(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let url = json["url"] as? String,
                let url = URL(string: url)
            else {
                print("Invalid JSON Format")
                return
            }
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.iconView.image = UIImage(data: data!)
                    }
            }
            
        } catch {
            print("JSON parsing error: " + error.localizedDescription)

        }
    }
    
    private func parseQuote(data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let companySymbol = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let priceChange = json["change"] as? Double
            else {
                print("Invalid JSON Format")
                return
            }
            DispatchQueue.main.async {
                self.displayStockInfo(companyName: companyName,
                                      symbol: companySymbol,
                                      price: price,
                                      priceChange: priceChange)
            }
            
            print("Company name is: '\(companyName)'")
        } catch {
            print("JSON parsing error: " + error.localizedDescription)
        }
    }
    
    private func displayStockInfo(companyName: String, symbol: String, price: Double, priceChange: Double) {
        self.activityIndicator.stopAnimating()
        self.companyNameValueLabel.text = companyName
        self.symboValuelLabel.text = symbol
        self.priceValueLabel.text = "\(price)"
        self.priceChangeValueLabel.text = "\(priceChange)"
    }
    
    private func requestQuoteUpdate() {
        self.activityIndicator.startAnimating()
        self.companyNameValueLabel.text = "-"
        self.symboValuelLabel.text = "-"
        self.priceValueLabel.text = "-"
        self.priceChangeValueLabel.text = "-"
        
        let selectedRow = self.companyPicker.selectedRow(inComponent: 0)
        let selectedSymbol = Array(self.companies.values)[selectedRow]
        self.requestQuote(for: selectedSymbol)
        self.requestIcon(for: selectedSymbol)
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.companies.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Array(self.companies.keys)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.activityIndicator.startAnimating()
        
        let selectedSymbol = Array(self.companies.values)[row]
        self.requestQuote(for: selectedSymbol)
        self.requestIcon(for: selectedSymbol)
    }
}
