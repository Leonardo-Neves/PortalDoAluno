import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //List<int> _listItems = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  var count = 0;

  void buttonAction(String name) {
    print('pressed ' + name);
  }

  @override
  void initState() {
    // Executed when init the page

    super.initState();
  }

  @override
  void dispose() {
    // Remove all the states on stoping

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text(
          '$count',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      /*
        Container(
        width: double.infinity,
        child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: ValueKey(123),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => {print(direction)},
                  background: Container(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 4.0),
                    child: ListTile(
                      title: Text('Count => ${_listItems[index]}'),
                    ),
                  ));
              /*
              return ListTile(
                title: Text('Count => ${_listItems[index]}'),
              );
              */
            },
            /*
            separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.red,
                ),
                */
            itemCount: _listItems.length),
      ),*/
      /*
        Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: _listItems.length,
            itemBuilder: (BuildContext context, int index) {
              //return Text('Count : ${_listItems[index]}');
              return ListTile(
                  title: Text('Count : ${_listItems[index]}'),
                  subtitle: Text('PK'),
                  leading: Icon(Icons.done),
                  trailing: Icon(Icons.close),
                  onTap: () {
                    print('Pressed ${_listItems[index]}');
                  });
            },
          )
          /*
          ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(20.0),
          children: _listItems.map((e) {
            return Text('Count : ${e}');
          }).toList(),

          /*
          children: <Widget>[
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
            Text('Test'),
          ],
          */
        )
        
        
        */

          /*
        child: Image.network(
          'src',
          frameBuilder: (BuildContext context, Widget child, int frame,
              bool isAsyncLoaded) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: child,
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            return Center(
              child: Text('Loading image'),
            );
          },
          errorBuilder: (BuildContext context, Object error, StackTrave st) {
            return Center(
              child: Text('Error occured'),
            );
          },
        ),
        */
          /*
        Image.asset(
          'asset/Capturar.png',
          //fit: BoxFit.contain,
          //alignment: Alignment.topCenter,
          repeat: ImageRepeat.repeatX,
        ),
        */
          )
          */

      /*
      Image.asset(
        'asset/Capturar.png',
        height: 100.0,
        width: 100.0,
        frameBuilder: (BuildContext context, Widget child, int frame, bool wasSynchronouslyLoaded,) {},
        
      ),
      */
      /*
      Center(
          child: Padding(
        // Use Padding when we only want to use padding
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Test',
          textAlign: TextAlign.center,
        ),
        
      )
      

          /*
        Container(

            //Container Properties

            constraints: BoxConstraints(maxHeight: 300.0, minHeight: 100.0),
            width: double.infinity,
            height: double.infinity,
            //color: Colors.red,
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.only(
                bottom: 10.0, top: 12.0, left: 8.0, right: 16.0),
            decoration: BoxDecoration(
              // Shape of the container
              color: Colors.red,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Test',
              textAlign: TextAlign.center,
            )), // CTRL + SHIFT + R to add a container
            */

          /*
        child: Ink(
          // Ink to add a background to a IconButton
          decoration:
              ShapeDecoration(shape: CircleBorder(), color: Colors.blue),
          child: IconButton(
            icon: Icon(Icons.android),
            onPressed: () => print('Button pressed'),
          ),
        ),
        */

          /*
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => print('Button pressed'),
            color: Colors.red,
            iconSize: 40.0,
            splashColor: Colors.green,
            padding: EdgeInsets.all(20.0),
            tooltip: 'description of the button',
            
          ),
          */
          ),
          */
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        icon: Icon(Icons.add),
        onPressed: () {
          print('FAB pressed');
          setState(() {
            count++;
          });
        },
        backgroundColor: Colors.red[300],
        tooltip: 'Tooltip',
      ),
      /*
        Center(
            child: OutlinedButton(
          onPressed: () => print('Button pressed'),
          child: Text('Press me')
        ))
        */
      /*
      Center(
          child: RaisedButton(
              // RaisedButton has a shadow above the button
              onPressed: null,
              elevation: 10,
              disabledColor: Colors.cyan,
              child: Icon(Icons.add))),
      */
      /*
      Center(
        child: FlatButton(
          child: Icon(Icons.add),
          onPressed: () => buttonAction('Leo'),
          color: Colors.red,
          colorBrightness: Brightness.dark,
          disabledColor: Colors.cyan,
          onLongPress: () => print('Long pressed'),
        ),
      ),
      */

      /*
        Center(
          child: FlatButton(
            child: Text('Press me'),
            onPressed: () => print('pressed'),
          ),
        ),
        */

      /*
        Center(
          child: RichText(
            // Use RichText for get different sizes and colors for the same string
            text: TextSpan(
                text: 'Programming ',
                style: TextStyle(color: Colors.cyan, fontSize: 15),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Knowledge',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                      )),
                  TextSpan(
                      text: 'Flutter',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                      ))
                ]),
          ),
        )
        */
      /*
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Test1",
                style: TextStyle(
                    backgroundColor: Colors.red,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            ))
            */
    );
  }
}
