//
//  GameViewController.swift
//  final
//
//  Created by Alec Smith on 4/22/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var scene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let skView = view as! SKView
    
    skView.multipleTouchEnabled = false
    
    scene = GameScene(size: skView.bounds.size)
    
    scene.scaleMode = .AspectFill
    
    skView.presentScene(scene)

   

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
