//
//  ViewController.swift
//  Mr.Pig
//
//  Created by Bill Yu on 5/29/16.
//  Copyright © 2016 Bill Yu. All rights reserved.
//

// 1
import UIKit
import SceneKit
import SpriteKit
// 2
class ViewController: UIViewController {
    // 3
    let game = GameHelper.sharedInstance
    var scnView: SCNView!
    var gameScene:SCNScene!
    var splashScene:SCNScene!
    
    var pigNode: SCNNode!
    var cameraNode: SCNNode!
    var cameraFollowNode: SCNNode!
    var lightFollowNode: SCNNode!
    var trafficNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 4
        setupScenes()
        setupNodes()
        setupActions()
        setupTraffic()
        setupGestures()
        setupSounds()
        // 5
        game.state = .TapToPlay
    }
    
    func setupScenes() {
        scnView = SCNView(frame: self.view.frame)
        self.view.addSubview(scnView)
        // 1
        gameScene = SCNScene(named: "/MrPig.scnassets/GameScene.scn")
        splashScene = SCNScene(named: "/MrPig.scnassets/SplashScene.scn")
        // 2
        scnView.scene = splashScene
    }
    
    func setupNodes() {
        pigNode = gameScene.rootNode.childNodeWithName("MrPig", recursively: true)!
        cameraNode = gameScene.rootNode.childNodeWithName("camera", recursively: true)!
        cameraNode.addChildNode(game.hudNode)
        cameraFollowNode = gameScene.rootNode.childNodeWithName("FollowCamera", recursively: true)!
        lightFollowNode = gameScene.rootNode.childNodeWithName("FollowLight", recursively: true)!
        trafficNode = gameScene.rootNode.childNodeWithName("Traffic", recursively: true)
    }
    
    func setupActions() {
    }
    
    func setupTraffic() {
    }
    
    func setupGestures() {
    }
    
    func setupSounds() {
    }
    
    func startGame() {
        // 1
        splashScene.paused = true
        // 2
        let transition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        // 3
        scnView.presentScene(gameScene, withTransition: transition, incomingPointOfView: nil, completionHandler: {
            // 4
            self.game.state = .Playing
            self.setupSounds()
            self.gameScene.paused = false
        })
    }
    
    func stopGame() {
        game.state = .GameOver
        game.reset()
    }
    
    func startSplash() {
        // 1
        gameScene.paused = true
        // 2
        let transition = SKTransition.doorsOpenVerticalWithDuration(1.0)
        scnView.presentScene(splashScene, withTransition: transition, incomingPointOfView: nil, completionHandler: {
            self.game.state = .TapToPlay
            self.setupSounds()
            self.splashScene.paused = false
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event:
        UIEvent?) {
        if game.state == .TapToPlay {
            startGame()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}