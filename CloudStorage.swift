//
//  CloudStorage.swift
//  Week 9
//
//  Created by Thomas Hinrichs on 06/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage()
    private static let notes = "notes"
    
    static func downloadImage(name: String, vc: DetailViewPage) {
        let imgRef = storage.reference(withPath: name)
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if error == nil {
                let img = UIImage(data: data!)
                DispatchQueue.main.async {
                    vc.imageView.image = img
                }
            }else {
                print("Some error downloading \(error.debugDescription)")
            }
        }
    }
    
    static func getSize() -> Int {
        return list.count
    }
    
    static func getNoteAt(index: Int) -> Note {
        return list[index]
    }
    
    static func startListener(tableView: UITableView) {
        print("Starting listener")
        db.collection(notes).addSnapshotListener {(snap, error) in
            if error == nil {
                self.list.removeAll()
                for note in snap!.documents {
                    let map = note.data()
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let image = map["image"] as? String ?? "empty"
                    let newNote = Note(id: note.documentID, head: head, body: body, img: image)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    static func addNote(index: Int, head: String, body: String) {
        var ref: DocumentReference? = nil
        ref = db.collection("notes").addDocument(data: [
            "head": head,
            "body": body,
            "id": index
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    static func deleteNote(id: String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
    static func updateNote(index: Int, head: String, body: String) {
        let note = list[index]
        let docRef = db.collection(notes).document(note.id)
        var map = [String: String]()
        map["head"] = head
        map["body"] = body
        docRef.setData(map)
    }
}
