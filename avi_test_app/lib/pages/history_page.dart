import 'package:avi_test_app/database/history.dart';
import 'package:avi_test_app/pages/logger.dart';
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
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('Recent History'),
        backgroundColor: Colors.teal[700],
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
      body: Container(
    decoration: new BoxDecoration(
    color: Colors.yellow[50],
    ),
        child:FutureBuilder<List>(
        future: db.getHistory(userid),
        initialData: List(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(20.0),
                            bottomLeft: const Radius.circular(20.0),
                            bottomRight: const Radius.circular(20.0),
                            topRight: const Radius.circular(20.0),
                          )
                      ),
                      padding: new EdgeInsets.all(10.0),
                    child: ListTile(
                        leading: Text(data[index].vehiclenumber,
                        style:TextStyle(fontWeight: FontWeight.bold),),
                        title: Text(data[index].isBlacklisted,
                          style:TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text("Latitude - " +
                            data[index].latitude +
                            " \nLongitude - " +
                            data[index].longitude +
                            "\nDatetime - " + data[index].datetime 
                            ),
                      ),

                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      ),
    );
  }
}
