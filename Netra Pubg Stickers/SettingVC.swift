//
//  SettingVC.swift
//  
//
//  Created by Netra Technosys on 16/09/19.
//

import UIKit
import StoreKit
import MessageUI
import AdSupport

class SettingVC: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate
{
    
    @IBOutlet weak var tblSetting: UITableView!
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblversion: UILabel!
    
    let dictSupport : NSMutableDictionary = ["Setting":"Need Support","Setting_Image":"Support.png"]
    let dictRateApp : NSMutableDictionary = ["Setting":"Rate Netra Stickers","Setting_Image":"Like.png"]
    let dictShareApp : NSMutableDictionary = ["Setting":"Share With Friend(s)","Setting_Image":"Share.png"]
    let dictFeedBack : NSMutableDictionary = ["Setting":"FeedBack","Setting_Image":"Support.png"]
    let dictBusinessInquiry: NSMutableDictionary = ["Setting":"Business Inquiry","Setting_Image":"BusinessInquiry.png"]
    
    var btnTitle = UIButton()
    var btnRight = UIButton()
    var arraySetting = NSMutableArray()
    var DarkMode:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        arraySetting.add(dictRateApp)
        arraySetting.add(dictShareApp)
        arraySetting.add(dictSupport)
        arraySetting.add(dictFeedBack)
        arraySetting.add(dictBusinessInquiry)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        let nav = self.navigationController?.navigationBar
        
        if UserDefaults.standard.value(forKey: "DarkMode") as? String == "TouchIdoff"
        {
            DarkMode = "Off"
            lblversion.textColor = UIColor.black
            nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            UINavigationBar.appearance().backgroundColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            viewMain.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
            tblSetting.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        }
        else
        {
            DarkMode = "On"
            lblversion.textColor = UIColor.white
            nav?.barTintColor = UIColor.black
            self.view.backgroundColor = UIColor.black
            viewMain.backgroundColor = UIColor.black
            tblSetting.backgroundColor = UIColor.black
        }
        
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        btnTitle.titleLabel?.contentMode = .center
        btnTitle = UIButton(type: .custom)
        btnTitle .setTitle("Settings", for: UIControl.State.normal)
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 28.0)
        }
        else
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 24.0)
        }
        
        btnRight.setTitle("Done",for: .normal)
        btnRight.titleLabel?.font = UIFont(name:"Poppins", size: 21.0)
        btnRight.frame.size = CGSize(width: 50, height: 40)
        btnRight.setTitleColor(UIColor.white, for: .normal)
        btnRight.addTarget(self, action: #selector(btnRightAction(_:)), for: .touchUpInside)
        let barButtonRight = UIBarButtonItem(customView: btnRight)
        self.navigationItem.rightBarButtonItem  = barButtonRight
        btnTitle .setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTitle.contentHorizontalAlignment = .center
        
        if #available(iOS 13.0, *)
        {
            btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 100)/2), y:20, width:100, height:20)
        }
        else
        {
            btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 100)/2), y:10, width:100, height:20)
        }
        
        navigationController?.navigationBar .addSubview(btnTitle)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        tblSetting.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        NotificationCenter.default.post(name: .myNotificationKey, object: nil)
        self.navigationController?.navigationBar.isHidden = false
        btnTitle.removeFromSuperview()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let viewSectionTitle = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: 15))
        
        if section == 0
        {
            let lblTitle = UILabel(frame: CGRect(x: 10, y: 5, width: Int(tableView.bounds.width - 30), height: 15))
            if DarkMode == "On"
            {
                viewSectionTitle.backgroundColor = UIColor.black
                lblTitle.textColor = UIColor.white
            }else
            {
                viewSectionTitle.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)
                lblTitle.textColor = UIColor.black
            }
            lblTitle.font = UIFont(name: "Poppins", size: 15.0)
            switch section {
            case 0:
                lblTitle.text = "DARK MODE"
            default:
                lblTitle.text = ""
            }
            
            viewSectionTitle.addSubview(lblTitle)
            
            return viewSectionTitle
        }
        else
        {
            if DarkMode == "On"
            {
                viewSectionTitle.backgroundColor = UIColor.black
            }else
            {
                viewSectionTitle.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1)
            }
            return viewSectionTitle
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            return 70
        }
        else
        {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return 1
        }
        else
        {
            return arraySetting.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cellDarkMode = tableView.dequeueReusableCell(withIdentifier: "cellDarkMode", for: indexPath )
            let lblDarkMode:UILabel = (cellDarkMode.contentView.viewWithTag(300) as? UILabel)!
            lblDarkMode.text = "Dark Mode"
            let DarkModeSwitch = cellDarkMode.contentView.viewWithTag(500) as? UISwitch
            if DarkMode == "On"
            {
                cellDarkMode.contentView.backgroundColor =  UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                DarkModeSwitch?.tintColor = UIColor.white
                DarkModeSwitch?.onTintColor = UIColor.black
                lblDarkMode.textColor = UIColor.white
            }
            else
            {
                cellDarkMode.contentView.backgroundColor =  UIColor.white
                lblDarkMode.textColor = UIColor.black
                DarkModeSwitch?.tintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
                DarkModeSwitch?.onTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            }
            
            if UserDefaults.standard.value(forKey: "DarkMode") as? String == "TouchIdoff"
            {
                DarkModeSwitch?.setOn(false, animated:true)
            }
            else
            {
                DarkModeSwitch?.setOn(true, animated:true)
            }
            
            DarkModeSwitch?.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: .valueChanged)
            return cellDarkMode
        }
        else
        {
            let cellSettingOption = tableView.dequeueReusableCell(withIdentifier: "cellSettingOption", for: indexPath )
            // cellSettingOption.backgroundColor = UIColor.black
            var dictSetting = NSMutableDictionary()
            dictSetting = NSMutableDictionary(dictionary: arraySetting.object(at: (indexPath.row)) as! NSDictionary)
            
            let lblSttingType = cellSettingOption.contentView.viewWithTag(302) as? UILabel
            let imgSetting = cellSettingOption.contentView.viewWithTag(301) as? UIImageView
            imgSetting?.image = UIImage(named: dictSetting.value(forKey: "Setting_Image") as! String)
            if DarkMode == "On"
            {
                lblSttingType?.textColor = UIColor.white
                cellSettingOption.contentView.backgroundColor =  UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
            }
            else
            {
                cellSettingOption.contentView.backgroundColor =  UIColor.white
                lblSttingType?.textColor = UIColor.black
                imgSetting!.image = imgSetting!.image?.withRenderingMode(.alwaysTemplate)
                imgSetting!.tintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                lblSttingType?.text = dictSetting.value(forKey: "Setting") as? String
            })
            return cellSettingOption
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                if #available( iOS 10.3,*)
                {
                    SKStoreReviewController.requestReview()
                }
                else
                {
                    //                    UIApplication.shared.openURL(NSURL(string: "https://itunes.apple.com/us/app/netra-smart/id1330466544?mt=8?action=write-review")! as URL)
                }
            }
            if indexPath.row == 1
            {
                let activityViewController = UIActivityViewController(activityItems : ["https://apps.apple.com/us/app/netra-stickers/id1478507420"], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                self.present(activityViewController, animated: true, completion: nil)
            }
            
            if indexPath.row == 2
            {
                autoreleasepool {
                    
                    let composer = MFMailComposeViewController()
                    
                    if MFMailComposeViewController.canSendMail() {
                        composer.mailComposeDelegate = self
                        composer.setToRecipients(["contact@netratechnosys.com"])
                        composer.setSubject("Netra Stickers - Support")
                        composer.setMessageBody("", isHTML: false)
                        present(composer, animated: true, completion: nil)
                    } else if let emailUrl = createEmailUrl(to: "contact@netratechnosys.com", subject: "Netra Stickers - Support", body: "") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(emailUrl)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
                
            }
            
            if indexPath.row == 3
            {
                autoreleasepool {
                    
                    let composer = MFMailComposeViewController()
                    
                    if MFMailComposeViewController.canSendMail() {
                        composer.mailComposeDelegate = self
                        composer.setToRecipients(["contact@netratechnosys.com"])
                        composer.setSubject("Netra Stickers - FeedBack - v.1.0.2)")
                        composer.setMessageBody("", isHTML: false)
                        present(composer, animated: true, completion: nil)
                    }  else if let emailUrl = createEmailUrl(to: "contact@netratechnosys.com", subject: "Netra Stickers - FeedBack - v.1.0.2", body: "") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(emailUrl)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
            }
            if indexPath.row == 4
            {
                autoreleasepool {
                    let composer = MFMailComposeViewController()
                    if MFMailComposeViewController.canSendMail()
                    {
                        composer.mailComposeDelegate = self
                        composer.setToRecipients(["dharmesh@netratechnosys.com"])
                        composer.setSubject("Netra Stickers - Business Inquiry")
                        composer.setMessageBody("", isHTML: false)
                        present(composer, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    @IBAction func btnRightAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: .myNotificationKey, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func switchValueDidChange(sender:UISwitch!)
    {
        let nav = self.navigationController?.navigationBar
        
        if (sender.isOn == true)
        {
            //                dictTouchID.setValue("0", forKey: "Selected")
            UserDefaults . standard .set("TouchIdon", forKey: "DarkMode")
            self.view.backgroundColor = UIColor.black
            lblversion.textColor = UIColor.white
            nav?.barTintColor = UIColor.black
            viewMain.backgroundColor = UIColor.black
            DarkMode = "On"
            tblSetting.reloadData()
            tblSetting.backgroundColor = UIColor.black
        }
        else
        {
            // dictTouchID.setValue("1", forKey: "Selected")
            UserDefaults . standard .set("TouchIdoff", forKey: "DarkMode")
            nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            self.view.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
            viewMain.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
            DarkMode = "Off"
            tblSetting.backgroundColor = UIColor(red: 236.0/255.0, green: 236.0/255.0, blue: 236.0/255.0, alpha: 1.0)
            lblversion.textColor = UIColor.black
            tblSetting.reloadData()
        }
    }
    
    //MARK: Email URl Create function
    func createEmailUrl(to: String, subject: String, body: String) -> URL?
    {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl)
        {
            return gmailUrl
        }
        else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl)
        {
            return outlookUrl
        }
        else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail)
        {
            return yahooMail
        }
        else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl)
        {
            return sparkUrl
        }
        
        return defaultUrl
    }
}

extension Notification.Name
{
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
    public static let stikernotification = Notification.Name(rawValue: "stikernotification")
    public static let stickerRemove = Notification.Name(rawValue: "stickerRemove")
    
    public static let hideGradiantButton = Notification.Name(rawValue: "HideGradiantButton")
    public static let showGradiantButton = Notification.Name(rawValue: "ShowGradiantButton")
    
    public static let showNavDoneButton = Notification.Name(rawValue: "showNavDoneButton")
    public static let doneButtonAction = Notification.Name(rawValue: "doneButtonAction")
    
    public static let hideEditorWhenItClose = Notification.Name(rawValue: "hideEditorWhenItClose")
    
    public static let changeSliderLayoutWhenKeyboardOpen = Notification.Name(rawValue: "changeSliderLayoutWhenKeyboardOpen")
    
    public static let navButtonHideShow = Notification.Name(rawValue: "navButtonHideShow")
    public static let galleryNavButtonHideShow = Notification.Name(rawValue: "galleryNavButtonHideShow")
    public static let manageEditorControllerTool = Notification.Name(rawValue: "manageEditorControllerTool")
}
