//
//  Component.swift
//  RealityLitECS
//
//  Created by Vini Oliveira  on 14/10/26.
//

import RealityKit

struct SpinComponent: Component {
    var speed: Float                    // rad/s
    var axis: SIMD3<Float> = [0, 1, 0]
}

struct OrbitComponent: Component {
    var radius: Float
    var speed: Float                    // rad/s
    var angle: Float = 0
}
