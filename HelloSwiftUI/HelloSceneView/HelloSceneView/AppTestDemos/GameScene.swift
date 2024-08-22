//
//  GameScene.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2024/8/21.
//

import SceneKit

class GameScene: SCNScene {
    var cameraNode = SCNNode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
        
        background.contents = UIColor.black
        
        setupCamera()
        addFloor()
        addCube()
        addLights()
    }
    
    func setupCamera() {
        let camera = SCNCamera()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 5, 5)
        cameraNode.eulerAngles = SCNVector3(-Float.pi / 4, 0, 0)
        
        rootNode.addChildNode(cameraNode)
    }
    
    func addFloor() {
        let floor = SCNNode(geometry: SCNFloor())
        floor.geometry?.firstMaterial?.diffuse.contents = UIColor.gray
        
        rootNode.addChildNode(floor)
    }
    
    func addCube() {
        let cube = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.072))
        cube.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
        cube.position = SCNVector3(0, 0.52, 0)
        
        rootNode.addChildNode(cube)
    }
    
    func addLights() {
        // Add ambient light.
        let ambientLightNode = SCNNode()
        let ambientLight = SCNLight()
        
        ambientLight.type = .ambient
        ambientLight.color = UIColor.white
        ambientLight.intensity = 72
        
        ambientLightNode.light = ambientLight
        
        rootNode.addChildNode(ambientLightNode)
        
        // Add spot light.
        let spotLightNode = SCNNode()
        let spotLight = SCNLight()
        
        spotLight.type = .spot
        spotLight.color = UIColor.orange
        spotLight.intensity = 2700
        spotLight.spotInnerAngle = 20
        spotLight.spotOuterAngle = 272
        spotLight.castsShadow = true
        
        spotLightNode.light = spotLight
        spotLightNode.position = SCNVector3(-1, 2, 0)
        spotLightNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)
        
        rootNode.addChildNode(spotLightNode)
    }
}
