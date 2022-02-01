//
//  CoreDataManager.swift
//  NotesApp
//
//  Created by Andrei Panasenko on 31.01.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "NotesApp")
    
    let persistantContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    init(modelName: String) {
        persistantContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistantContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
}


// MARK: - ext

extension CoreDataManager {
    func createNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = ""
        note.lastUpdated = Date()
        save()
        return note
    }
    
    func createFirstNote() -> Note {
        let note = Note(context: viewContext)
        note.id = UUID()
        note.text = """
                    Привет!
                    Это первая заметка.
                    Тут будет текст.
                    """
        note.lastUpdated = Date()
        save()
        return note
    }

    func fetchNotes(filter: String? = nil) -> [Note] {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Note.lastUpdated, ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        if let filter = filter {
            let predicate = NSPredicate(format: "text contains[cd] %@", filter)
            request.predicate = predicate
        }
        
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteNote(_ note: Note) {
        viewContext.delete(note)
        save()
    }
    
}

