//
//  NotesViewController.swift
//  evshelemekhPW4
//
//  Created by Lisa Shell on 11.10.2022.
//

import UIKit

final class NotesViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: [ShortNote] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - View setup
    private func setupView() {
        setupTableView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.title = "Notes"
    }
    
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.pin(to: self.view)
    }
}

// MARK: - UITableViewDataSource
extension NotesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(
                withIdentifier: AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        default:
            let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
                                                                NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                noteCell.configure(note: note)
                return noteCell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(indexPath: indexPath)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        delete.image = UIImage(systemName: "trash")
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

// MARK: - AddNoteDelegate
extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}
