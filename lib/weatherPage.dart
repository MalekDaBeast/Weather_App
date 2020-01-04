import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Weather',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: MyHomePage(title: 'Flutter Weather'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key key, this.title}) : super(key: key);

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

	List<Weather> result = new List<Weather>();

	String key = '12b6e28582eb9298577c734a31ba9f4f';

	WeatherStation station;  

  List<Color> getColors(){

  	if(double.parse(result[0].temperature.toString()) > 20.0){
      return [
        Colors.yellow,
        Colors.orange
      ];
    } 
    
    else if(double.parse(result[0].temperature.toString()) > 10 && 
    double.parse(result[0].temperature.toString()) < 20){

      return [
        Colors.blue,
        Colors.blue
      ];
    }

    else if(double.parse(result[0].temperature.toString()) < 10 && double.parse(result[0].temperature.toString()) > 0){
      return [
        Colors.blue,
        Colors.blueGrey
      ];
    } else {
      return [
        Colors.blue,
        Colors.white
      ];
    }

		

		}

	@override
	void initState() {
		super.initState();

		station = new WeatherStation(key);

		initPlatformState();
	}

	Future<void> initPlatformState() async {
		queryForecast();

	}

	void queryForecast() async {
		List<Weather> f = await station.fiveDayForecast();
		setState(() {
			result = f;
		});
	}


	@override
	Widget build(BuildContext context) {
		return Scaffold(
	body: Container(
		child:Stack(
      children: <Widget>[

        Positioned(
          left: 110,
          top: 50,
          child: Image(
            height: 150,
            width: 150,
            fit: BoxFit.fill,
          image:NetworkImage(

            "http://openweathermap.org/img/w/" + result[0].weatherIcon + ".png"

            ),
        ),
        ),

        Positioned(
          left: 110,
          top: 200,
            child: Text(result[0].weatherMain,
              style: TextStyle(fontSize: 40,
              color: Colors.white),
            ),
        ),

           Align(
              alignment: Alignment.center,
              child: Text(result[0].temperature.toString() + '°C',
              style: TextStyle(
                fontSize: 100,
                color: Colors.white
              ),
              ),
            ),

            Positioned(
              left: 100,
              top: 420,
              child: Text('Wind Speed: '+result[0].windSpeed.toString(),
              style: TextStyle(
                fontSize: 20
              ),),),

              Positioned(
              left: 100,
              top: 450,
              child: Text('Rain last Hour: '+result[0].rainLastHour.toString(),
              style: TextStyle(
                fontSize: 20
              ),),),

              Positioned(
              left: 100,
              top: 480,
              child: Text('Cloudiness: '+result[0].cloudiness.toString(),
              style: TextStyle(
                fontSize: 20
              ),),),

              Positioned(
              left: 100,
              top: 510,
              child: Text('Pressure: '+result[0].pressure.toString(),
              style: TextStyle(
                fontSize: 20
              ),),),

            


      ],
		),

		decoration: BoxDecoration(
			gradient: LinearGradient(
				begin: Alignment.topLeft,
				end: Alignment.bottomRight,
				stops: [0.1,  0.9],
				colors: getColors()
			),
		),
	),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.refresh),
				onPressed: (){
					queryForecast();


				},
			)
		);
	}

 /* int parseInt(String src) {
  var np = RegExp(r"^(0o[0-7]+|0b[0-1]+|0x[0-9A-Fa-f]+|[0-9]+)$").matchAsPrefix(src);
  if (np == null) return null;
  var pf = np.group(0).length > 2 ? np.group(0).substring(1, 2) : "";
  var str = pf == "x" || pf == "b" || pf == "o" ? np.group(0).substring(2) : np.group(0);
  return int.parse(str, radix: pf == "x" ? 16 : pf == "b" ? 2 : pf == "o" ? 8 : 10);
}*/

}