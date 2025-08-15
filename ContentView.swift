//
//  ContentView.swift
//  Moonshot
//
//  Created by عبدالله on 13/08/2025.
//
import SwiftUI
struct ContentView: View {
    @State var showingGrid : Bool = true
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    @State private var selectedMission: String?
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridView()
                } else {
                    ListView()
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button{
                    showingGrid.toggle()
                }label:{
                    Text(showingGrid ? "List" : "Grid")
                        .padding(10)
                        .foregroundStyle(.white)
                        .background(.purple)
                        .clipShape(.rect(cornerRadius: 5))
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
