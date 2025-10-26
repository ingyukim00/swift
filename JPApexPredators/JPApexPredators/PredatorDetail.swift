//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Ingyu Kim on 10/25/25.
//


import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    @State var position: MapCameraPosition
    
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Background img
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.95), Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    
                    // Dino img
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3.7)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                    //                        .border(.blue, width: 7)
                }
                
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(Font.largeTitle)
                    // Dino name
                    
                    // location
                    NavigationLink {
                        PredatorMap(
                            position: .camera(
                                MapCamera(
                                    centerCoordinate: predator.location,
                                    distance: 1000,
                                    heading: 250,
                                    pitch: 80
                                )))
                        .navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .allowsHitTesting(false)
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "chevron.right")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                            
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current location")
                                .padding([.leading, .bottom], 5)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomLeadingRadius: 15))
                        }
                    }
                    .matchedTransitionSource(id: 1, in: namespace)
                    
                    
                    // Appears in
                    Text("Appears In: ")
                        .font(.title3)
                        .padding(.top)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    // Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    
                    // Link to a website
                    Text("Read More")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding()
                .padding(20)
                .frame(width: geo.size.width, alignment: .leading)
            }
            
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
    }
}

#Preview {
    let predator = Predators().allApepxPredators[10]
    
    NavigationStack {
        PredatorDetail(
            predator: predator,
            position: .camera(
                MapCamera(
                    centerCoordinate: predator.location,
                    distance: 30000
                )))
        .preferredColorScheme(.dark)
    }
}
