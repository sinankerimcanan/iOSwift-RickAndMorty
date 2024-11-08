import SwiftUI

struct ListView: View {
    @StateObject var viewModelCH = RMListViewModel()
    @State private var isLoading = true
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        HStack {
            if isLoading {
                ProgressView()
            } else {
                VStack{
                    ScrollView (.vertical, showsIndicators: false){
                        if viewModelCH.isData == true {
                            ForEach(viewModelCH.characters , id: \.id) { item in
                                NavigationLink(destination: DetailView(url: item.url)) {
                                    HStack{
                                        AsyncImage(url: URL(string: item.image)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width:100)
                                                //.frame(width: UIScreen.main.bounds.width*0.25)
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .strokeBorder(getCharacterFrameColor(for: item.gender), lineWidth: 7)
                                                    )
                                            case .failure:
                                                Text("Failed to load image")
                                            @unknown default:
                                                fatalError()
                                            }
                                        }
                                        .padding([.top, .bottom, .trailing], 10.0)
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.name)
                                                .foregroundColor(Color.RMpurple).opacity(0.8)
                                                .font(.custom("Quicksand", size: 26))
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.center)
                                        }
                                        Spacer()
                                        getCharacterGender(for: item.gender)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: UIScreen.main.bounds.height*0.06)
                                    }
                                    //.frame(width: UIScreen.main.bounds.width*0.85)
                                    .frame(width: UIScreen.main.bounds.width*0.85 , height: 120)
                                    .padding(.horizontal)
                                    .background(LinearGradient(gradient: Gradient(stops: [
                                        .init(color: Color.RMgreen,location :0),
                                        .init(color: Color.RMyellow,location:1)]),
                                                               startPoint: UnitPoint(x: 0.8, y: 2.08),
                                                               endPoint: UnitPoint(x: -0.001, y: 0.97)))
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .strokeBorder(Color.RMpink, lineWidth: 0.5)
                                    )
                                }
                                
                            }
                            
                        }else{
                            //MARK: - Eger lokasiyn içinde karakter yoksa gösterilcek ekran
                            VStack {
                                Image("morty")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width*0.45)
                                    .padding(.vertical)
                                Text("This Location \n Cannot Find Character!")
                                    .font(.custom("DynaPuff", size: 30))
                                    .fontWeight(.light)
                                    .foregroundColor(Color.RMpurple)
                                    .multilineTextAlignment(.center)
                                    .padding(.top,10)
                                
                                
                            }
                            
                        }
                    }
                }
                
            }
        }
        .onAppear {
            isLoading = false
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}



