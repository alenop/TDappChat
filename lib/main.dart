import 'dart:collection';
import 'chat.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FakeSocket socket = FakeSocket();
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePass=true;
  hidden(){
    setState(() {
      hidePass=!hidePass;  
    });
    
  }

  msg(String msg){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
     content: Text(msg),
));
  }

  login(){
    final logged = socket.login(idController.text, passwordController.text);
    
    if(logged){
      msg("Good Job You are logged in ");
    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyChat(id:idController.text)
                    ));
    }else {
      msg("You have failed try again ? Or Rot to hell within this world without the best chat ever");
    }
  }
  register(){
    socket.register(idController.text, passwordController.text);
    msg("Good Job You are registered in ,you can almost access to the most delicacies you have ever seen (login)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller:idController,
  decoration: const InputDecoration( 
    
    hintText: 'Id here go on BeauGosseDu93',
  ),
),
TextField(
              controller:passwordController,
              obscureText: hidePass,
  decoration: InputDecoration( 
    suffixIcon: IconButton(
      onPressed: hidden,
      icon:const Icon(Icons.remove_red_eye_outlined),
    ),
    hintText: 'Please put your password you have already put on all the others websites',
  ),
),

Row(children: [
  ElevatedButton(onPressed: login, child:const Text("Login")),
  ElevatedButton(onPressed: register, child: const Text("Register"))
],)
          ],
        ),
      );
  }
}

class User {
  String? id;
  String? password;
  User(String id, String pass) {
    id = id;
    password = pass;
  }
}

class FakeSocket {
  HashMap<String, User> users = HashMap();

  register(String id, String pass) {
    users.addAll({id: User(id, pass)});
  }

  login(String id, String pass) {
    if (!users.containsKey(id)) {
      return false;
    }
    return users[id]?.password == pass;
  }



}
