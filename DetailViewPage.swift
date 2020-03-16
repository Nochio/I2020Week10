//
//  DetailViewPage.swift
//  Week 9
//
//  Created by Thomas Hinrichs on 06/03/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//
import UIKit

class DetailViewPage: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headLine: UITextView!
    @IBOutlet weak var body: UITextView!
    var rowNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let note = CloudStorage.getNoteAt(index: rowNumber)
        headLine.text = note.head
        body.text = note.body
        if note.image != "empty" {
            CloudStorage.downloadImage(name: note.image, vc: self)
        } else {
            print("Note is empty")
        }
    }
    
    @IBAction func updateButtonPressed(_ sender: UIBarButtonItem) {
        print("Update Button pressed")
        CloudStorage.updateNote(index: self.rowNumber, head: self.headLine.text!, body: self.body.text!)
    }
    
    @IBAction func downloadBtnPressed(_ sender: UIButton) {
        //CloudStorage.downloadImage(name: images.randomElement()!, vc: self)
        print("Download Button pressed")
    }
}
