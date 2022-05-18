import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(

      ),
    );
  }
}




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool typing = false;

  late Map data;
  late List userData;

  Future getData() async {
    http.Response response = await http.get("https://reqres.in/api/users?page=1");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: typing ? TextBox(): Text('Search'),
        leading: IconButton(
          icon: Icon(typing ? Icons.done: Icons.search,),
          onPressed: (){
            setState(() {
              typing = !typing;
            });
          },
        ),

        backgroundColor: Colors.blueGrey,
      ),

      backgroundColor: Colors.grey.shade500,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
           Container(
             padding: EdgeInsets.all(50.0),
             color: Colors.blueGrey,
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               ],
             ),

           ),

            ListTile(
              title: const Text('Contact', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,
                  color: Colors.black54),),
              onTap: (){
                Navigator.pop(context);
              },
            ),

            ListTile(
              title: const Text('About Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,
                  color: Colors.black54),),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData[index]["avatar"]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${userData[index]["first_name"]} ${userData[index]["last_name"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      color: Colors.white,
      child: TextField(
        decoration:
        InputDecoration(border: InputBorder.none, hintText: '  Search'),
      ),
    );
  }
}
