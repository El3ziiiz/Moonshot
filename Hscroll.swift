//
//  Hscroll.swift
//  Moonshot
//
//  Created by عبدالله on 14/08/2025.
//

import SwiftUI

struct Hscroll: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember.astronaut) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }.navigationDestination(for: Astronaut.self){ astronaut in
                        AstronautView(astronaut: astronaut)
                    }
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crew = missions[0].crew.map { member in
        Hscroll.CrewMember(role: member.role, astronaut: astronauts[member.name]!)
    }
    NavigationStack {
        Hscroll(mission: missions[0], crew: crew)
    }
}
