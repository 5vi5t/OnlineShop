//
//  ProfileViewImpl.swift
//  GBShop
//
//  Created by Константин on 28.03.2023.
//

import UIKit

protocol ProfileView: UIView {
    var onConfirm: VoidClosure? { get set }
}

final class ProfileViewImpl: UIView, ProfileView {
    // MARK: - Properties
    private var isConfirm = false

    var onConfirm: VoidClosure?

    // MARK: - UI Properties
    private(set) lazy var userView: UserView = {
        let view = UserView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textFieldsIsEnabled(false)
        return view
    }()
    private lazy var editAndConfirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        let action = UIAction { [weak self] _ in
            self?.buttonTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                userView,
                editAndConfirmButton
            ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = .zero
        return label
    }()

    // MARK: - Construction
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func buttonTapped() {
        if isConfirm {
            onConfirm?()
            userView.textFieldsIsEnabled(false)
            editAndConfirmButton.setTitle("Edit", for: .normal)
            isConfirm = false
        } else {
            userView.textFieldsIsEnabled()
            editAndConfirmButton.setTitle("Confirm", for: .normal)
            isConfirm = true
        }
    }

    private func setup() {
        configureUI()
    }
    private func configureUI() {
        backgroundColor = .white
        setupConstraints()
    }
    private func setupConstraints() {
        addSubview(stackView)
        addSubview(errorLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            errorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}
