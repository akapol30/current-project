class Weather{
  
  dynamic tempmin0;
  dynamic tempmax0;
  String? weatherMain0;
  String? weathericon0;
  int? date0;

  dynamic tempmin1;
  dynamic tempmax1;
  String? weatherMain1;
  String? weathericon1;
  int? date1;

  dynamic tempmin2;
  dynamic tempmax2;
  String? weatherMain2;
  String? weathericon2;
  int? date2;

  dynamic tempmin3;
  dynamic tempmax3;
  String? weatherMain3;
  String? weathericon3;
  int? date3;

  dynamic tempmin4;
  dynamic tempmax4;
  String? weatherMain4;
  String? weathericon4;
  int? date4;

  dynamic tempmin5;
  dynamic tempmax5;
  String? weatherMain5;
  String? weathericon5;
  int? date5;

  dynamic tempmin6;
  dynamic tempmax6;
  String? weatherMain6;
  String? weathericon6;
  int? date6;

  Weather({
    
    this.tempmin0,
    this.tempmax0,
    this.weatherMain0,
    this.weathericon0,
    this.date0,

    this.tempmin1,
    this.tempmax1,
    this.weatherMain1,
    this.weathericon1,
    this.date1,

    this.tempmin2,
    this.tempmax2,
    this.weatherMain2,
    this.weathericon2,
    this.date2,

    this.tempmin3,
    this.tempmax3,
    this.weatherMain3,
    this.weathericon3,
    this.date3,
    
    this.tempmin4,
    this.tempmax4,
    this.weatherMain4,
    this.weathericon4,
    this.date4,
    
    this.tempmin5,
    this.tempmax5,
    this.weatherMain5,
    this.weathericon5,
    this.date5,

    this.tempmin6,
    this.tempmax6,
    this.weatherMain6,
    this.weathericon6,
    this.date6

});

  Weather.fromJson(Map<String,dynamic> json){
    
    tempmin0=json["daily"][0]["temp"]["min"];
    tempmax0=json["daily"][0]["temp"]["max"];
    weatherMain0=json["daily"][0]["weather"][0]["main"];
    weathericon0=json["daily"][0]["weather"][0]["icon"];
    date0= json["daily"][0]["dt"];

    tempmin1=json["daily"][1]["temp"]["min"];
    tempmax1=json["daily"][1]["temp"]["max"];
    weatherMain1=json["daily"][1]["weather"][0]["main"];
    weathericon1=json["daily"][1]["weather"][0]["icon"];
    date1= json["daily"][1]["dt"];

    tempmin2=json["daily"][2]["temp"]["min"];
    tempmax2=json["daily"][2]["temp"]["max"];
    weatherMain2=json["daily"][2]["weather"][0]["main"];
    weathericon2=json["daily"][2]["weather"][0]["icon"];
    date2= json["daily"][2]["dt"];
  
    tempmin3=json["daily"][3]["temp"]["min"];
    tempmax3=json["daily"][3]["temp"]["max"];
    weatherMain3=json["daily"][3]["weather"][0]["main"];
    weathericon3=json["daily"][3]["weather"][0]["icon"];
    date3= json["daily"][3]["dt"];

    tempmin4=json["daily"][4]["temp"]["min"];
    tempmax4=json["daily"][4]["temp"]["max"];
    weatherMain4=json["daily"][4]["weather"][0]["main"];
    weathericon4=json["daily"][4]["weather"][0]["icon"];
    date4= json["daily"][4]["dt"];

    tempmin5=json["daily"][5]["temp"]["min"];
    tempmax5=json["daily"][5]["temp"]["max"];
    weatherMain5=json["daily"][5]["weather"][0]["main"];
    weathericon5=json["daily"][5]["weather"][0]["icon"];
    date5= json["daily"][5]["dt"];

    tempmin6=json["daily"][6]["temp"]["min"];
    tempmax6=json["daily"][6]["temp"]["max"];
    weatherMain6=json["daily"][6]["weather"][0]["main"];
    weathericon6=json["daily"][6]["weather"][0]["icon"];
    date6= json["daily"][6]["dt"];
  }
}