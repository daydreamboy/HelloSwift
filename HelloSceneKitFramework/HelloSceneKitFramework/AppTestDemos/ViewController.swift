//
//  ViewController.swift
//  AppTestTemplate
//
//  Created by wesley_chen on 2022/4/24.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.scene)
    }
    
    // MARK: Getter
    private lazy var scene: SCNView = {
        var sceneView: SCNView = SCNView.init(frame: self.view.bounds)
        sceneView.scene = makeScene()
        sceneView.allowsCameraControl = true

        return sceneView
    }()
    
    private func makeScene() -> SCNScene {
        let scene: SCNScene = SCNScene()
        
        // boxNode
        let boxSide = 5.0
        // Npote: set chamferRadius = 0.0 to sharp corners
        let box: SCNBox = SCNBox(width: boxSide, height: boxSide, length: boxSide, chamferRadius: 0.0)
        let boxNode = SCNNode.init(geometry: box)
        // Note: rotate around Y with a small angle
        boxNode.rotation = SCNVector4Make(0, 1, 0, Float(Double.pi / 5.0))
        scene.rootNode.addChildNode(boxNode)
        
//        // Set material for the box
//        let boxMaterial = SCNMaterial()
//        boxMaterial.diffuse.contents = UIColor.blue // 设置为蓝色，看起来能更好地接受光
//        boxNode.geometry!.materials = [boxMaterial]
        
        // cameraNode
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        let position: SCNVector3 = SCNVector3Make(0, 20, 0)//SCNVector3Make(0, 10, 20)
        cameraNode.position = position
        // rotate around X with atan(camY/camZ)
        cameraNode.rotation = SCNVector4Make(1, 0, 0, -atan2(10.0, 20.0))
        cameraNode.look(at: boxNode.position)
        scene.rootNode.addChildNode(cameraNode)
        
        // lightNode
        let lightBlueColor: UIColor = UIColor.init(red: 4.0/255.0, green: 120.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        let light: SCNLight = SCNLight()
        light.type = .directional
        light.color = lightBlueColor
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = position//SCNVector3(x: 5, y: 10, z: 5) // 设置光源位置
        lightNode.look(at: boxNode.position) // 确保光源指向立方体
        scene.rootNode.addChildNode(lightNode)
        
        return scene
    }
}

