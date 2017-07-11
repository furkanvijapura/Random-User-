//
//  ViewController.swift
//  APIrandomUser-frk
//
//  Created by PROZON-X on 06/06/17.
//  Copyright © 2017 PROZON-X. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let arrAPI = NSMutableArray()
    
    
    
    @IBOutlet var btnsubmit: UIButton!
    @IBOutlet var lblLastName: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtgender: UITextField!
    @IBOutlet var txtemail: UITextField!
    @IBOutlet var txtnumber: UITextField!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblfirstName: UILabel!

    @IBOutlet var INDECATER: UIActivityIndicatorView!
    @IBOutlet var txtbirthday: UITextField!
    @IBOutlet var txtaddress: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getDataAPI()
        
        INDECATER.startAnimating()
      
       
        imgView.layer.borderWidth = 3.0
        imgView.layer.borderWidth = 5.0
        imgView.layer.masksToBounds = false
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = imgView.frame.size.height/2
        imgView.clipsToBounds = true
        
        btnNext.layer.borderWidth = 3.0
        btnNext.layer.masksToBounds = true
        btnNext.layer.borderColor = UIColor.white.cgColor
        btnNext.layer.cornerRadius = btnNext.frame.size.width/8
        btnNext.clipsToBounds = true
        
        btnsubmit.layer.borderWidth = 3.0
        btnsubmit.layer.masksToBounds = true
        btnsubmit.layer.borderColor = UIColor.white.cgColor
        btnsubmit.layer.cornerRadius = btnNext.frame.size.width/8
        btnsubmit.clipsToBounds = true
    }
    
    @IBOutlet var btnNext: UIButton!
    @IBAction func btnNext(_ sender: UIButton)
    {
        
    
        
        INDECATER.startAnimating()
        
        self.lblfirstName.sizeToFit()
        self.lblTitle.sizeToFit()
        self.lblLastName.sizeToFit()
        
         getDataAPI()
    }
    
    func getDataAPI()
    {
        let urlPath: String = "https://randomuser.me/api/"
        
        let url = URL(string: urlPath)
        
        var urlRequest = URLRequest(url: url!)
        
        let postString = "results"
        
        urlRequest.httpMethod = "Get"
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        // set up the session
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        
        
        
        let task = session.dataTask(with: urlRequest)
        {
            (data, response, error) in
            
            do {
                
                guard let getResponseDic = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    else
                {
                    print("error trying to convert data to JSON")
                    return
                }
                // now we have the todo, let's just print it to prove we can access it
                
                print(getResponseDic as NSDictionary)
                
                let dic = getResponseDic as NSDictionary
                
                let title = (((dic.value(forKey: "results") as! NSArray).object(at: 0) as!  NSDictionary).value(forKey: "name") as! NSDictionary).value(forKey: "title") as! String
                
                let firstName = (((dic.value(forKey: "results") as! NSArray).object(at: 0) as!  NSDictionary).value(forKey: "name") as! NSDictionary).value(forKey: "first") as! String
                
                let lastName = (((dic.value(forKey: "results") as! NSArray).object(at: 0) as!  NSDictionary).value(forKey: "name") as! NSDictionary).value(forKey: "last") as! String
                
                let gender = ((dic.object(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "gender") as! String
                
                let email = ((dic.object(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "email") as! String
                
                let contact = ((dic.object(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "cell") as! String
                
                let DOB = ((dic.object(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "dob") as! String
                
                let adddress1 = (((dic.object(forKey: "results") as!  NSArray).object(at: 0) as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "city") as! String
                let addstreet = (((dic.object(forKey: "results") as!  NSArray).object(at: 0) as! NSDictionary).value(forKey: "location") as! NSDictionary).value(forKey: "street") as! String
                
                let imgprofile = (((dic.object(forKey: "results") as! NSArray).object(at: 0) as! NSDictionary).value(forKey: "picture") as! NSDictionary).value(forKey: "medium") as! String
               
                
                let url = URL(string: imgprofile)
                let data = try? Data(contentsOf: url!)
                
                
                
                self.imgView.image = UIImage(data: data!)
                self.INDECATER.stopAnimating()
                self.INDECATER.hidesWhenStopped  = true
                self.lblfirstName.text = firstName.capitalized
                self.lblLastName.text = lastName.capitalized
                self.lblTitle.text = title.capitalized
                self.txtgender.text = gender.capitalized
                self.txtemail.text = email
                self.txtnumber.text = contact
                self.txtbirthday.text = DOB
                self.txtaddress.text = adddress1
                self.txtaddress.text = addstreet
               
                
                //self.arrAPI.add([title,firstName,lastName,gender,email,contact,DOB,adddress1 + addstreet])
                self.arrAPI.add(title)
               self.arrAPI.add(firstName)
                self.arrAPI.add(lastName)
                self.arrAPI.add(gender)
                self.arrAPI.add(email)
                self.arrAPI.add(contact)
                self.arrAPI.add(DOB)
                self.arrAPI.add(adddress1 + addstreet)
               
                
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            
            
            
            
        }
        
        task.resume()
        
        
        
    }
    
    
    @IBAction func btnSubmit(_ sender: UIButton)
    {
        let story = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        story.api = self.arrAPI
      //  story.ttl = self.title
        
        
        self.navigationController?.pushViewController(story, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

