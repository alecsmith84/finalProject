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

class GameViewController: UIViewController, GameDelegate, UIGestureRecognizerDelegate {

    var scene: GameScene!
    var game: Game!
    
    // make the pan work
    var panPointReference:CGPoint?
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var levelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    // Configure the view
    let skView = view as! SKView
    skView.isMultipleTouchEnabled = false
    // Create and configure the scene
    scene = GameScene(size: skView.bounds.size)
    
    scene.scaleMode = .aspectFill
        
    // call didtick
    scene.tick = didTick
        
    game = Game()
    game.delegate = self
    game.beginGame()
    // show scene
    skView.presentScene(scene)
        
    
    }
   

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // I spin them around
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        game.rotateShape()
        
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        // how far did you move
        let currentPoint = sender.translation(in: self.view)
        if let originalPoint = panPointReference {
            
            // check to see if touch is 90% of block size
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                // check the velocity
                if sender.velocity(in: self.view).x > CGFloat(0) {
                    game.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    game.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .began {
            panPointReference = currentPoint
        }
    }
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        game.dropShape()
    }
    
    // allow gesture to work with others at the same time
    // tap and swipe...
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // conditionals to check if gestures are correct
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    
    // call the falling at each tick
    func didTick() {
        game.letShapeFall()
    }
    
    func nextShape() {
        let newShapes = game.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!) {}
        self.scene.movePreviewShape(shape: fallingShape) {
            // is the users interacting
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(game: Game) {
        
        levelLabel.text = "\(game.level)"
        scoreLabel.text = "\(game.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        
        // set false for new game
        if game.nextShape != nil && game.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: game.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(game: Game) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        
       // scene.playSound(sound: "/Users/alecsmith/Desktop/Spring The End/xcode apps/final/final/assets/Sounds/gameover.mp3")
        
        scene.animateCollapsingLines(linesToRemove: game.removeAllBlocks(), fallenBlocks: game.removeAllBlocks()) {
            game.beginGame()
        }
        
    }
    
    func gameDidLevelUp(game: Game) {
        levelLabel.text = "\(game.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        
        //scene.playSound(sound: "/Users/alecsmith/Desktop/Spring The End/xcode apps/final/final/assets/Sounds/levelup.mp3")
    }
    
    
    func gameShapeDidDrop(game: Game) {
        // stop the ticks
        scene.stopTicking()
        scene.redrawShape(shape: game.fallingShape!) {
            game.letShapeFall()
        }
        //scene.playSound(sound: "/Users/alecsmith/Desktop/Spring The End/xcode apps/final/final/assets/Sounds/drop.mp3")
    }
    
    func gameShapeDidLand(game: Game) {
        scene.stopTicking()
        self.view.isUserInteractionEnabled = false
        // remove lines with this
        let removedLines = game.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(game.score)"
            scene.animateCollapsingLines(linesToRemove: removedLines.linesRemoved, fallenBlocks: removedLines.fallenBlocks) {
                // form new lines
                self.gameShapeDidLand(game: game)
            }
            //scene.playSound(sound: "/Users/alecsmith/Desktop/Spring The End/xcode apps/final/final/assets/Sounds/bomb.mp3")
        } else {
            nextShape()
        }
    }
    
    // redraw everything at new location
    func gameShapeDidMove(game: Game) {
        scene.redrawShape(shape: game.fallingShape!) {}
    }
}
