//
//  ColorPickerVC.swift
//  photoEditor
//
//  Created by Netra Technosys on 10/06/19.
//  Copyright © 2019 Netra Technosys. All rights reserved.
//

import UIKit
import ColorSlider

class ColorPickerVC: UIViewController
{
    @IBOutlet weak var viewwwww : UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let colorSlider = ColorSlider(orientation: .vertical, previewView: nil)
        colorSlider.frame = CGRect(x: 200, y: 300, width: 12, height: 150)
        view.addSubview(colorSlider)
        colorSlider.addTarget(self, action: #selector(changedColor(_:)), for: .valueChanged)
    }
    
    @objc func changedColor(_ slider: ColorSlider)
    {
        var color = slider.color
        print(color)
        viewwwww.backgroundColor = color
    }
}
