//
//  PhoneNumberViewController.swift
//  DemoAisle
//
//  Created by Rakshith on 23/08/22.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneNumberViewController: UIViewController {
    
    struct Dependencies {
        let server: ServerType
    }
    
    private let titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = "Get OTP"
        view.textColor = .black
        return view
    }()
    
    private let enterPhoneNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.text = "Enter Your \nPhone Number"
        view.numberOfLines = 0
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countryCodeTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.textContentType = .telephoneNumber
        view.keyboardType = .numberPad
        return view
    }()
    
    private let phoneTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Phone number"
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        view.textContentType = .telephoneNumber
        view.keyboardType = .numberPad
        return view
    }()
    
    let continueButton : UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = .yellow
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.setTitle("Continue", for: .normal)
        view.titleLabel?.textColor = .white
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    let dependencies: Dependencies
    private let disposeBag = DisposeBag()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
        
        let viewModel = PhoneNumberViewModel(
            dependencies: .init(
                countryCode: countryCodeTextField.rx.text.orEmpty,
                phoneNumber: phoneTextField.rx.text.orEmpty,
                didTapContinueButtton: continueButton.rx.tap,
                server: dependencies.server
            )
        )
        
        viewModel.showOTPScreen
            .observe(on: MainScheduler.instance)
            .bind { [weak self] dependencies in
                let vc = EnterOTPViewController(dependencies: dependencies)
                self?.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
        
        viewModel.isLoading.driveNext {
            let indicator = LoadingIndicator.shared
            $0 ? indicator.show("Loading") : indicator.hide()
        }.disposed(by: disposeBag)
        
        viewModel.errorState.subscribe(onDisposed:  { [weak self] in
            guard let self = self else { return }
            let ac = CancellationAlertController()
            ac.title = "Error"
            ac.message = "Network call failed"
            ac.cancel = .init(title: "Cancel", style: .cancel)
            ac.present(in: self)
        }).disposed(by: disposeBag)

    }

    func buildViews() {
        
        [titleLabel, enterPhoneNumberLabel, countryCodeTextField, phoneTextField, continueButton].forEach{ contentView.addSubview($0) }
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            enterPhoneNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            enterPhoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            enterPhoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            countryCodeTextField.topAnchor.constraint(equalTo: enterPhoneNumberLabel.bottomAnchor, constant: 20),
            countryCodeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryCodeTextField.widthAnchor.constraint(equalToConstant: 30),
            
            phoneTextField.centerYAnchor.constraint(equalTo: countryCodeTextField.centerYAnchor),
            phoneTextField.leadingAnchor.constraint(equalTo: countryCodeTextField.trailingAnchor, constant: 8),
            phoneTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            continueButton.topAnchor.constraint(equalTo: countryCodeTextField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            continueButton.widthAnchor.constraint(equalToConstant: 100)
        ])
            
    }
}

