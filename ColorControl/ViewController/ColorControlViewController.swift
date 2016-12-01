//
//  ColorControlViewController.swift
//  ColorControl
//
//  Created by Mihail Șalari on 11/29/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class ColorControlViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var brightnessLabel: UILabel!
    @IBOutlet weak var contrastLabel: UILabel!
    @IBOutlet weak var saturationLabel: UILabel!
    
    @IBOutlet weak var brightnessUISlider: UISlider!
    @IBOutlet weak var contrastUISlider: UISlider!
    @IBOutlet weak var saturationUISlider: UISlider!
    
    var colorControl = ColorControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.brightnessLabel.text = "Brightness \(brightnessUISlider.value)"
        self.contrastLabel.text = "Contrast \(contrastUISlider.value)"
        self.saturationLabel.text = "Saturation \(saturationUISlider.value)"
        
        colorControl = colorControl.input(self.imageView.image!)
        
        ///
        self.setUISLidersValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setUISLidersValues() {
        contrastUISlider.value = 1.00
        contrastUISlider.maximumValue = 4.00
        contrastUISlider.minimumValue = 0.00
        
        brightnessUISlider.value = 0.00
        brightnessUISlider.maximumValue = 1.00
        brightnessUISlider.minimumValue = -1.00
        
        saturationUISlider.value = 1.00
        saturationUISlider.maximumValue = 2.00
        saturationUISlider.minimumValue = 0.00
    }
}


// MARK: - UISlider @IBAction

extension ColorControlViewController {
    
    @IBAction func brightnessUISliderPressed(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.brightnessLabel.text = "Brightness \(sender.value)"
            self.colorControl = self.colorControl.brightness(sender.value)
            self.imageView.image = self.colorControl.outputUIImage()
        }
    }
    
    @IBAction func contrastUISliderPressed(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.contrastLabel.text = "Contrast \(sender.value)"
            
            self.colorControl = self.colorControl.contrast(sender.value)
            self.imageView.image = self.colorControl.outputUIImage()
        }
    }
    
    @IBAction func saturationUISliderPressed(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.saturationLabel.text = "Saturation \(sender.value)"
            
            self.colorControl = self.colorControl.saturation(sender.value)
            self.imageView.image = self.colorControl.outputUIImage()
        }
    }
}
