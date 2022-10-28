
import UIKit

protocol AddNoteDelegate: AnyObject {
    func newNoteAdded(note: ShortNote)
}

final class AddNoteCell: UITableViewCell {
    
    static let reuseIdentifier = "AddNoteCell"
    private var textView = UITextView()
    private var addButton = UIButton()
    
    var delegate: AddNoteDelegate?
    
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
    
    // MARK: - View setup
    private func setupView() {
        setupInputView()
        setupAddButton()
        
        let stackView = UIStackView(arrangedSubviews: [textView, addButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        stackView.pin(to: contentView, [.left: 16, .top: 16, .right: 16, .bottom: 16])
        contentView.backgroundColor = .systemGray5
    }
    
    private func setupAddButton() {
        addButton.setTitle("Add new note", for: .normal)
        addButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        addButton.setTitleColor(.systemBackground, for: .normal)
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 8
        addButton.setHeight(to: 44)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
    }
    
    private func setupInputView() {
        textView.font = .systemFont(ofSize: 14, weight: .regular)
        textView.textColor = .tertiaryLabel
        textView.backgroundColor = .clear
        textView.setHeight(to: 140)
        textView.isEditable = true
        textView.text = "Type new note"
        textView.delegate = self
    }
    
    // MARK: - Button action
    @objc
    private func addButtonTapped(_ sender: UIButton) {
        if textView.textColor != .tertiaryLabel && textView.text != "" {
            delegate?.newNoteAdded(note: ShortNote(text: textView.text ?? ""))
            clearTextView()
            textView.delegate?.textViewDidEndEditing?(textView)
        }
    }
    
    private func clearTextView() {
        textView.text = nil
    }
}

// MARK: - UITextViewDelegate
extension AddNoteCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .tertiaryLabel {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type new note"
            textView.textColor = .tertiaryLabel
        }
    }
}
