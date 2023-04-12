//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Nguyen, Kriste N on 4/12/23.
//

import SwiftUI
import MapKit

let data = [
    Item(name: "Pho Tran 88", desc: "Best place for pho in San Marcos. Your Vietnamese grandma would approve.", lat: 29.883670486029928, long: -97.93978417544676, imageName: "rest1"),
    Item(name: "Pho NB", desc: "Fun friendly atmosphere. Delicious pho if you're in New Braunfels.", lat: 29.697829228153857, long: -98.09389385871197, imageName: "rest2"),
    Item(name: "Pho Thaison", desc: "Vietnamese cuisine chain with a large variety of food located in Kyle.", lat: 30.032906842090533, long: -97.87268353948716, imageName: "rest3"),
    Item(name: "Hai Ky", desc: "Small hole-in-wall restaurant with a variety of Asian cuisine.", lat: 30.230893890960814, long: -97.73492248937589, imageName: "rest4"),
    Item(name: "Dong Nai", desc: "Very generous portions of food at a decent price point. ", lat: 30.23394087272938, long: -97.79291154334152, imageName: "rest5")
   
]

    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let desc: String
        let lat: Double
        let long: Double
        let imageName: String
    }


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.883670486029928, longitude: -97.93978417544676), span: MKCoordinateSpan(latitudeDelta: 1.05, longitudeDelta: 1))
    var body: some View {
        
        
        NavigationView {
        VStack {
            List(data, id: \.name) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    HStack {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            
                                .font(.subheadline)
                        }
                    }
                }
            }
            Map(coordinateRegion: $region, annotationItems: data) { item in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .overlay(
                                        Text(item.name)
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: true, vertical: false)
                                            .offset(y: 25)
                                    )
                            }
                        }
                        .frame(height: 300)
                        .padding(.bottom, -30)
                        
                            
                .listStyle(PlainListStyle())
                .navigationTitle("Vietasty")
            }
        }
        
        
        
        
    }
}

struct DetailView: View {
    
    @State private var region: MKCoordinateRegion
        
        init(item: Item) {
            self.item = item
            _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
        }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(maxWidth: 200)
            
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
                   }
                    .navigationTitle(item.name)
                    Spacer()
           Map(coordinateRegion: $region, annotationItems: [item]) { item in
                  MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                      Image(systemName: "mappin.circle.fill")
                          .foregroundColor(.red)
                          .font(.title)
                          .overlay(
                              Text(item.name)
                                  .font(.subheadline)
                                  .foregroundColor(.black)
                                  .fixedSize(horizontal: true, vertical: false)
                                  .offset(y: 25)
                          )
                  }
              }
                  .frame(height: 300)
                  .padding(.bottom, -30)
                
        }
     }
   

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
