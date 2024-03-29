//
//  SecondGrid.swift
//  Projet4
//
//  Created by Damien Rojo on 22/08/2019.
//  Copyright © 2019 damien. All rights reserved.
//

import UIKit

final class SecondGrid: UIView, GridType {

    // Mark: - Outlets

    @IBOutlet private var contentView: UIView!

    @IBOutlet private weak var upperPictureView: UIView!
    @IBOutlet private weak var bottomLeftPictureView: UIView!
    @IBOutlet private weak var bottomRightPictureView: UIView!

    @IBOutlet private weak var upperButton: UIButton!
    @IBOutlet private weak var bottomLeftButton: UIButton!
    @IBOutlet private weak var bottomRightButton: UIButton!

    // Mark: - Properties

    private var viewModel: GridViewModel!

    private weak var delegate: GridDelegate?

    // Mark: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize()  {
        Bundle(for: type(of: self)).loadNibNamed(String(describing: SecondGrid.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // Mark: - Action

    func set(image: UIImage, for spot: Spot) {
        let imageView = UIImageView(image: image)
        switch spot {
        case .top:
            upperButton.removeAllSubviews()
            upperButton.addSubview(imageView)
            makePictureConstraints(for: imageView, with: upperButton)
        case .bottomLeft:
            bottomLeftButton.removeAllSubviews()
            bottomLeftButton.addSubview(imageView)
            makePictureConstraints(for: imageView, with: bottomLeftButton)
        case .bottomRight:
            bottomRightButton.removeAllSubviews()
            bottomRightButton.addSubview(imageView)
            makePictureConstraints(for: imageView, with: bottomRightButton)
        default: break
        }
    }
    
    private func makePictureConstraints(for image: UIImageView, with button: UIButton ) {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: button.leftAnchor),
            image.rightAnchor.constraint(equalTo: button.rightAnchor),
            image.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            image.topAnchor.constraint(equalTo: button.topAnchor)
        ])
    }

    func configure(with viewModelType: GridViewModel, delegate: GridDelegate) {
        self.viewModel = viewModelType
        self.delegate = delegate

        bind(to: self.viewModel)
    }

    private func bind(to viewModel: GridViewModel) {
        viewModel.selectedSpot = { [weak self] spot in
            self?.delegate?.didSelect(spot: spot)
        }
    }

    @IBAction func selectSpot(_ sender: UIButton) {
        viewModel.didSelectSpot(at: sender.tag)
    }
}
