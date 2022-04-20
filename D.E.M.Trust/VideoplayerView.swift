//
//  ContentView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/15/22.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State private var index = 0
    @State private var data : [Video] = [
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "DEMT&Resilience40", ofType: "mp4") ?? "not found")), replay: false),
        //should use web url for this
    ]
    
    var body: some View {
        ZStack {
            PlayerScrollView(data: self.$data)
            VStack {
                
                HStack(spacing: 15) {
                    Button {
                        
                    } label: {
                        Text("Documentaries")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 35) {
                        Button {
                            
                        } label: {
                            Image("profile")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        }
                        
                    }
                    .padding(.bottom, 55)
                    .padding(.trailing)
                }
                
                HStack {
                    Button {
                        self.index = 0
                    } label: {
                        Image("homeicon")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : .white.opacity(0.35))
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        self.index = 3
                    } label: {
                        Image("usericon")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 3 ? .white : .white.opacity(0.35))
                    }
                    
                }
                .padding(.horizontal)
            }
            .padding(.top, safeArea().top)
            .padding(.bottom, safeArea().bottom + 5)
        }
        .background {
            Color.black
                .ignoresSafeArea()
        }
    }
}

class Host: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

struct Player: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resize
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

struct PlayerView: View {
    @Binding var data: [Video]
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.data.count, id: \.self) { i in
                ZStack {
                    Player(player: self.data[i].player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                        .onTapGesture(count: 2) {
                            self.data[i].player.pause()
                        }
                        .onTapGesture {
                            self.data[i].player.play()
                        }
                    
                    if self.data[i].replay {
                        Button {
                            self.data[i].replay = false
                            self.data[i].player.seek(to: .zero)
                            self.data[i].player.play()
                        } label: {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                        }

                    }
                }
            }
        }
        .onAppear {
            //triggering play on first item without dragging first
            self.data[0].player.play()
            
            self.data[0].player.actionAtItemEnd = .none
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { _ in
                //notification to identify at end of video
                
                //enabling replay button
                self.data[0].replay = true
            }
            
        }
    }
}

//sample video... extract to own file later

struct Video: Identifiable {
    var id: Int
    var player: AVPlayer
    var replay: Bool
}

struct PlayerScrollView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent: self)
    }
    
    @Binding var data: [Video]
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(data.count))
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never //ignoring safe areas
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        //to dynamically update height based on video
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(data.count))
        
        for i in 0..<uiView.subviews.count {
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(data.count))
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: PlayerScrollView
        var index = 0
        
        init(parent: PlayerScrollView) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currentIndex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currentIndex {
                index = currentIndex
                
                for i in 0..<parent.data.count {
                    //pausing all other videos
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                //playing next video
                parent.data[index].player.play()
                
                parent.data[index].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { _ in
                    //notification to identify at end of video
                    
                    //enabling replay button
                    self.parent.data[self.index].replay = true
                }
            }
        }
    }
}

