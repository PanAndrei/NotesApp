//
//  EditNoteViewController.swift
//  NotesApp
//
//  Created by Andrei Panasenko on 30.01.2022.
//

import UIKit

class EditNoteViewController: UIViewController {
    
    static let identifier = "EditNoteViewController"
    
    var note: Note!
    weak var delegate: ListNotesDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
