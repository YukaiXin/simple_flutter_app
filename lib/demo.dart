import 'package:flutter/material.dart';

class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: new TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({ this.title, this.icon, this.imageUrl });
  final String title;
  final IconData icon;
  final String imageUrl;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon:Icons.directions_car, imageUrl: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
  const Choice(title: 'BICYCLE', icon:Icons.directions_bike, imageUrl: 'http://imgm6.cnmo-img.com.cn/cnmo_product/23_360x270/916/ceIg60sfokqu.jpg'),
  const Choice(title: 'BOAT', icon:Icons.directions_boat, imageUrl: 'http://img.cnmo-img.com.cn/1697_800x600/1696741.jpg'),
  const Choice(title: 'BUS', icon:Icons.directions_bus, imageUrl: 'http://www.sinaimg.cn/dy/slidenews/1_img/2017_29/88490_1334396_633374.jpg'),
  const Choice(title: 'TRAIN', icon:Icons.train, imageUrl: 'http://www.sinaimg.cn/dy/slidenews/1_img/2017_29/88490_1334401_313462.jpg'),
  const Choice(title: 'WALK', icon:Icons.directions_walk, imageUrl: 'http://www.sinaimg.cn/dy/slidenews/1_img/2017_29/88490_1334404_705991.jpg'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({ Key key, this.choice }) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.lightBlueAccent,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text("哈哈哈", style: textStyle),
            new Image.network(choice.imageUrl),
            new Icon(Icons.dashboard, size: 64.0, color:Colors.red),
            new Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new TabbedAppBarSample());
}