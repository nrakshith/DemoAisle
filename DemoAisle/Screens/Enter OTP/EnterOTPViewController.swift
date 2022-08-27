//
//  EnterOTPViewController.swift
//  DemoAisle
//
//  Created by Rakshith on 27/08/22.
//

import UIKit
import RxSwift
import RxCocoa


class EnterOTPViewController: UIViewController {
    
    struct Dependencies {
        let phoneNumber: PhoneNumber
        let server: ServerType
    }
    
    private let phoneNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = "Get OTP"
        view.textColor = .black
        return view
    }()
    
    private let editPhoneButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(.add, for: .normal)
        return view
    }()
    
    private let enterOTPNumberLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.text = "Enter the \nOTP"
        view.numberOfLines = 0
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let enterOTPTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 2
        view.textContentType = .oneTimeCode
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
    
    let otpTimer : UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.text = "00:00"
        view.textColor = .black
        view.textAlignment = .left
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViews()
                
        let viewModel = EnterOTPViewModel(
            dependencies: .init(
                phoneNumber: dependencies.phoneNumber,
                otp: enterOTPTextField.rx.text.orEmpty,
                didTapContinueButtton: continueButton.rx.tap,
                didTapEditPhoneButton: editPhoneButton.rx.tap,
                server: dependencies.server
            )
        )

        viewModel.showTabBarScreen
            .observe(on: MainScheduler.instance)
            .bind { [weak self] dependencies in
                let vc = TabBarController()
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
        
        [phoneNumberLabel, editPhoneButton, enterOTPNumberLabel, enterOTPTextField, otpTimer,continueButton].forEach{ contentView.addSubview($0) }
        view.addSubview(contentView)
        
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            editPhoneButton.centerYAnchor.constraint(equalTo: phoneNumberLabel.centerYAnchor),
            editPhoneButton.leadingAnchor.constraint(equalTo: phoneNumberLabel.trailingAnchor, constant: 8),
            editPhoneButton.heightAnchor.constraint(equalToConstant: 10),
            editPhoneButton.widthAnchor.constraint(equalToConstant: 10),

            enterOTPNumberLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            enterOTPNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            enterOTPNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            
            enterOTPTextField.topAnchor.constraint(equalTo: enterOTPNumberLabel.bottomAnchor, constant: 20),
            enterOTPTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            enterOTPTextField.widthAnchor.constraint(equalToConstant: 60),
            
            continueButton.topAnchor.constraint(equalTo: enterOTPTextField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            continueButton.widthAnchor.constraint(equalToConstant: 100),
            
            otpTimer.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor),
            otpTimer.leadingAnchor.constraint(equalTo: continueButton.trailingAnchor, constant: 8),
            otpTimer.widthAnchor.constraint(equalToConstant: 100)
        ])
            
    }
}
