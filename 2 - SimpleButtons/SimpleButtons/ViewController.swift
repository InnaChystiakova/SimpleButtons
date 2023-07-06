//
//  ViewController.swift
//  SimpleButtons
//
//  Created by Инна Чистякова on 04.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let margin: CGFloat = 10
    let topMargin: CGFloat = 60
    let horizontalInset: CGFloat = 14
    let verticalInset: CGFloat = 10
    let imageInset: CGFloat = 8
        
    lazy var buttonOne = simpleButton(
        titleText: "First Button",
        image: UIImage(systemName: "sun.max.fill")
    )
    
    lazy var buttonTwo = simpleButton(
        titleText: "Second Medium Button",
        image: UIImage(systemName: "moon.fill")
    )
    
    lazy var buttonThree = simpleButton(
        titleText: "Third",
        image: UIImage(systemName: "star.fill")
    )
    
    lazy var announcement: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .orange
        label.frame.size = CGSize(width: 200, height: 44)
        label.text = "Здесь могла быть ваша реклама \n (но не захотела)"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    // Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupSubviews()
    }
    
    // Setup
    
    func setupButtons() {

        buttonOne.configurationUpdateHandler = getConfigurationUpdateHandler()
        buttonTwo.configurationUpdateHandler = getConfigurationUpdateHandler()
        buttonThree.configurationUpdateHandler = getConfigurationUpdateHandler()
        
        buttonThree.addAction(buttonAction() , for: .touchUpInside)
    }
    
    func getConfigurationUpdateHandler() -> UIButton.ConfigurationUpdateHandler {
        { button in
            
            switch button.state {
            case .selected,
                 .highlighted:
                
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: [.allowUserInteraction, .curveEaseIn],
                    animations: {
                        button.transform = .init(scaleX: 0.92, y: 0.92)
                    })
                
            case .disabled:
                button.configuration?.baseBackgroundColor = .gray
                
            default:
                
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0,
                    options: [.allowUserInteraction, .curveEaseOut],
                    animations: {
                        button.transform = .identity
                    })
            }
        }
    }
    
    func buttonAction() -> UIAction {
        UIAction { [unowned self] _ in
            let modalViewController = UIViewController()
            
            modalViewController.modalPresentationStyle = .popover
            modalViewController.modalTransitionStyle = .coverVertical
            modalViewController.view.backgroundColor = .purple
            
            modalViewController.view.addSubview(announcement)
            
            announcement.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(
                [
                    announcement.centerXAnchor.constraint(equalTo: modalViewController.view.centerXAnchor),
                    announcement.centerYAnchor.constraint(equalTo: modalViewController.view.centerYAnchor)
                ]
            )
                        
            self.present(modalViewController, animated: true, completion: nil)
        }
    }
    
    func setupSubviews() {
        
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        
        buttonOne.translatesAutoresizingMaskIntoConstraints = false
        buttonTwo.translatesAutoresizingMaskIntoConstraints = false
        buttonThree.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate(
            [
                buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonTwo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonThree.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                buttonOne.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin),
                buttonTwo.topAnchor.constraint(equalTo: buttonOne.bottomAnchor, constant: margin),
                buttonThree.topAnchor.constraint(equalTo: buttonTwo.bottomAnchor, constant: margin)
            ]
        )
    }
    
    // Lazy buttons configuration
    
    private func simpleButton(titleText: String, image: UIImage?) -> UIButton {
        var configuration = UIButton.Configuration.filled()
        configuration.title = titleText
        configuration.buttonSize = .large
        configuration.baseBackgroundColor = .magenta
        configuration.image = image ?? UIImage(systemName: "tortoise.fill")
        configuration.imagePadding = imageInset
        configuration.imagePlacement = .trailing
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: verticalInset,
            leading: horizontalInset,
            bottom: verticalInset,
            trailing: horizontalInset
        )
        
        return UIButton(configuration: configuration, primaryAction: nil)
    }
}

