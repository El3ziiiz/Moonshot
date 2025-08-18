//
//  MissionView.swift
//  Moonshot
//
//  Created by عبدالله on 14/08/2025.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember : Hashable {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){
                        width, Axis in width * 0.6
                    }
                VStack(alignment: .leading){
                    Text(mission.formattedLaunchDate).font(.title3).padding(.top)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlights").font(.title.bold()).padding(.bottom, 5)
                    Text(mission.description)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew").font(.title.bold()).padding(.bottom, 5)
                }
                .padding(.horizontal)
                Hscroll(mission: mission, crew: crew.map{
                    Hscroll.CrewMember(role: $0.role, astronaut: $0.astronaut)
                })
            }.padding(.bottom)
        }.navigationTitle(mission.displayName).navigationBarTitleDisplayMode(.inline).background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            }else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    NavigationStack {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
