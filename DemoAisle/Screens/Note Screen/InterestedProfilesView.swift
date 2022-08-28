//
//  InterestedProfilesView.swift
//  DemoAisle
//
//  Created by Rakshith on 29/08/22.
//

import Foundation
import UIKit

class InterestedProfilesView: UIView{
    
    private let interestedImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "person_image")
        view.addBlur()
        return view
    }()
    
    private let interestedViewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.text = "Teena"
        view.textColor = .white
        return view
    }()
    
    private let notesView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
        
    init() {
        super.init(frame: .zero)
        buildView()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildView() {
        
        addSubview(notesView)
        [interestedImageView, interestedViewLabel].forEach { notesView.addSubview($0) }
        
        notesView.bringSubviewToFront(interestedImageView)
        notesView.bringSubviewToFront(interestedViewLabel)
        
        NSLayoutConstraint.activate([
            
            notesView.topAnchor.constraint(equalTo: topAnchor),
            notesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            notesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            notesView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            interestedImageView.topAnchor.constraint(equalTo: notesView.topAnchor),
            interestedImageView.leadingAnchor.constraint(equalTo: notesView.leadingAnchor),
            interestedImageView.trailingAnchor.constraint(equalTo: notesView.trailingAnchor),
            interestedImageView.bottomAnchor.constraint(equalTo: notesView.bottomAnchor),
            
            interestedViewLabel.bottomAnchor.constraint(equalTo: notesView.bottomAnchor, constant: -10),
            interestedViewLabel.leadingAnchor.constraint(equalTo: notesView.leadingAnchor, constant: 10),
            interestedViewLabel.trailingAnchor.constraint(equalTo: notesView.trailingAnchor, constant: -10),
        ])
    }
    
    func setImage(image: String) {
        interestedImageView.image = UIImage(named: image)
    }
    
    func setName(name: String) {
        interestedViewLabel.text = name
    }
}

