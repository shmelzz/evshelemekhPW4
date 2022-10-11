//
//  ViewController.swift
//  evshelemekhPW3
//
//  Created by Lisa Shell on 29.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    let incrementButton = UIButton()
    let colorPaletteView = ColorPaletteView()
    private var buttonsStackView = UIStackView()
    
    private var value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Press me", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.applyShadow()
        
        self.view.addSubview(incrementButton)
        
        incrementButton.setHeight(to: 48)
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    
    @objc
    func incrementButtonPressed() {
        value += 1
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    
    private func updateValueLabel() {
        valueLabel.text = "\(value)"
    }
    
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinBottom(to: incrementButton.topAnchor, 16)
        valueLabel.pinCenter(to: self.view.centerXAnchor)
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }
    
    private func setupCommentView() {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom: 16, .right: 16])
        
        updateCommentLabel(value: value)
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "wow"
        case 10...20:
            commentLabel.text = "wow wow"
        case 20...30:
            commentLabel.text = "wow wow wow"
        case 30...40:
            commentLabel.text = "wow wow wow wow"
        case 40...50:
            commentLabel.text = "wow 5️⃣"
        case 50...60:
            commentLabel.text = "wow x6"
        case 60...70:
            commentLabel.text = "70 is getting closer"
        case 70...80:
            commentLabel.text = "get ready"
        case 80...90:
            commentLabel.text = "80+ is ready"
        case 90...100:
            commentLabel.text = "start flying to the moon 💫"
        default:
            break
        }
    }
    
    private func updateUI() {
        updateValueLabel()
        updateCommentLabel(value: self.value)
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    @objc
    func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    @objc
    private func changeColor(_ slider: ColorPaletteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    @objc
    func notesButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
    
    @objc
    func mountButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    private func setupMenuButtons() {
        let paletteButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "🎋")
        let mountButton = makeMenuButton(title: "🌋")
        
        // haptic response for every button
        paletteButton.addTarget(self, action: #selector(paletteButtonPressed), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(notesButtonPressed), for: .touchUpInside)
        mountButton.addTarget(self, action: #selector(mountButtonPressed), for: .touchUpInside)
        
        paletteButton.layer.applyShadow()
        notesButton.layer.applyShadow()
        mountButton.layer.applyShadow()
        
        buttonsStackView = UIStackView(arrangedSubviews: [paletteButton, notesButton, mountButton])
        buttonsStackView.spacing = 12
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        
        self.view.addSubview(buttonsStackView)
        buttonsStackView.pin(to: self.view, [.left: 24, .right: 24])
        buttonsStackView.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor, 24)
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        
        view.addSubview(colorPaletteView)
        
        colorPaletteView.addTarget(self, action: #selector(changeColor), for: [.touchUpInside, .touchDragInside])
        
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24), colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPaletteView.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -8)
        ])
    }
}
