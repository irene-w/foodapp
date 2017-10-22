//
//  RatingControl.swift
//  TasteBuds
//
//  Created by Irene Woo on 10/21/17.
//  Copyright © 2017 The University of Texas at Austin. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    //MARK: Properties
    private var ratingButtons = [UIButton]()
    var rating = 0
    @IBInspectable var buttonSize: CGSize = CGSize(width: 130.0, height: 50.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var buttonCount: Int = 3 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons() {
        
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // Load Button Images
        let bundle = Bundle(for: type(of: self))
        let totallyWorth = UIImage(named: "totallyWorthIt", in: bundle, compatibleWith: self.traitCollection)
        let kindaWorth = UIImage(named: "kindaWorthIt", in: bundle, compatibleWith: self.traitCollection)
        let notWorth = UIImage(named: "notWorthIt", in: bundle, compatibleWith: self.traitCollection)
        
        addButton(image: notWorth!, tag: 1)
        addButton(image: kindaWorth!, tag: 2)
        addButton(image: totallyWorth!, tag: 3)

    }
    
    func addButton(image: UIImage, tag: Int) {
        // Create button
        let button = UIButton()
        
        // Set the button images
        button.setImage(image, for: .normal)
        
        button.tag = tag
        
        // Add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
        
        // Setup the button action
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        // Add the button to the stack
        addArrangedSubview(button)
        
        // Add the new button to the rating button array
        ratingButtons.append(button)
    }
    
    // Set the rating: 1 for not worth it, 2 kinda worth, 3 worth it
    @objc func ratingButtonTapped(button: UIButton) {
        button.alpha = 1.0
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            
            // If the selected star represents the current rating, reset the rating to 0.
            rating = 0
        } else {
            
            // Otherwise set the rating to the selected star
            rating = selectedRating
        }
        
        for unselectedButton in ratingButtons {
            if (button.tag != unselectedButton.tag) {
                unselectedButton.alpha = 0.5
            }
        }
    }

}
