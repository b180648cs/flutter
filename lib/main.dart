import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
    builder: (context, snapshot) {
    // Check for errors
    if (snapshot.hasError) {
    return const Text("eroor ");
    }

    // Once complete, show your application
    if (snapshot.connectionState == ConnectionState.done) {
    return MaterialApp(
      title: "kasdj as",
      home:MyHomePage()
    ) ;

    }

    // Otherwise, show something whilst waiting for initialization to complete
    return MaterialApp(
      home: Home(),
    );
  }
    );
}
}
class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text("Loading"),
    );
  }

}

class MyHomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bandnames').snapshots(),
        builder: (context,snapshot)
        {
          if(!snapshot.hasData)
            return const Text("Loading...");

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index)=>buildListItem(context,snapshot.data.docs[index])
          );

        },
      ),
    );
  }
  Widget buildListItem(BuildContext context,DocumentSnapshot snapshot)
  {
    return ListTile(
      title: Text(snapshot['Name']),
      subtitle: Text(snapshot['Votes'].toString()),
    );
  }

}