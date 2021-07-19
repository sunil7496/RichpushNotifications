//
//  ViewController.swift
//  RichPushBySunil
//
//  Created by UttamTech on 18/07/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkpushBtn(_ sender: UIButton) {
        sendRequestPush()
    }
    
    func sendRequestPush()  {
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("key=\(Constant.fcmServerKey)", forHTTPHeaderField: "authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = [
            "to":"f0Jjv2yxrU9KtvL7wv1GqX:APA91bFI8j3nAmzoubadCpWYYcXCKMPsXoiW8N1O4nrERUxottGWSeeb7zdf636g4biyYweZoxMjyPet6cOXV9tYEKYzK4IP4DnpurFLVA7IGNuus7LUrUXbKFFO1VO_7tpW2QFEUtRs",
            "notification" : [
                "body" : "Welcome, \nI'm uttam & I'm doing rich push testing.\n\nPlease click here: \nhttps://pic.chinesefontdesign.com/uploads/2017/05/chinesefontdesign.com_2017-05-09_09-22-15.gif",
                "OrganizationId":"2",
                "content_available" : true,
                "priority" : "high",
                "subtitle":"UttamTech",
                "Title":"UttamTech",
                "image": "https://pic.chinesefontdesign.com/uploads/2017/05/chinesefontdesign.com_2017-05-09_09-22-15.gif"
            ],
            "image": "https://pic.chinesefontdesign.com/uploads/2017/05/chinesefontdesign.com_2017-05-09_09-22-15.gif",
            "data" : [
                "priority" : "high",
                "sound":"app_sound.wav",
                "content_available" : true,
                "bodyText" : "New Announcement assigned",
                "organization" :"Elementary school",
                "image": "https://pic.chinesefontdesign.com/uploads/2017/05/chinesefontdesign.com_2017-05-09_09-22-15.gif"
            ]
        ] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request as URLRequest) { data,response,error in
            let httpResponse = response as? HTTPURLResponse
            if (error != nil) {
                print(error!)
            } else {
                print(httpResponse!)
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            do {
                guard let responseDictionary = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                print("The responseDictionary is: " + responseDictionary.description)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            DispatchQueue.main.async {
                //Update your UI here
            }
        }
        dataTask.resume()
    }
}

