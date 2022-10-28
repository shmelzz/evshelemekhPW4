//
//  NoteCell.swift
//  evshelemekhPW4
//
//  Created by Lisa Shell on 11.10.2022.
//

import UIKit

final class NoteCell: UITableViewCell {
    
    static let reuseIdentifier = "NoteCell"
    private var text = UILabel()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell config
    public func configure(note: ShortNote) {
        text.text = note.text
        text.textColor = .black
    }

    // MARK: - View setup
    private func setupView() {
        text.font = .systemFont(ofSize: 14, weight: .regular)
        text.backgroundColor = .clear
        self.contentView.addSubview(text)
        text.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
        text.numberOfLines = 0
    }
}
