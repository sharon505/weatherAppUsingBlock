import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';

import '../data/Data.dart';

part 'weatherbloc_event.dart';
part 'weatherbloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

        Position position = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
          position.latitude,
          position.longitude,
        );
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}

