//
//  Entity.swift
//  RealityLitECS
//
//  Created by Vini Oliveira  on 14/10/26.
//
import RealityKit
import AppKit

struct Entity{
    
    
    func spawnSun() -> ModelEntity{
        let sun = ModelEntity(
            mesh: .generateSphere(radius: 0.5),
            materials: [UnlitMaterial(color: .orange)]
            )
        sun.components.set(SpinComponent(speed: 0.5))
        return sun
    }
}
