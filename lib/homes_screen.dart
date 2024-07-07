import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_ap/api.dart';
import 'package:weather_ap/container/container.dart';
import 'package:weather_ap/model/weather_model.dart';
import 'dart:async';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with RestorationMixin {
  RestorableTextEditingController textController =
      RestorableTextEditingController();
      Timer? _timer;
        String? errorMessage;


  ApiResponse? response;

  RestorableBool inProgress = RestorableBool(false);

  
  
//  @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSearchWidget(),
              if (inProgress.value)
                Container(
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              else
                buildWeatherWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeatherWidget() {
    // return Text(response?.toJson().toString() ?? "");
    if (response == null) {
      return Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 0.80,
              child: Image.asset('asset/location.png')),
          Text(
            "Enter Location",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Text(
              response?.location?.name ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              response?.current?.condition?.text.toString() ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 18,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 20,
            ),
            Lottie.asset(
              _getWeatherAnimation(
                  response?.current?.condition?.text.toString() ?? ""),
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            // SizedBox(
            //   height: 150,
            //   child: Image.network("https:${response?.current?.condition?.icon}".replaceAll("64×64", "128×128"),
            //   scale: 0.7,),
            // ),
            // SizedBox(height: 20,),
            Text(
              (response?.current?.tempC.toString() ?? "") + "°",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container_w(
                  Titles: "Humidity",
                  Subtitle:
                      (response?.current?.humidity?.toString() ?? "") + "%",
                ),
                SizedBox(
                  height: 5,
                ),
                Container_w(
                  Titles: "Wind",
                  Subtitle:
                      (response?.current?.windKph?.toString() ?? "") + " km/h",
                ),
              ],
            ),
            Row(
              children: [
                Container_w(
                  Titles: "uv",
                  Subtitle: response?.current?.uv?.toString() ?? "",
                ),
                Container_w(
                  Titles: "Last updated",
                  Subtitle: _formatTime(response?.current?.lastUpdated),
                ),
              ],
            )
          ],
        ),
      );
    }
  }

  Widget _buildSearchWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimSearchBar(
              boxShadow: true,
              rtl: true,
              width: 200,
              textController: textController.value,
              suffixIcon: Icon(Icons.search_rounded),
              onSuffixTap: () {},
              closeSearchOnSuffixTap: true,
              helpText: 'Search City',
              onSubmitted: (value) {
                _getWeatherdata(value);
              }),
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurStyle: BlurStyle.outer,
                blurRadius: 6,
              )
            ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: IconButton(
                onPressed: () {
                  _getWeatherdata(textController.value.text);
                },
                icon: Icon(Icons.replay_rounded)),
          )
        ],
      ),
    );
  }

  _getWeatherdata(String location) async {
    setState(() {
      // response = null; // Clear the previous response
      inProgress.value = true;
    });
    try {
      response = await Weather_Api().getCurrentWeather(location);
      print("Weather data fetched successfully");
    } catch (e) {
      // print("Error fetching weather data: $e");
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        inProgress.value = false;
      });
    }
  }

  String _formatTime(String? dateTime) {
    if (dateTime == null) return '';
    DateTime parsedDateTime = DateTime.parse(dateTime);
    return DateFormat('hh:mm a').format(parsedDateTime);
  }

  String _getWeatherAnimation(String condition) {
    switch (condition) {
      case "Sunny":
        return 'asset/sunny.json';
      case "Clear":
        return 'asset/clearDN.json';
      case "Partly Cloudy":
        return 'asset/Partly Cloudy.json';
      case "Cloudy":
        return 'asset/cloudy.json';
      case "Overcast":
        return 'asset/cloudy.json';
      case "Mist":
        return 'asset/fog.json';
      case "Patchy rain possible":
        return 'asset/drizzle.json';
      case "Patchy snow possible":
        return 'asset/light snow.json';
      case "Patchy sleet possible":
        return 'asset/sleet.json';
      case "Patchy freezing drizzle possible":
        return 'asset/heavyfleet.json';
      case "Thundery outbreaks possible":
        return 'asset/thundery_outbreaks_possible.json';
      case "Blowing snow":
        return 'asset/snow.json';
      case "Blizzard":
        return 'asset/snow.json';
      case "Fog":
        return 'asset/fog.json';
      case "Freezing fog":
        return 'asset/fog.json';
      case "Patchy light drizzle":
        return 'asset/drizzle.json';
      case "Light drizzle":
        return 'asset/drizzle.json';
      case "Freezing drizzle":
        return 'asset/heavyfleet.json';
      case "Heavy freezing drizzle":
        return 'aasset/heavyfleet.json';
      case "Patchy light rain":
        return 'asset/drizzle.json';
      case "Light rain":
        return 'asset/drizzle.json';
      case "Moderate rain at times":
        return 'asset/rain.json';
      case "Moderate rain":
        return 'asset/rain.json';
      case "Patchy rain nearby":
        return "asset/drizzle.json";
      case "Heavy rain at times":
        return 'asset/rain.json';
      case "Heavy rain":
        return 'asset/rain.json';
      case "Light freezing rain":
        return 'asset/sleet.json';
      case "Moderate or heavy freezing rain":
        return 'asset/heavyfleet.json';
      case "Light sleet":
        return 'asset/sleet.json';
      case "Moderate or heavy sleet":
        return 'asset/heavyfleet.json';
      case "Patchy light snow":
        return 'asset/light snow.json';
      case "Light snow":
        return 'asset/light snow.json';
      case "Patchy moderate snow":
        return 'asset/light snow.json';
      case "Moderate snow":
        return 'asset/snow.json';
      case "Patchy heavy snow":
        return 'asset/snow.json';
      case "Heavy snow":
        return 'asset/snow.json';
      case "Ice pellets":
        return 'asset/pellets.json';
      case "Light rain shower":
        return 'asset/drizzle.json';
      case "Moderate or heavy rain shower":
        return 'asset/Moderate or heavy rain with thunder.json';
      case "Torrential rain shower":
        return 'asset/Moderate or heavy rain with thunder.json';
      case "Light sleet showers":
        return 'asset/sleet.json';
      case "Moderate or heavy sleet showers":
        return 'asset/heavyfleet.json';
      case "Light snow showers":
        return 'asset/light snow.json';
      case "Moderate or heavy snow showers":
        return 'asset/moderate_or_heavy_snow_showers.json';
      case "Light showers of ice pellets":
        return 'asset/pellets.json';
      case "Moderate or heavy showers of ice pellets":
        return 'asset/pellets.json';
      case "Patchy light rain with thunder":
        return 'asset/Moderate or heavy rain with thunder.json';
      case "Moderate or heavy rain with thunder":
        return 'asset/Moderate or heavy rain with thunder.json';
      case "Patchy light snow with thunder":
        return 'asset/snowthunder.json';
      case "Moderate or heavy snow with thunder":
        return 'asset/snowthunder.json';
      default:
        return 'asset/sunny.json'; // Default animation in case no match is found
    }
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => 'Home_page';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
    registerForRestoration(textController, 'name_c');
    registerForRestoration(inProgress, 'inProgress');
  }
}
