//
//  HomeVC.swift
//  Netra Pubg Stickers
//
//  Created by Netra Technosys on 29/08/19.
//  Copyright © 2019 NetraTechnosys. All rights reserved.
//

import UIKit
import ARSLineProgress
import NVActivityIndicatorView
//import GoogleMobileAds

class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, NVActivityIndicatorViewable {
    
    var btnTitle = UIButton()
    var strWhatsappAdd : String = ""
    var strImessage:String = ""
//    var interstitial: GADInterstitial!
//    var bannerView: GADBannerView!
    
    @IBOutlet weak var btnAddLoveStckers: UIButton!
    @IBOutlet weak var btnAddFaceStckers: UIButton!
    @IBOutlet weak var btnAddFoodStckers: UIButton!
    @IBOutlet weak var btnAddgameStckers: UIButton!
    @IBOutlet weak var btnAddGiftStckers: UIButton!
    @IBOutlet weak var btnAddbrithdayStckers: UIButton!
    @IBOutlet weak var btnAddcharecterStckers: UIButton!
    @IBOutlet weak var btnAddEmojiStckers: UIButton!
    
    @IBOutlet weak var btnAddTeddyStickers: UIButton!
    @IBOutlet weak var btnAddSelfieStickers: UIButton!
    
    @IBOutlet weak var lastPackView: UIView!
    @IBOutlet weak var loveCollectionView: UICollectionView!
    @IBOutlet weak var faceCollectionView: UICollectionView!
    @IBOutlet weak var foodeCollectionView: UICollectionView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var giftCollectionView: UICollectionView!
    @IBOutlet weak var brithDayCollectionView: UICollectionView!
    @IBOutlet weak var charecterCollectionView: UICollectionView!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var teddyCollectionView: UICollectionView!
    @IBOutlet weak var selfieCollectionView: UICollectionView!
    // view Stickerpack
    
    @IBOutlet weak var viewlovepack: UIView!
    @IBOutlet weak var viewFoodPack: UIView!
    @IBOutlet weak var viewFacePack: UIView!
    @IBOutlet weak var viewGamePack: UIView!
    @IBOutlet weak var viewGiftPack: UIView!
        @IBOutlet weak var viewHbdPack: UIView!
    @IBOutlet weak var viewCharecterPack: UIView!
    
    @IBOutlet weak var viewActionsheetIpad: UIView!
    @IBOutlet weak var viewActionSheet: UIView!
    
    @IBOutlet weak var btnAddtoWhatsUp: UIButton!
    @IBOutlet weak var btnAddToImessage: UIButton!
    @IBOutlet weak var btnAddToimessageIpade: UIButton!
    
    @IBOutlet weak var viewShadow: UIView!
    
    @IBOutlet weak var viewLoveStickerPack: UIView!
    @IBOutlet weak var viewFaceStickerPack: UIView!
    @IBOutlet weak var viewFoodStickerPack: UIView!
    @IBOutlet weak var viewGameStickerPack: UIView!
    @IBOutlet weak var viewGiftStickerPack: UIView!
    @IBOutlet weak var viewBrithdayStickerPack: UIView!
    @IBOutlet weak var viewCharecterStickerPack: UIView!
    @IBOutlet weak var viewEmojiStickerPack: UIView!
    @IBOutlet weak var viewTeddyStickerPack: UIView!
    @IBOutlet weak var viewPackSelfie: UIView!
    @IBOutlet weak var viewSelfieStickerPack: UIView!
    
    @IBOutlet weak var lblFace: UILabel!
    @IBOutlet weak var lblLove: UILabel!
    @IBOutlet weak var lblFood: UILabel!
    @IBOutlet weak var lblGame: UILabel!
    @IBOutlet weak var lblGift: UILabel!
    @IBOutlet weak var lblBrithday: UILabel!
    @IBOutlet weak var lblEmoji: UILabel!
    @IBOutlet weak var lblCharacter: UILabel!
    
    @IBOutlet weak var lblSelfie: UILabel!
    @IBOutlet weak var lblTeddy: UILabel!
    @IBOutlet weak var lblFacePack: UILabel!
    @IBOutlet weak var viewEmojiPack: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var hud: NVActivityIndicatorView!
    
    
    var arryFoodSticker = NSMutableArray()
    var arryFaceSticker = NSMutableArray()
    var arryLoveSticker = NSMutableArray()
    var arryGameSticker = NSMutableArray()
    var arryGiftSticker = NSMutableArray()
    var arryBrithdaySticker = NSMutableArray()
    var arryCharecterSticker = NSMutableArray()
    var arryEmojiSticker = NSMutableArray()
    var arryTeddySticker = NSMutableArray()
    var arrySelfieSticker = NSMutableArray()
    
    private var stickerPacks: [StickerPack] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchStickerPacks()
        let shadowLayer = CALayer()
        
        viewActionSheet.layer.cornerRadius = 22
        viewActionSheet.layer.masksToBounds = true
        
        viewActionsheetIpad.layer.cornerRadius = 22
        viewActionsheetIpad.layer.masksToBounds = true
        
        btnAddtoWhatsUp.layer.cornerRadius = 8
        btnAddToImessage.layer.cornerRadius = 8
        btnAddToimessageIpade.layer.cornerRadius = 8
        
        btnAddToImessage.layer.shadowRadius = 3.0
        btnAddToImessage.layer.shadowOffset = CGSize(width: 4 , height: 4)
        btnAddToImessage.layer.isOpaque = true
        btnAddToImessage.layer.cornerRadius = 6.0
        btnAddToImessage.layer.shadowOpacity = 0.6
        btnAddToImessage.layer.shadowOffset = CGSize(width: 4 , height: 4)
        
        btnAddToimessageIpade.layer.shadowRadius = 3.0
        btnAddToimessageIpade.layer.shadowOffset = CGSize(width: 4 , height: 4)
        btnAddToimessageIpade.layer.isOpaque = true
        btnAddToimessageIpade.layer.cornerRadius = 6.0
        btnAddToimessageIpade.layer.shadowOpacity = 0.6
        btnAddToimessageIpade.layer.shadowOffset = CGSize(width: 4 , height: 4)
        
        shadowLayer.shadowPath = UIBezierPath(roundedRect: btnAddToImessage.bounds, cornerRadius: 5.0).cgPath
        shadowLayer.shadowPath = UIBezierPath(roundedRect: btnAddToimessageIpade.bounds, cornerRadius: 5.0).cgPath
        
        btnAddtoWhatsUp.layer.shadowRadius = 3.0
        btnAddtoWhatsUp.layer.shadowOffset = CGSize(width: 4 , height: 4)
        btnAddtoWhatsUp.layer.isOpaque = true
        btnAddtoWhatsUp.layer.cornerRadius = 6.0
        btnAddtoWhatsUp.layer.shadowOpacity = 0.6
        btnAddtoWhatsUp.layer.shadowOffset = CGSize(width: 4 , height: 4)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: btnAddtoWhatsUp.bounds, cornerRadius: 5.0).cgPath
        
        viewLoveStickerPack.layer.shadowRadius = 3.5
        viewLoveStickerPack.layer.isOpaque = true
        viewLoveStickerPack.layer.cornerRadius = 6.0
        viewLoveStickerPack.layer.shadowOpacity = 0.6
        viewLoveStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewLoveStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewFaceStickerPack.layer.shadowRadius = 3.5
        viewFaceStickerPack.layer.isOpaque = true
        viewFaceStickerPack.layer.cornerRadius = 6.0
        viewFaceStickerPack.layer.shadowOpacity = 0.6
        viewFaceStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewFaceStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewFoodStickerPack.layer.shadowRadius = 3.5
        viewFoodStickerPack.layer.isOpaque = true
        viewFoodStickerPack.layer.cornerRadius = 6.0
        viewFoodStickerPack.layer.shadowOpacity = 0.6
        viewFoodStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewFoodStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewGameStickerPack.layer.shadowRadius = 3.5
        viewGameStickerPack.layer.isOpaque = true
        viewGameStickerPack.layer.cornerRadius = 6.0
        viewGameStickerPack.layer.shadowOpacity = 0.6
        viewGameStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewGameStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewGiftStickerPack.layer.shadowRadius = 3.5
        viewGiftStickerPack.layer.isOpaque = true
        viewGiftStickerPack.layer.cornerRadius = 6.0
        viewGiftStickerPack.layer.shadowOpacity = 0.6
        viewGiftStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewGiftStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewBrithdayStickerPack.layer.shadowRadius = 3.5
        viewBrithdayStickerPack.layer.isOpaque = true
        viewBrithdayStickerPack.layer.cornerRadius = 6.0
        viewBrithdayStickerPack.layer.shadowOpacity = 0.6
        viewBrithdayStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewBrithdayStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewCharecterStickerPack.layer.shadowRadius = 3.5
        viewCharecterStickerPack.layer.isOpaque = true
        viewCharecterStickerPack.layer.cornerRadius = 6.0
        viewCharecterStickerPack.layer.shadowOpacity = 0.6
        viewCharecterStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewCharecterStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewEmojiStickerPack.layer.shadowRadius = 3.5
        viewEmojiStickerPack.layer.isOpaque = true
        viewEmojiStickerPack.layer.cornerRadius = 6.0
        viewEmojiStickerPack.layer.shadowOpacity = 0.6
        viewEmojiStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewEmojiStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewTeddyStickerPack.layer.shadowRadius = 3.5
        viewTeddyStickerPack.layer.isOpaque = true
        viewTeddyStickerPack.layer.cornerRadius = 6.0
        viewTeddyStickerPack.layer.shadowOpacity = 0.6
        viewTeddyStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewTeddyStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        viewSelfieStickerPack.layer.shadowRadius = 3.5
        viewSelfieStickerPack.layer.isOpaque = true
        viewSelfieStickerPack.layer.cornerRadius = 6.0
        viewSelfieStickerPack.layer.shadowOpacity = 0.6
        viewSelfieStickerPack.layer.shadowOffset = CGSize(width: 0.0 , height: 0.0)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewSelfieStickerPack.bounds, cornerRadius: 5.0).cgPath
        
        
        btnAddFaceStckers.imageView?.contentMode = .scaleAspectFit
        btnAddFoodStckers.imageView?.contentMode = .scaleAspectFit
        btnAddLoveStckers.imageView?.contentMode = .scaleAspectFit
        btnAddgameStckers.imageView?.contentMode = .scaleAspectFit
        btnAddGiftStckers.imageView?.contentMode = .scaleAspectFit
        btnAddbrithdayStckers.imageView?.contentMode = .scaleAspectFit
        btnAddcharecterStckers.imageView?.contentMode = .scaleAspectFit
        btnAddEmojiStckers.imageView?.contentMode = .scaleAspectFit
        btnAddTeddyStickers.imageView?.contentMode = .scaleAspectFit
        btnAddSelfieStickers.imageView?.contentMode = .scaleAspectFit
        
        viewActionSheet.isHidden = true
        viewActionsheetIpad.isHidden = true
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            scrollView.contentSize.height = viewPackSelfie.frame.origin.y + viewPackSelfie.frame.size.height - 5
            let Height : CGFloat = scrollView.contentSize.height + 400
            viewShadow.frame.size.height = Height
            viewShadow.isHidden = true
        }
        else
        {
            if self.view.frame.size.height >= 812.0
            {
                scrollView.contentSize.height = viewPackSelfie.frame.origin.y + viewPackSelfie.frame.size.height - 125
            }
            else
            {
                scrollView.contentSize.height = viewPackSelfie.frame.origin.y + viewPackSelfie.frame.size.height - 90
            }
            
            let Height : CGFloat = scrollView.contentSize.height + 400
            viewShadow.frame.size.height = Height
            viewShadow.isHidden = true
        }
        LoadStickerInArry()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if #available(iOS 13.0, *) {
//            if traitCollection.userInterfaceStyle == .light {
//                print("Light mode")
//            } else {
//                print("Dark mode")
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: .myNotificationKey, object: nil) 
        DarkModeObserve()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.viewShadow.addGestureRecognizer(tap)
        
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        btnTitle.titleLabel?.contentMode = .center
        btnTitle = UIButton(type: .custom)
        btnTitle .setTitle("Netra Stickers", for: UIControl.State.normal)
        btnTitle .setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 35.0)
        
        let btnSetting = UIBarButtonItem(image: UIImage(named: "Setting.png"), style: .plain, target: self, action: #selector(btnSettingAction(_:)))
              btnSetting.tintColor = UIColor.white
              self.navigationItem.rightBarButtonItem  = btnSetting
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 28.0)
        }
        else
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 24.0)
        }
        btnTitle.contentHorizontalAlignment = .center
        btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 250)/2), y:10, width:250, height:20)
        
        navigationController?.navigationBar .addSubview(btnTitle)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
       self.navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func DarkModeObserve()
    {
        let nav = self.navigationController?.navigationBar
       
                if UserDefaults.standard.value(forKey: "DarkMode") as? String == "TouchIdoff"
                {
                    nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
                    viewActionSheet.backgroundColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
                    viewActionsheetIpad.backgroundColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
                    viewShadow.backgroundColor = UIColor.white
                    self.view.backgroundColor = UIColor.white
                    nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
                    viewLoveStickerPack.backgroundColor = UIColor.white
                    viewFaceStickerPack.backgroundColor = UIColor.white
                    viewFoodStickerPack.backgroundColor = UIColor.white
                    viewGameStickerPack.backgroundColor = UIColor.white
                    viewCharecterStickerPack.backgroundColor = UIColor.white
                    viewGiftStickerPack.backgroundColor = UIColor.white
                    viewBrithdayStickerPack.backgroundColor = UIColor.white
                    viewEmojiStickerPack.backgroundColor = UIColor.white
                    viewTeddyStickerPack.backgroundColor = UIColor.white
                    viewSelfieStickerPack.backgroundColor = UIColor.white
                    
                    scrollView.backgroundColor = UIColor.white
                    viewlovepack.backgroundColor = UIColor.white
                    lastPackView.backgroundColor = UIColor.white
                    viewEmojiPack.backgroundColor = UIColor.white
                    viewHbdPack.backgroundColor = UIColor.white
                    viewFacePack.backgroundColor = UIColor.white
                    viewFoodPack.backgroundColor = UIColor.white
                    viewGamePack.backgroundColor = UIColor.white
                    viewGiftPack.backgroundColor = UIColor.white
                    viewPackSelfie.backgroundColor = UIColor.white
                    viewCharecterPack.backgroundColor = UIColor.white
                    if (UIDevice.current.userInterfaceIdiom == .pad)
                    {
                        let attributedText1 = NSMutableAttributedString(string: "Love(14)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        attributedText1.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblFacePack.attributedText = attributedText1
                        
                        let faceText = NSMutableAttributedString(string: "Face(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        faceText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblLove.attributedText = faceText
                        
                        let foodText = NSMutableAttributedString(string: "Food(16)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        foodText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblFood.attributedText = foodText
                        
                        let gameText = NSMutableAttributedString(string: "Game(14)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        gameText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblGame.attributedText = gameText
                        
                        let giftText = NSMutableAttributedString(string: "Gift(12)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        giftText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblGift.attributedText = giftText
                        
                        let hbdText = NSMutableAttributedString(string: "Happy Birthday(12)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        hbdText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblBrithday.attributedText = hbdText
                        
                        let charecterText = NSMutableAttributedString(string: "Character(19)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        charecterText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblCharacter.attributedText = charecterText
                        
                        let emojiText = NSMutableAttributedString(string: "Emoji Pack(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        emojiText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblEmoji.attributedText = emojiText
                        
                        let teddyText = NSMutableAttributedString(string: "Teddy(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        teddyText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblTeddy.attributedText = teddyText
                        
                        let selfieText = NSMutableAttributedString(string: "Selfie(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 23)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        selfieText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblSelfie.attributedText = selfieText
                        
                        btnAddToimessageIpade.titleLabel?.font = btnAddToimessageIpade.titleLabel!.font.withSize(20)
                    }
                    else
                    {
                        let attributedText1 = NSMutableAttributedString(string: "Love(14)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        attributedText1.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblFacePack.attributedText = attributedText1
                        
                        let faceText = NSMutableAttributedString(string: "Face(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        faceText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblLove.attributedText = faceText
                        
                        let foodText = NSMutableAttributedString(string: "Food(16)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        foodText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblFood.attributedText = foodText
                        
                        let gameText = NSMutableAttributedString(string: "Game(14)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        gameText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblGame.attributedText = gameText
                        
                        let giftText = NSMutableAttributedString(string: "Gift(12)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        giftText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblGift.attributedText = giftText
                        
                        let hbdText = NSMutableAttributedString(string: "Happy Birthday(12)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        hbdText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblBrithday.attributedText = hbdText
                        
                        let charecterText = NSMutableAttributedString(string: "Character(19)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        charecterText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblCharacter.attributedText = charecterText
                        
                        let emojiText = NSMutableAttributedString(string: "Emoji Pack(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        emojiText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblEmoji.attributedText = emojiText
                        
                        let teddyText = NSMutableAttributedString(string: "Teddy(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        teddyText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblTeddy.attributedText = teddyText
                        
                        let selfieText = NSMutableAttributedString(string: "Selfie(30)", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 20)!,NSAttributedString.Key.foregroundColor:UIColor.black])
                        selfieText.append(NSAttributedString(string: " Stickers", attributes: [NSAttributedString.Key.font: UIFont(name: "Poppins", size: 16)!,NSAttributedString.Key.foregroundColor:UIColor.darkGray]))
                        lblSelfie.attributedText = selfieText
                    }
                   }
                  else
                   {
                    viewActionSheet.backgroundColor = UIColor.black
                    viewActionsheetIpad.backgroundColor = UIColor.black
                    nav?.barTintColor = UIColor.black
                    self.view.backgroundColor = UIColor.black
                    scrollView.backgroundColor = UIColor.black
                    lastPackView.backgroundColor = UIColor.black
                    scrollView.backgroundColor = UIColor.black
                    viewlovepack.backgroundColor = UIColor.black
                    viewEmojiPack.backgroundColor = UIColor.black
                    viewHbdPack.backgroundColor = UIColor.black
                    viewFacePack.backgroundColor = UIColor.black
                    viewFoodPack.backgroundColor = UIColor.black
                    viewGamePack.backgroundColor = UIColor.black
                    viewGiftPack.backgroundColor = UIColor.black
                    viewPackSelfie.backgroundColor = UIColor.black
                    viewCharecterPack.backgroundColor = UIColor.black
                    
                    viewLoveStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewFaceStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewFoodStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewGameStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewCharecterStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewGiftStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewBrithdayStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewEmojiStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewTeddyStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    viewSelfieStickerPack.backgroundColor = UIColor(red: 31.0/255.0, green: 31.0/255.0, blue: 31.0/255.0, alpha: 1.0)
                    
                    
                    lblFacePack.textColor = UIColor.white
                    lblLove.textColor = UIColor.white
                    lblFood.textColor = UIColor.white
                    lblGame.textColor = UIColor.white
                    lblGift.textColor = UIColor.white
                    lblBrithday.textColor = UIColor.white
                    lblCharacter.textColor = UIColor.white
                    lblEmoji.textColor = UIColor.white
                    lblTeddy.textColor = UIColor.white
                    lblSelfie.textColor = UIColor.white
                    
                }
                

    }
    
    @objc func notificationReceived(_ notification: Notification)
       {
           print("sdhijsahdmksandisanfaskasmdfms")
           DarkModeObserve()
       }
    
    private func fetchStickerPacks() {
       
              hud.startAnimating()
//        let loadingAlert: UIAlertController = UIAlertController(title: "Loading sticker packs", message: "\n\n", preferredStyle: .alert)
//        loadingAlert.addSpinner()
//        loadingAlert.show(self, sender: nil)
//        present(loadingAlert, animated: true, completion: nil)
        do {
            try StickerPackManager.fetchStickerPacks(fromJSON: StickerPackManager.stickersJSON(contentsOfFile: "sticker_packs")) { stickerPacks in
                if stickerPacks.count > 0
                {
                    self.navigationController?.navigationBar.alpha = 1.0;
                    self.stickerPacks = stickerPacks
                    self.hud.stopAnimating()
//                    if ARSLineProgress.shown { return }
//                    self.viewShadow.isHidden = false
//                    self.viewShadow.isUserInteractionEnabled = false
//                    self.scrollView.isScrollEnabled = false
//                    progressObject = Progress(totalUnitCount: 1)
//                    ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
//                        print("Success completion block")
//                        self.viewShadow.isUserInteractionEnabled = true
//                        self.scrollView.isScrollEnabled = true
//                        self.viewShadow.isHidden = true
//                        self.navigationController?.navigationBar.alpha = 1.0;
//                        self.stickerPacks = stickerPacks
//                    })
//                    self.progressDemoHelper(success: true)
//                    loadingAlert.dismiss(animated: false, completion: {
//                        self.navigationController?.navigationBar.alpha = 1.0;
//                        self.stickerPacks = stickerPacks
//                    })
                }
                else
                {
//                    loadingAlert.dismiss(animated: false, completion: {
//                        self.navigationController?.navigationBar.alpha = 1.0;
//                    })
                }
            }
        } catch StickerPackError.fileNotFound {
            fatalError("sticker_packs.wasticker not found.")
        } catch {
            fatalError(error.localizedDescription)
        }
//        loadingAlert.dismiss(animated: false, completion: {
////            self.navigationController?.navigationBar.alpha = 1.0;
//        })
    }
    @IBAction func btnSettingAction(_ sender: AnyObject)
      {
        let settingVc :UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        let navSetting = UINavigationController.init(rootViewController: settingVc)
        self.present(navSetting, animated: true, completion: nil)
    }
    func adsLoad()
    {
        self.tabBarController?.tabBar.isHidden = true
        actionsheeetAnimation()
    }
    
    func LoadStickerInArry()
    {
        for i in 1..<15
        {
            let imageString = "love\(i).png"
            arryLoveSticker.add(imageString)
        }
        
        for i in 1..<31
        {
            let imageString = "face\(i).png"
            arryFaceSticker.add(imageString)
        }
        
        for i in 1..<17
        {
            let imageString = "food\(i).png"
            arryFoodSticker.add(imageString)
        }
        
        for i in 1..<15
        {
            let imageString = "game\(i).png"
            arryGameSticker.add(imageString)
        }
        
        for i in 1..<13
        {
            let imageString = "gift\(i).png"
            arryGiftSticker.add(imageString)
        }
        
        for i in 1..<13 {
            let imageString = "hbd\(i).png"
            arryBrithdaySticker.add(imageString)
        }
        
        for i in 1..<20
        {
            let imageString = "character\(i).png"
            arryCharecterSticker.add(imageString)
        }
        for i in 1..<30
        {
            let imageString = "emoji\(i).png"
            arryEmojiSticker.add(imageString)
        }
        for i in 1..<18
        {
            let imageString = "teddy\(i).png"
            arryTeddySticker.add(imageString)
        }
        for i in 1..<30
        {
            let imageString = "selfie\(i).png"
            arrySelfieSticker.add(imageString)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        btnTitle.removeFromSuperview()
        navigationController?.navigationBar.isTranslucent = true
        NotificationCenter.default.removeObserver(self)
    }
    
    //btn add to WhatsUp
    @IBAction func btnAddToLovePack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Love"
        strImessage = "Love"
    }
    
    @IBAction func btnAddToFacePack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Face"
        strImessage = "Face"
    }
    
    @IBAction func btnAddToFoodPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Food"
        strImessage = "Food"
    }
    
    @IBAction func btnAddToGamePack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Game"
        strImessage = "Game"
    }
    
    @IBAction func btnAddToGiftPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Gift"
        strImessage = "Gift"
    }
    
    @IBAction func btnAddToBrithDayPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "BrithDay"
        strImessage = "BrithDay"
    }
    
    @IBAction func btnAddToCharecterPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Charecter"
        strImessage = "Charecter"
    }
    @IBAction func btnAddToEmojiPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Emoji Pack"
        strImessage = "Emoji Pack"
    }
    @IBAction func btnAddToTeddyPack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Teddy Pack"
        strImessage = "Teddy Pack"
    }
    
    @IBAction func btnAddToSelfiePack(_ sender: Any)
    {
        adsLoad()
        strWhatsappAdd = "Selfie Pack"
        strImessage = "Selfie Pack"
    }
    
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil)
    {
        self.tabBarController?.tabBar.isHidden = false
        strWhatsappAdd = ""
        actionsheeetBackAnimation()
    }
    
    func actionsheeetBackAnimation()
    {
        UIView.animate(withDuration: 0.4, delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        if (UIDevice.current.userInterfaceIdiom == .pad)
                        {
                            self.viewActionsheetIpad.layer.position.y += UIScreen.main.bounds.height - self.viewActionsheetIpad.frame.size.height - self.viewActionsheetIpad.frame.size.height + 30
                        }
                        else
                        {
                            self.viewActionSheet.layer.position.y += UIScreen.main.bounds.height - self.viewActionSheet.frame.size.height - self.viewActionSheet.frame.size.height + 30
                        }
        }, completion: nil)
        self.viewShadow.isHidden = true
    }
    
    func actionsheeetBackiMessageAnimation()
    {
        UIView.animate(withDuration: 0.4, delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        
                        if (UIDevice.current.userInterfaceIdiom == .pad)
                        {
                            self.viewActionsheetIpad.layer.position.y += UIScreen.main.bounds.height - self.viewActionsheetIpad.frame.size.height - self.viewActionsheetIpad.frame.size.height + 30
                        }
                        else
                        {
                            self.viewActionSheet.layer.position.y += UIScreen.main.bounds.height - self.viewActionSheet.frame.size.height - self.viewActionSheet.frame.size.height + 30
                        }
                        
        }, completion: nil)
    }
  
    func actionsheeetAnimation()
    {
        viewShadow.isHidden = false
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            viewActionsheetIpad.isHidden = false
            UIView.animate(withDuration: 0.5)
            {
                self.viewActionsheetIpad.frame.origin.y = self.view.frame.height - self.viewActionsheetIpad.frame.height - 15
            }
        }
        else
        {
            viewActionSheet.isHidden = false
            UIView.animate(withDuration: 0.5)
            {
                self.viewActionSheet.frame.origin.y = self.view.frame.height - self.viewActionSheet.frame.height - 15
            }
        }
    }
    
    @IBAction func btnActionWhatsUpAdd(_ sender: Any)
    {
        if strWhatsappAdd == "Love"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[0].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
            //            openApp(appName: "whatsapp")
        }
        else if strWhatsappAdd == "Face"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[1].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
            //            openApp(appName: "whatsapp")
            
        }
        else if strWhatsappAdd == "Food"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[2].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "Game"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[3].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
            
        }
        else if strWhatsappAdd == "Gift"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[4].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "BrithDay"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[5].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "Charecter"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[6].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "Emoji Pack"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[7].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "Teddy Pack"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[8].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else if strWhatsappAdd == "Selfie Pack"
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[9].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
        else
        {
            let loadingAlert: UIAlertController = UIAlertController(title: "Sending to WhatsApp", message: "\n\n", preferredStyle: .alert)
            loadingAlert.addSpinner()
            present(loadingAlert, animated: true, completion: nil)
            
            stickerPacks[2].sendToWhatsApp { completed in
                loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func btnActionimessageAdd(_ sender: Any)
    {
        if ARSLineProgress.shown { return }
        self.viewShadow.isUserInteractionEnabled = false
        self.scrollView.isScrollEnabled = false
        progressObject = Progress(totalUnitCount: 1)
        
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
            self.viewShadow.isUserInteractionEnabled = true
            self.scrollView.isScrollEnabled = true
            self.viewShadow.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        })
        progressDemoHelper(success: true)
    }
    
    @IBAction func btnActionImessageForIpad(_ sender: Any)
    {
        if ARSLineProgress.shown { return }
        self.viewShadow.isUserInteractionEnabled = false
        self.scrollView.isScrollEnabled = false
        progressObject = Progress(totalUnitCount: 1)
        
        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
            print("Success completion block")
            self.viewShadow.isUserInteractionEnabled = true
            self.scrollView.isScrollEnabled = true
            self.viewShadow.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
        })
        progressDemoHelper(success: true)
    }
    
    //CollectionView Delegate and DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1001
        {
            return arryLoveSticker.count
        }
        else if collectionView.tag == 1002
        {
            return arryFaceSticker.count
        }
        else if collectionView.tag == 1003
        {
            return arryFoodSticker.count
        }
        else if collectionView.tag == 1004
        {
            return arryGameSticker.count
        }
        else if collectionView.tag == 1005
        {
            return arryGiftSticker.count
        }
        else if collectionView.tag == 1006
        {
            return arryBrithdaySticker.count
        }
        else if collectionView.tag == 1007
        {
            return arryBrithdaySticker.count
        }
        else if collectionView.tag == 1008
        {
            return arryEmojiSticker.count
        }
        else if collectionView.tag == 1009
        {
            return arryTeddySticker.count
        }
        else if collectionView.tag == 2000
        {
            return arrySelfieSticker.count
        }
        else
        {
            return arryEmojiSticker.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView.tag == 1001
        {
            let srickePackCell1:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell1", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell1.viewWithTag(101) as! UIImageView
            imgCharecter.image = UIImage(named: arryLoveSticker[indexPath.row] as! String)
            
            return srickePackCell1
        }
        if collectionView.tag == 1002
        {
            let srickePackCell2:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell2", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell2.viewWithTag(102) as! UIImageView
            imgCharecter.image = UIImage(named: arryFaceSticker[indexPath.row] as! String)
            
            return srickePackCell2
        }
        if collectionView.tag == 1003
        {
            let srickePackCell3:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell3", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell3.viewWithTag(103) as! UIImageView
            imgCharecter.image = UIImage(named: arryFoodSticker[indexPath.row] as! String)
            
            return srickePackCell3
        }
        if collectionView.tag == 1004
        {
            let srickePackCell4:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell4", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell4.viewWithTag(104) as! UIImageView
            imgCharecter.image = UIImage(named: arryGameSticker[indexPath.row] as! String)
            
            return srickePackCell4
        }
        if collectionView.tag == 1005
        {
            let srickePackCell5:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell5", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell5.viewWithTag(105) as! UIImageView
            imgCharecter.image = UIImage(named: arryGiftSticker[indexPath.row] as! String)
            
            return srickePackCell5
        }
        if collectionView.tag == 1006
        {
            let srickePackCell6:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell6", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell6.viewWithTag(106) as! UIImageView
            imgCharecter.image = UIImage(named: arryBrithdaySticker[indexPath.row] as! String)
            
            return srickePackCell6
        }
        else if collectionView.tag == 1007
        {
            let srickePackCell7:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell7", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell7.viewWithTag(107) as! UIImageView
            imgCharecter.image = UIImage(named: arryCharecterSticker[indexPath.row] as! String)
            
            return srickePackCell7
        }
        else if collectionView.tag == 1008
        {
            let srickePackCell8:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell8", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell8.viewWithTag(108) as! UIImageView
            imgCharecter.image = UIImage(named: arryEmojiSticker[indexPath.row] as! String)
            
            return srickePackCell8
        }
        else if collectionView.tag == 1009
        {
            let srickePackCell8:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell9", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell8.viewWithTag(109) as! UIImageView
            imgCharecter.image = UIImage(named: arryTeddySticker[indexPath.row] as! String)
            
            return srickePackCell8
        }
        else if collectionView.tag == 2000
        {
            let srickePackCell8:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell10", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell8.viewWithTag(200) as! UIImageView
            imgCharecter.image = UIImage(named: arrySelfieSticker[indexPath.row] as! String)
            
            return srickePackCell8
        }
        else
        {
            let srickePackCell8:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "srickePackCell8", for: indexPath)
            let imgCharecter:UIImageView = srickePackCell8.viewWithTag(108) as! UIImageView
            imgCharecter.image = UIImage(named: arryEmojiSticker[indexPath.row] as! String)
            
            return srickePackCell8
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1001
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
          
            pushVC.isFrom = "Love"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1002
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Face"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1003
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Food"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1004
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Game"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1005
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Gift"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1006
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Happy BrithDay"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1007
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Character"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1008
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Emoji"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 1009
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Teddy"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
        if collectionView.tag == 2000
        {
            let pushVC = self.storyboard!.instantiateViewController(withIdentifier: "StickerpackContainerVC") as! StickerpackContainerVC
            pushVC.isFrom = "Selfie"
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
    }
}
private var progressObject: Progress?
private var isSuccess: Bool?

extension HomeVC {
    
    fileprivate func progressDemoHelper(success: Bool) {
        isSuccess = success
        ars_launchTimer()
        actionsheeetBackiMessageAnimation()
    }
    
    fileprivate func ars_launchTimer() {
        let dispatchTime = DispatchTime.now() + Double(Int64(0.7 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC);
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            progressObject!.completedUnitCount += Int64(arc4random_uniform(30))
            
            if isSuccess == false && progressObject?.fractionCompleted >= 0.7 {
                ARSLineProgress.cancelProgressWithFailAnimation(true, completionBlock: {
                    print("Hidden with completion block")
                })
                return
            } else {
                if progressObject?.fractionCompleted >= 1.0 { return }
            }
            self.ars_launchTimer()
        })
    }
    
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):    return l < r
    case (nil, _?):        return true
    default:            return false
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):    return l >= r
    default:            return !(lhs < rhs)
    }
    
}

class TabBar: UITabBar {
    override var traitCollection: UITraitCollection {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            return super.traitCollection
        }
        
        return UITraitCollection(horizontalSizeClass: .compact)
    }
}
