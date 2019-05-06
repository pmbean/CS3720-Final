//
//  AlertViewController.swift
//  MyWeather
//
//  Created by Patrick Bean on 5/4/19.
//  Copyright © 2019 TheDevBean. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    var titleText: String?
    var iconImage: UIImage?
    var startTime: Date?
    var endTime: Date?
    var descriptionText: String?
    var url: URL?
    
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var warningText: UIButton!
    @IBOutlet weak var warningDescription: UITextView!
    @IBOutlet weak var warningEffective: UILabel!
    @IBOutlet weak var warningExpires: UILabel!
    
    @IBAction func moreInfoButton(_ sender: Any) {
        UIApplication.shared.openURL(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        warningText.setTitle(titleText, for: .normal)
        warningImage.image = iconImage
        warningDescription.text = descriptionText
        warningEffective.text = "\(dateFormatter.string(from: startTime!))"
        warningExpires.text = "\(dateFormatter.string(from: endTime!))"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
