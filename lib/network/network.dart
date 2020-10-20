import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_forecast_app/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/util/forecast_util.dart';

class Network {

  Future<WeatherForecastModel> getWeatherForecast ({String cityName}) async {
    final defaultUnits = "metric";
    final finalUrl = "http://api.openweathermap.org/data/2.5/forecast?"+
        "q=$cityName"+
        "&units=$defaultUnits"+
            "&appid=${Util.appId}";

    final Response response = await get(Uri.encodeFull(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if(response.statusCode == 200){
      //OK
      print("JSON STRING: ${response.body}");
      return WeatherForecastModel.fromJson(json.decode(response.body));
    }else{
      throw Exception("Error getting weather forecast");
    }
  }
}