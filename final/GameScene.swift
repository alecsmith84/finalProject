//
//  GameScene.swift
//  final
//
//  Created by Alec Smith on 4/22/19.
//  Copyright © 2019 Alec Smith. All rights reserved.
//

import SpriteKit

// size of each block
let BlockSize:CGFloat = 20.0

// slowest speed of travel 600 milliseconds
let TickLengthLevelOne = TimeInterval(600)

class GameScene: SKScene {
    
    // make some layers to hold the sprites
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x: 6, y: -6)
    
    // tick returns nothing (even though it looks ugly)
    var tick:(() -> ())?
    var tickLengthMillis = TickLengthLevelOne
    var lastTick:NSDate?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 0, y: 0)
        
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        
        addChild(background)
        
        addChild(gameLayer)
        
        let gameBoardTexture = SKTexture(imageNamed: "gameboard")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSizeMake(BlockSize * CGFloat(NumColumns), BlockSize * CGFloat(NumRows)))
        
        gameBoard.anchorPoint = CGPoint(x:0,y:1.0)
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
    }
    override func update(_ currentTime: TimeInterval) {
        // if lastTick is empty then the game is paused
        guard let lastTick = lastTick else {
            return
        }
        // if lastTick is a thing then multiply by -1000 to make it positive
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0
        
        if timePassed > tickLengthMillis {
            self.lastTick = NSDate()
            
            tick?()
        }
        
    }
    // let external classes start/stop the startTick
    func startTicking() {
        lastTick = NSDate()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    // returns the coordinates of where the block sits
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let x = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
    
        return CGPointMake(x,y)
    }
    
    func addPreviewShapeToScene(shape:Shape,completion:() -> ()) {
        for block in shape.blocks {
            // adds shape  as the preview
            var texture = textureCache[block.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: block.spriteName)
            textureCache[block.spriteName] = texture
            }
            
            let sprite = SKSpriteNode(texture: texture)
            
            // make sure the animation works smoothly
            sprite.position = pointForColumn(column: block.column, row: block.row - 2)
            shapeLayer.addChild(sprite)
            block.sprite = sprite
            
            
            //MARK: Block Animation
            sprite.alpha = 0
            
            // block fades and moves 
            let moveAction = SKAction.move(to: pointForColumn(column: block.column, row: block.row), duration: TimeInterval(0.2))
            moveAction.timingMode = .easeOut
            
            let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.4)
            
            fadeInAction.timingMode = .easeOut
            
            sprite.run(SKAction.group([moveAction,fadeInAction]))
        }
        func movePreviewShape(shape:Shape, completion:@escaping () -> ()) {
            for block in shape.blocks {
                let sprite = block.sprite!
                let moveTo = pointForColumn(column: block.column, row: block.row)
                let moveToAction:SKAction = SKAction.move(to: moveTo,duration: 0.2)
                moveToAction.timingMode = .easeOut
                
                sprite.run(SKAction.group([moveToAction,SKAction.fadeAlpha(to: 1.0, duration: 0.2)]),
                    completion: {})
                
            }
            run(SKAction.wait(forDuration: 0.2), completion: completion)
        }
        
        func redrawShape(shape:Shape, completion:@escaping () -> ()) {
            for block in shape.blocks {
                let sprite = block.sprite!
                let moveTo = pointForColumn(column: block.column, row: block.row)
                let moveToAction: SKAction = SKAction.move(to: moveTo, duration: 0.05)
                
                moveToAction.timingMode = .easeOut
                
                if block == shape.blocks.last {
                    sprite.run(moveToAction, completion: completion)
                } else {
                    sprite.run(moveToAction)
                }
            }
        }
    }
}
