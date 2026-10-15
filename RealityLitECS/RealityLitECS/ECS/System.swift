//
//  System.swift
//  RealityLitECS
//
//  Created by Vini Oliveira  on 14/10/26.
//

import RealityKit

struct SpinSystem: System {
    
    //aqui está sendo criado uma query que procura todas as entidades que possuem o componente SpinComponent
    static let query = EntityQuery(where: .has(SpinComponent.self))

    init(scene: Scene) {}//é preciso usar por conta do protocolo

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime) //pega o tempo em segundo desde o ultimo update
        
        //iterando por todas as entidades e pra cada uma:
        for entity in context.entities(matching: Self.query,
                                       updatingSystemWhen: .rendering) {
            //pega os parametros de rotação (que são: velocidade e eixo)
            guard let spin = entity.components[SpinComponent.self] else { continue }
            //calcula a nova rotação baseado nos parâmetros
            let delta = simd_quatf(angle: spin.speed * dt, axis: spin.axis)
            //aplica a rotação
            entity.transform.rotation = delta * entity.transform.rotation
        }
    }
    
    //resultado: a cada frame, cada entidade com um SpinComponent é rotacionada sobre o eixo especificado na velocidade atribuída
}

struct OrbitSystem: System {
    
    static let query = EntityQuery(where: .has(OrbitComponent.self))

    init(scene: Scene) {}

    //calcula a posicao na orbita a cada frame
    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query,
                                       updatingSystemWhen: .rendering) {
            guard var orbit = entity.components[OrbitComponent.self] else { continue }
            orbit.angle += orbit.speed * dt
            entity.position = [cos(orbit.angle) * orbit.radius,
                               0,
                               sin(orbit.angle) * orbit.radius]
            entity.components.set(orbit)   // componentes são structs: precisa regravar
        }
    }
}
