import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            autocorrect: true,
            //autofocus: true,
            controller: _textController,
            enabled: true,
            enableInteractiveSelection: true,
            enableSuggestions: true,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(30.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide()),
                fillColor: Colors.green[50],
                filled: true,
                hintText: 'Enter name', // Placeholder
                hintStyle: TextStyle(color: Colors.red),
                icon: Icon(Icons.person),
                labelText: 'name',
                labelStyle: TextStyle(color: Colors.yellow)),
            onChanged: (value) => print(value),
            //onEditingComplete: ,
            //onSubmitted: ,
            //onTap: ,
            //readOnly: false,
            //textAlign: TextAlign.center,
            //textAlignVertical: ,
            //textInputAction: TextInputAction.,
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () => print(_textController.text),
        icon: Icon(Icons.add),
      ),
    );
  }
}
