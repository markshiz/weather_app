import SwiftUI
import MapKit
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                TextField(
                  "St Louis, 63109, (38.0, -90.0) ...",
                  text: viewStore.binding(
                    get: { $0.searchQuery }, send: AppAction.searchTermChanged)
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(5)
                MapView(coordinate: viewStore.locationCoordinate)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 100)
                CircleImage(image: viewStore.conditionImage)
                    .frame(width: 70, height: 70)
                    .offset(y: -35)
                    .padding(.bottom, -35)
                VStack(alignment: .leading) {
                    Text(viewStore.condition)
                        .font(.headline)
                    HStack(alignment: .top) {
                        Text(viewStore.locationName)
                            .font(.subheadline)
                        Spacer()
                        Text(viewStore.temperatureDegrees)
                            .font(.headline)
                    }
                }.padding()
                List(viewStore.dailyWeather, id: \.uuid, rowContent: { weather in
                    DailyWeatherRow(state: weather)
                })
                Spacer()
            }.background(Color(UIColor.systemBackground))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(
              store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                  currentConditionResponse: { query in Effect(error: ApiError()) }
                )
              )
            )
                
            ContentView(
              store: Store(
                initialState: AppState(),
                reducer: appReducer,
                environment: AppEnvironment(
                  mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                  currentConditionResponse: { query in Effect(error: ApiError()) }
                )
              )
            ).environment(\.colorScheme, .dark)
        }
    }
}
