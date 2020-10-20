import 'package:flutter/material.dart';
import 'package:weather_forecast_app/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/network/network.dart';
import 'package:weather_forecast_app/ui/midView.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  Future<WeatherForecastModel> forecastObject;
  String _cityName = "tokyo";

  @override
  void initState() {
    super.initState();
    forecastObject = getWeather(cityName: _cityName);
      //forecastObject = getWeather(cityName: _cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
                future: forecastObject,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherForecastModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        midView(snapshot),
                      ],
                    );
                  } else {
                    print(snapshot);
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            hintText: "Enter city name",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(8)),
        onSubmitted: (value) {
          setState(() {
            _cityName = value.trim();
            forecastObject = getWeather(cityName: _cityName);
          });
        },
      ),
    );
  }

   Future<WeatherForecastModel> getWeather({String cityName}) =>
       new Network().getWeatherForecast(cityName: _cityName);
}
