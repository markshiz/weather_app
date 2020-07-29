import SwiftUI
import MapKit
import ComposableArchitecture

struct ContentView: View {
    let store: Store<AppState, AppAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                MapView(coordinate: viewStore.locationCoordinate)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 150)
                CircleImage(image: viewStore.conditionImage)
                    .frame(width: 100, height: 100)
                    .offset(y: -50)
                    .padding(.bottom, -50)
                VStack(alignment: .leading) {
                    Text(viewStore.condition)
                        .font(.title)
                    HStack(alignment: .top) {
                        Text(viewStore.locationName)
                            .font(.subheadline)
                        Spacer()
                        Text(viewStore.temperatureDegrees)
                            .font(.headline)
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
          store: Store(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
              mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
              currentConditionResponse: { number in Effect(value: CurrentConditionResponse()) }
            )
          )
        )
    }
}
