import 'package:avi_test_app/database/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avi_test_app/database/database.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var db = new DatabaseHelper();
  // CALLS FUTURE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title: Text('          Recent History'),
        backgroundColor: Colors.lightGreen[800],
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.time_to_leave,
              color: Colors.white,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: db.getHistory(),
        initialData: List(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lightGreen[200],
                      child: ListTile(
                        leading: Text(data[index].vehiclenumber),
                        title: Text(data[index].datetime),
                        subtitle: Text("Latitude - " +
                            data[index].latitude +
                            " \nLongitude - " +
                            data[index].longitude +
                            "\nResponse - " +
                            data[index].isBlacklisted),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
