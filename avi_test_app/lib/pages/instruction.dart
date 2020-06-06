import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instructions> {

   final title = "ListView List";

    List choices = const [
       const Choice(
          title: 'HOW TO USE THE APP',
          date: '1 June 2019',
          description:
              '\n1- Make sure you have given all the permissions to the app.\n2- Turn on GPS service of your mobile before you use any service. \n ',
          imglink:
              ''),
      const Choice(
          title: 'Add Image',
          date: '1 June 2019',
          description:
              'You can start your blacklisting or checking operation by adding an image of a vehicle which contains vehicle number plate clearly. When you click on the Add Image button, AVI system gives you two options. \n [1]- Use Camera \n [2]- Use Gallery',
          imglink:
              'assets/addimage.jpeg'),
      const Choice(
          title: 'Use Camera',
          date: '1 June 2016',
          description:
              'You can directly use the camera to capture an image of a vehicle. When you capture an image AVI system gives you two options. \n [1]- Blacklist The Vehicle \n [2]- Check The Vehicle',
          imglink:
              'assets/camera.jpeg'),
      const Choice(
          title: 'Use Gallery',
          date: '1 June 2019',
          description:
              'You can select an image from the device gallery. When you select an image AVI system gives you two options. \n [1]- Blacklist The Vehicle \n [2]- Check The Vehicle',
          imglink:
              'assets/gallery.jpeg'),
      const Choice(
          title: 'Blacklist the Vehicle',
          date: '1 June 2017',
          description:
              'When you capture a suspected vehicle, You can blacklist the vehicle by selecting this option.',
          imglink:
              'assets/blacklist.jpeg'),
      const Choice(
          title: 'Check the Vehicle',
          date: '1 June 2018',
          description:
              'If you want to check a vehicle, You can do it by selecting this option.',
          imglink:
              'assets/check.jpeg'),

      const Choice(
          title: 'Open the Menu',
          date: '1 June 2018',
          description:
              'Application Menu can be opened by clickng on this icon which is placed on top left corner.',
          imglink:
              'assets/drawer.jpeg'),

      const Choice(
          title: 'Options in Menu',
          date: '1 June 2018',
          description:
              'Here you can see the main options of the application.',
          imglink:
              'assets/menu.jpg'),

      const Choice(
          title: 'Reset Your Password',
          date: '1 June 2018',
          description:
              'Here you can reset your user password by providing necessary details',
          imglink:
              'assets/reset.jpeg'),
    ];

  
  // CALLS FUTURE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
       appBar: AppBar(
        title: Text("           Instructions"),
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
            body: new ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: ChoiceCard(
                        choice: choices[index], item: choices[index]),
                  );
                }))
    );
  }
}


class Choice {
  final String title;
  final String date;
  final String description;
  final String imglink;

  const Choice({this.title, this.date, this.description, this.imglink});
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
      this.choice,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Choice choice;

  final VoidCallback onTap;

  final Choice item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.teal[50]);

    return Card(
        color: Colors.teal[50],
        child: Column(
          children: [
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(choice.imglink)),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(choice.title, style: Theme.of(context).textTheme.title),
                  Text(choice.description),
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}