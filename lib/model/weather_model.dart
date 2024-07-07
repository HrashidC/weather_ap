class ApiResponse {
  Location? location;
  Current? current;

  ApiResponse({this.location, this.current});

  ApiResponse.fromJson(Map<String, dynamic> json) {
  location = json['location'] != null ? Location.fromJson(json['location'] as Map<String, dynamic>) : null;
    current = json['current'] != null ? Current.fromJson(json['current'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }
}


class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }
}
class Current {
  String? lastUpdated;
  double? tempC;
  Condition? condition;
  double? windMph;
  double? windKph;
  int? humidity;
  double? uv;

  Current({
    this.lastUpdated,
    this.tempC,
    this.condition,
    this.windMph,
    this.windKph,
    this.humidity,
    this.uv,
  });

  Current.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['last_updated'];
    tempC = json['temp_c'] != null ? (json['temp_c'] as num).toDouble() : null;
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'] as Map<String, dynamic>)
        : null;
    windMph = json['wind_mph'] != null ? (json['wind_mph'] as num).toDouble() : null;
    windKph = json['wind_kph'] != null ? (json['wind_kph'] as num).toDouble() : null;
    humidity = json['humidity'] as int?;
    uv = json['uv'] != null ? (json['uv'] as num).toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_updated'] = lastUpdated;
    data['temp_c'] = tempC;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_mph'] = windMph;
    data['wind_kph'] = windKph;
    data['humidity'] = humidity;
    data['uv'] = uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }
}
