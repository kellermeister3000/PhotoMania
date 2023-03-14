//
//  ContentView.swift
//  PhotoMania
//
//  Created by Philip Keller on 3/13/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var image: Image?
    
    func fetchNewImage() {
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                if let image = viewModel.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Spacer()
                Spacer()
                
                Button {
                    viewModel.fetchNewImage()
                } label: {
                    Text("New Image!")
                        .bold()
                    
                    
                }
                .buttonStyle(.borderedProminent)
                
            }
            .navigationBarTitle("Photo Mania")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
