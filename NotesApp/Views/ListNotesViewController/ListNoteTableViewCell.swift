//
//  ListNoteTableViewCell.swift
//  NotesApp
//
//  Created by Andrei Panasenko on 30.01.2022.
//

import UIKit

class ListNoteTableViewCell: UITableViewCell {

 static let indentifier = "ListNoteTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setup(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.description
    }

}
