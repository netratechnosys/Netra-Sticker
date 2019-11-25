//
//  StickerpackContainerVC.swift
//  Netra Pubg Stickers
//
//  Created by Developer 3 on 13/02/19.
//  Copyright © 2019 NetraTechnosys. All rights reserved.
//

import UIKit

class StickerpackContainerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var viewStickerpackContainer : UIView!
    @IBOutlet var viewTitleImg : UIView!
    @IBOutlet weak var viewHeader: UIView!

    @IBOutlet var imgTitle : UIImageView!
    
    @IBOutlet var lblTitle : UILabel!
    
    @IBOutlet var collectionStickerpack : UICollectionView!
    
    var arryLoveSticker = NSMutableArray()
    var arryFaceSticker = NSMutableArray()
    var arryFoodSticker = NSMutableArray()
    var arryGiftSticker = NSMutableArray()
    var arryBrithdaySticker = NSMutableArray()
    var arryCharecterSticker = NSMutableArray()
    var arryEmojiSticker = NSMutableArray()
    var arryGameSticker = NSMutableArray()
    var arryTeddySticker = NSMutableArray()
    var arrySelfieSticker = NSMutableArray()
    
    var btnTitle = UIButton()

    var isFrom : String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let shadowLayer = CALayer()
        viewTitleImg.layer.shadowRadius = 3.0
        viewTitleImg.layer.shadowOffset = CGSize(width: 4 , height: 4)
        viewTitleImg.layer.isOpaque = true
        viewTitleImg.layer.cornerRadius = 8.0
        viewTitleImg.layer.shadowOpacity = 0.6
        viewTitleImg.layer.shadowOffset = CGSize(width: 4 , height: 4)
        shadowLayer.shadowPath = UIBezierPath(roundedRect: viewTitleImg.bounds, cornerRadius: 5.0).cgPath
        
        viewStickerpackContainer.layer.cornerRadius = 8.0
        viewStickerpackContainer.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.tabBarController?.tabBar.isHidden = true
        
        let nav = self.navigationController?.navigationBar
        
        if UserDefaults.standard.value(forKey: "DarkMode") as? String == "TouchIdoff"
        {
            self.view.backgroundColor = UIColor.white
            nav?.barTintColor = UIColor(red: 37.0/255.0, green: 67.0/255.0, blue: 82.0/255.0, alpha: 1.0)
            lblTitle.textColor = UIColor.black
            viewStickerpackContainer.backgroundColor = UIColor.white
            viewHeader.backgroundColor = UIColor.white
        }
        else
        {
            viewHeader.backgroundColor = UIColor.black
            self.view.backgroundColor = UIColor.black
            nav?.barTintColor = UIColor.black
             viewStickerpackContainer.backgroundColor = UIColor.black
            lblTitle.textColor = UIColor.white
        }
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        
        btnTitle.titleLabel?.contentMode = .center
        btnTitle = UIButton(type: .custom)
        btnTitle .setTitle("Netra Stickers", for: UIControl.State.normal)
        btnTitle .setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnTitle.titleLabel?.font =  UIFont(name: "Amaranth", size: 35.0)
        
        if (UIDevice.current.userInterfaceIdiom == .pad)
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 28.0)
            imgTitle.frame.origin.x = -30
            lblTitle.frame.origin.x = 120
            lblTitle.font = lblTitle.font.withSize(28.0)
        }
        else
        {
            btnTitle.titleLabel?.font = UIFont(name: "Amaranth", size: 24.0)
            lblTitle.font = lblTitle.font.withSize(24.0)
        }
        
        btnTitle.contentHorizontalAlignment = .center
        btnTitle.frame = CGRect(x:((UIScreen.main.bounds.size.width - 250)/2), y:10, width:250, height:20)
        navigationController?.navigationBar .addSubview(btnTitle)
        
        let btnLeft = UIBarButtonItem(image: UIImage(named: "leftArrow.png"), style: .plain, target: self, action: #selector(btnBackAction(_:)))
        btnLeft.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem  = btnLeft
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        if isFrom == "Love"
        {
            lblTitle.text = "Love"
            imgTitle.image = UIImage(named: "love1.png")
            arryLoveSticker = NSMutableArray()
            for i in 0..<14
            {
                arryLoveSticker.insert(UIImage.init(named: "love\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Face"
        {
            lblTitle.text = "Face"
            imgTitle.image = UIImage(named: "face1.png")
            arryFaceSticker = NSMutableArray()
            for i in 0..<30
            {
                arryFaceSticker.insert(UIImage.init(named: "face\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Food"
        {
            lblTitle.text = "Food"
            imgTitle.image = UIImage(named: "food1.png")
            arryFoodSticker = NSMutableArray()
            for i in 0..<16
            {
                arryFoodSticker.insert(UIImage.init(named: "food\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Gift"
        {
            lblTitle.text = "Gift"
            imgTitle.image = UIImage(named: "gift1.png")
            arryGiftSticker = NSMutableArray()
            for i in 0..<12
            {
                arryGiftSticker.insert(UIImage.init(named: "gift\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Happy BrithDay"
        {
            lblTitle.text = "Happy Birthday"
            imgTitle.image = UIImage(named: "hbd1.png")
            arryBrithdaySticker = NSMutableArray()
            for i in 0..<12
            {
                arryBrithdaySticker.insert(UIImage.init(named: "hbd\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Character"
        {
            lblTitle.text = "Character"
            imgTitle.image = UIImage(named: "character1.png")
            arryCharecterSticker = NSMutableArray()
            for i in 0..<19
            {
                arryCharecterSticker.insert(UIImage.init(named: "character\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Emoji"
        {
            lblTitle.text = "Emoji Pack"
            imgTitle.image = UIImage(named: "emoji2.png")
            arryEmojiSticker = NSMutableArray()
            for i in 0..<29
            {
                arryEmojiSticker.insert(UIImage.init(named: "emoji\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Game"
        {
            lblTitle.text = "Game"
            imgTitle.image = UIImage(named: "game2.png")
            arryGameSticker = NSMutableArray()
            for i in 0..<14
            {
                arryGameSticker.insert(UIImage.init(named: "game\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Teddy"
        {
            lblTitle.text = "Teddy"
            imgTitle.image = UIImage(named: "teddy1.png")
            arryTeddySticker = NSMutableArray()
            for i in 0..<17
            {
                arryTeddySticker.insert(UIImage.init(named: "teddy\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        else if isFrom == "Selfie"
        {
            lblTitle.text = "Selfie"
            imgTitle.image = UIImage(named: "selfie1.png")
            arrySelfieSticker = NSMutableArray()
            for i in 0..<29
            {
                arrySelfieSticker.insert(UIImage.init(named: "selfie\(i+1).png")!, at: i)
            }
            collectionStickerpack.reloadData()
        }
        print(btnTitle.frame.width)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.isHidden = false
        btnTitle .removeFromSuperview()
        navigationController?.navigationBar.isTranslucent = true
        isFrom = ""
    }
    
    @objc func back(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if isFrom == "Love"
        {
            return arryLoveSticker.count
        }
        else if isFrom == "Face"
        {
            return arryFaceSticker.count
        }
        else if isFrom == "Food"
        {
            return arryFoodSticker.count
        }
        else if isFrom == "Gift"
        {
            return arryGiftSticker.count
        }
        else if isFrom == "Happy BrithDay"
        {
            return arryBrithdaySticker.count
        }
        else if isFrom == "Character"
        {
            return arryCharecterSticker.count
        }
        else if isFrom == "Emoji"
        {
            return arryEmojiSticker.count
        }
        else if isFrom == "Game"
        {
            return arryGameSticker.count
        }
        else if isFrom == "Teddy"
        {
            return arryTeddySticker.count
        }
        else if isFrom == "Selfie"
        {
            return arrySelfieSticker.count
        }
        else
        {
            return arryTeddySticker.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellNewPack", for: indexPath as IndexPath)
        
        let imgSticker = cell.contentView.viewWithTag(2001) as! UIImageView
        
        if isFrom == "Love"
        {
            imgSticker.image = arryLoveSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Face"
        {
            imgSticker.image = arryFaceSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Food"
        {
            imgSticker.image = arryFoodSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Gift"
        {
            imgSticker.image = arryGiftSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Happy BrithDay"
        {
            imgSticker.image = arryBrithdaySticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Character"
        {
            imgSticker.image = arryCharecterSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Emoji"
        {
            imgSticker.image = arryEmojiSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Game"
        {
            imgSticker.image = arryGameSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Teddy"
        {
            imgSticker.image = arryTeddySticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else if isFrom == "Selfie"
        {
            imgSticker.image = arrySelfieSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
        else
        {
            imgSticker.image = arryGameSticker.object(at: indexPath.row) as? UIImage
            
            return cell
        }
    }
    
    @IBAction func btnBackAction (_ sender: AnyObject)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
