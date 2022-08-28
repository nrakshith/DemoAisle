//
//  NoteViewController.swift
//  DemoAisle
//
//  Created by Rakshith on 28/08/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    private let contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.preservesSuperviewLayoutMargins = true
        view.alwaysBounceVertical = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 25)
        view.text = Copy.notes.value
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private let subTitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.text = Copy.personalMessagesToYou.value
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private let notesView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let noteImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "person_image")
        return view
    }()
    
    private let noteNameLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.text = "Rakshith, 26"
        view.textColor = .white
        return view
    }()
    
    private let noteDescriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 12)
        view.text = Copy.taptoReviewNotes.value
        view.textColor = .white
        return view
    }()
    
    private let interestedSectionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.text = Copy.interestedInYou.value
        view.textColor = .black
        return view
    }()
    
    private let interestedSectionDescription: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.text = Copy.premiumMembersCanViewAllTheirLikesAtOnce.value
        view.textColor = .gray
        view.numberOfLines = 0
        return view
    }()
    
    private let upgradeButton : UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = .yellow
        view.layer.cornerRadius = 18
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.setTitle(Copy.upgrade.value, for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    
    private let interestedView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let interestedLeftImageView: InterestedProfilesView = {
        let view = InterestedProfilesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(image: "person_image")
        view.setName(name: "Teena")
        return view
    }()
    
    private let interestedRightImageView: InterestedProfilesView = {
        let view = InterestedProfilesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(image: "person_image")
        view.setName(name: "Beena")
        return view
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        buildViews()
    }

    private func buildViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [titleLabel, subTitleLabel, notesView, interestedSectionLabel, interestedSectionDescription, upgradeButton, interestedView].forEach{ contentView.addSubview($0) }
        [interestedLeftImageView, interestedRightImageView].forEach { interestedView.addSubview($0) }
        [noteImageView, noteNameLabel, noteDescriptionLabel].forEach{ notesView.addSubview($0) }
                
        notesView.bringSubviewToFront(noteNameLabel)
        notesView.bringSubviewToFront(noteDescriptionLabel)
        
        scrollView.contentInsetAdjustmentBehavior = .automatic
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            notesView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            notesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notesView.heightAnchor.constraint(equalToConstant: view.frame.width - 40),
            
            
            noteImageView.topAnchor.constraint(equalTo: notesView.topAnchor),
            noteImageView.leadingAnchor.constraint(equalTo: notesView.leadingAnchor),
            noteImageView.trailingAnchor.constraint(equalTo: notesView.trailingAnchor),
            noteImageView.bottomAnchor.constraint(equalTo: notesView.bottomAnchor),
            
            noteDescriptionLabel.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: -10),
            noteDescriptionLabel.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 10),
            noteDescriptionLabel.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -10),
            
            noteNameLabel.bottomAnchor.constraint(equalTo: noteDescriptionLabel.topAnchor, constant: -10),
            noteNameLabel.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 10),
            noteNameLabel.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -10),
            
            interestedSectionLabel.topAnchor.constraint(equalTo: notesView.bottomAnchor, constant: 10),
            interestedSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            interestedSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            interestedSectionDescription.topAnchor.constraint(equalTo: interestedSectionLabel.bottomAnchor, constant: 10),
            interestedSectionDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            upgradeButton.centerYAnchor.constraint(equalTo: interestedSectionDescription.centerYAnchor),
            upgradeButton.leadingAnchor.constraint(equalTo: interestedSectionDescription.trailingAnchor, constant: 5),
            upgradeButton.widthAnchor.constraint(equalToConstant: 100),
            upgradeButton.heightAnchor.constraint(equalToConstant: 40),
            upgradeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            
            interestedView.topAnchor.constraint(equalTo: interestedSectionDescription.bottomAnchor, constant: 10),
            interestedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            interestedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            interestedView.heightAnchor.constraint(equalToConstant: 250),
            interestedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            interestedLeftImageView.topAnchor.constraint(equalTo: interestedView.topAnchor),
            interestedLeftImageView.leadingAnchor.constraint(equalTo: interestedView.leadingAnchor),
            interestedLeftImageView.bottomAnchor.constraint(equalTo: interestedView.bottomAnchor),
            
            interestedRightImageView.topAnchor.constraint(equalTo: interestedView.topAnchor),
            interestedRightImageView.leadingAnchor.constraint(equalTo: interestedLeftImageView.trailingAnchor, constant: 5),
            interestedRightImageView.bottomAnchor.constraint(equalTo: interestedView.bottomAnchor),
            interestedRightImageView.trailingAnchor.constraint(equalTo: interestedView.trailingAnchor),
            interestedRightImageView.widthAnchor.constraint(equalTo: interestedLeftImageView.widthAnchor)

        ])
    }
    
}
