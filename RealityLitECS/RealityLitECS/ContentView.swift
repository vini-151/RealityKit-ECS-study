import SwiftUI
import RealityKit

struct ContentView: View {
    
    let entities = Entity()
    
    var body: some View {
        
        
        RealityView { content in
            content.camera = .virtual

            // Câmera
            let camera = PerspectiveCamera()
            camera.position = [0, 3, 6]
            camera.look(at: .zero, from: camera.position, relativeTo: nil)
            content.add(camera)

            // Luz
            let light = DirectionalLight()
            light.look(at: .zero, from: [2, 4, 3], relativeTo: nil)
            content.add(light)
            
            
            let sun = entities.spawnSun()
            content.add(sun)
            
            let planets: [(Float, Float, Float, NSColor)] = [
                // raio da órbita, velocidade orbital, tamanho, cor
                (1.5, 1.2, 0.15, .systemBlue),
                (2.5, 0.8, 0.22, .systemGreen),
                (3.5, 0.5, 0.18, .systemRed),
            ]
            for (radius, speed, size, color) in planets {
                let planet = ModelEntity(
                    mesh: .generateSphere(radius: size),
                    materials: [SimpleMaterial(color: color, isMetallic: false)]
                )
                planet.components.set(OrbitComponent(radius: radius, speed: speed))
                planet.components.set(SpinComponent(speed: 0))
                content.add(planet)
            }
            
            let planeta = ModelEntity(
                mesh: .generateSphere(radius: 0.5),
                materials: [SimpleMaterial(color: .red, isMetallic: false)]
            )
            planeta.components.set(OrbitComponent(radius: 5, speed: 1))
            planeta.components.set(SpinComponent(speed: 0))
            
            
            let moon = ModelEntity(
                mesh: .generateSphere(radius: 0.2),
                materials: [SimpleMaterial(color: .gray, isMetallic: false)]
            )
            moon.components.set(OrbitComponent(radius: 1, speed: 5))
            moon.components.set(SpinComponent(speed: 0))
            planeta.addChild(moon)
            content.add(planeta)
        }
        .onAppear(){
            SpinComponent.registerComponent()
            OrbitComponent.registerComponent()
            SpinSystem.registerSystem()
            OrbitSystem.registerSystem()
        }
    }
}

#Preview {
    ContentView()
}

