import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



main(){
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Center(child: Text('Fetch Data From REST API\n(Restapi_Listview_http_get )'),
      ),
      ),
      body: MyProject(),
      ),
    );
  }
}



class MyProject extends StatefulWidget {
  MyProject({Key? key}) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  bool error = false;
  bool loading = false;
  String errmsg = "";
  var apidata;

  @override
  void initState() {
   getData();
    super.initState();
  }


  void getData() async {
    setState(() {
      loading = true;
    });

    try {
      String url = "http://192.168.100.100:8087/flutter01/data_mysql.php?auth=kjgdkhdfldfguttedfgr";
      final response = await http.get(Uri.parse("$url"));
      apidata = json.decode(response.body);
    }
    catch (err) {
        error = true;
        errmsg = apidata["msg"];
    }
    setState(() {
      loading = false;
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body:
            ListView(children: [
            Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            child:
                loading
                ? const CircularProgressIndicator()
                : //if loading == true, show progress indicator
                Container(
                    //if there is any error, show error message
                    child:
                    error
                        ? Text("Error: $errmsg")
                        : Column(
                            //if everything fine, show the JSON as widget
                            children: apidata["data"].map<Widget>((country) {
                              return Card(
                                child: ListTile(
                                  title: Text(country["name"]),
                                  subtitle: Text(country["capital"]),
                                  trailing: Text(country["datetime_"]),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                    country["flag"]),
                                    )
                                ),
                              );
                            }).toList(),
                          )
                          )
                          )
                          ],)
                          );
  }
}
