import SwiftUI

struct DailyWeatherRow: View {
    var state: DailyWeather
    
    var body: some View {
        HStack {
            state.image
                .resizable()
                .frame(width: 44, height: 44)
            Text(state.condition)
            Spacer()
            Text(state.hiTemp)
            Text("/")
            Text(state.lowTemp)
        }
        .padding(5)
        .background(Color(UIColor.systemBackground))
    }
}

struct DailyWeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DailyWeatherRow(state: Constants.SAMPLE_WEATHER)
            DailyWeatherRow(state: Constants.SAMPLE_WEATHER)
                .environment(\.colorScheme, .dark)
        }
    }
}
