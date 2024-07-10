//
//  ContentView.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import SwiftUI
import Kingfisher

@MainActor
struct FlickerHomeView: View {
    @StateObject var viewModel = FlickerHomeViewModel()
    @State private var selectedPhoto: Photo? = nil
    @State private var isDetailViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .none:
                    StateViewView(imageName: images.magnifyingglassCircleFill,
                                  title: strings.searchExploreCardTitle,
                                  text: strings.searchExploreCardSubTitle)
                case .loading:
                    ProgressView()
                case .finished(let photos):
                    showListView(photos: photos)
                case .error:
                    StateViewView(imageName: images.exclamationmark,
                                  title: strings.searchFailedTitle,
                                  text: strings.searchFailedSubtitle,
                                  type: .danger)
                }
            }
            .navigationTitle("Flickr Search")
            .sheet(item: $selectedPhoto) { photo in
                PhotoDetailView(photo: photo, isDetailViewPresented: $isDetailViewPresented)
            }
            .searchable(text: $viewModel.searchText,
                        placement: .toolbar,
                        prompt: strings.searchTitlePrompt)
        }
        .onChange(of: isDetailViewPresented) { isPresented in
            if !isPresented {
                selectedPhoto = nil // Reset selectedPhoto when dismissing detail view
            }
        }
    }
    
    
    @ViewBuilder
    func showListView(photos: [Photo]) -> some View {
        ScrollView {
            ForEach(photos) { photo in
                CardView {
                    VStack(alignment: .leading) {
                        Text(photo.title)
                            .foregroundColor(Colors.accent)
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                            .padding(.top, Space.small)
                        CustomAsyncImage(url: photo.imageURL)
                            .cornerRadius(Corners.xs)
                            .padding(.bottom, Space.small)
                    }
                    .padding(.vertical, Space.medium)
                    .padding(.horizontal, Space.small)
                    .background(Colors.secondaryBG)
                }
                .onTapGesture {
                    selectedPhoto = photo // Set selected photo for detail view
                }
                .padding(.horizontal, Space.small)
            }
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowSeparator(.hidden)
    }
}

struct FlickerHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FlickerHomeView()
    }
}
