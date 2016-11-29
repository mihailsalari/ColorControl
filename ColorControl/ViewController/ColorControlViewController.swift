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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.brightnessLabel.text = "Brightness \(brightnessUISlider.value)"
        self.contrastLabel.text = "Contrast \(contrastUISlider.value)"
        self.saturationLabel.text = "Saturation \(saturationUISlider.value)"
        
        let colorControl = ColorControl()
        brightnessUISlider.maximumValue = colorControl.maxBrightnessValue
        brightnessUISlider.minimumValue = colorControl.minBrightnessValue
        
        contrastUISlider.maximumValue = colorControl.maxBrightnessValue
        contrastUISlider.minimumValue = colorControl.minBrightnessValue
        
        saturationUISlider.maximumValue = colorControl.maxBrightnessValue
        saturationUISlider.minimumValue = colorControl.minBrightnessValue
        
        //        brightnessUISlider.value = colorControl.currentBrightnessValue
        //        contrastUISlider.value = colorControl.currentContrastValue
        //        saturationUISlider.value = colorControl.currentSaturationValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ColorControlViewController {
    
    @IBAction func brightnessUISliderPressed(_ sender: UISlider) {
        self.brightnessLabel.text = "Brightness \(sender.value)"
        let colorControl = ColorControl()
        let inputImage = colorControl.input(self.imageView.image!)
        let saturation = inputImage.brightness(sender.value)
        self.imageView.image = saturation.outputUIImage()
    }
    
    @IBAction func contrastUISliderPressed(_ sender: UISlider) {
        self.contrastLabel.text = "Contrast \(sender.value)"
        let colorControl = ColorControl()
        let inputImage = colorControl.input(self.imageView.image!)
        let saturation = inputImage.contrast(sender.value)
        self.imageView.image = saturation.outputUIImage()
    }
    
    @IBAction func saturationUISliderPressed(_ sender: UISlider) {
        self.saturationLabel.text = "Saturation \(sender.value)"
        let colorControl = ColorControl()
        let inputImage = colorControl.input(self.imageView.image!)
        let saturation = inputImage.saturation(sender.value)
        self.imageView.image = saturation.outputUIImage()
    }
}
