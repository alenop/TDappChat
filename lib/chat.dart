import 'package:flutter/material.dart';

class MyChat extends StatelessWidget {
  final String id;
  const MyChat({super.key, required this.id});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Chat Page', id: id);
  }
}

List<String> answers = [
  "Hi I am doing great and you ?",
  "Any news from angela ?",
  "But she owns Three casinos, she was incredible",
  "You sure ? Let me repeat it to you once again",
  "So angela walk in the street, she's stunning most beautifull woman you have ever seen, she says she is a prostitute",
  "5000 dollars",
  "come with me a litlle bit something to show you",
  "You see this Bar ? i bought it with the handJobs, he is now thinking she must give the most perfect handjobs",
  "The deal is done and she indeed do the most perfect handjob he ever got",
  "15000",
  "Come with me",
  "You see theses 3 casinos ? I bought them with the blowJobs, thinking again she must give the most perfect blowjobs",
  "come with me"
      "you see all this ? He see all Las Vegas on the window"
      "Imagine if i had a pussy"
];

class MyHomePage extends StatefulWidget {
  final String id;

  const MyHomePage({Key? key, required this.title, required this.id})
      : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //String chat = "";
  int count = 0;
  List<String> chats = ["Begginning of the chat"];

  TextEditingController messageController = TextEditingController();

  Future<void> waitOneSecond() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  getColor(int index) {
    if (index % 2 == 0) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  String iaMsg() {
    return answers[count];
  }

  void addMessage(id, msg) {
    setState(() {
      chats.add(id + " says : " + msg);
      //chat+="\n"+id+" says : "+msg;
    });
  }

  void _addToChat() async {
    addMessage(widget.id, messageController.text);
    messageController.text="";
    await waitOneSecond();
    addMessage("Bot", iaMsg());
    count++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          // Header widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addToChat,
                ),
                hintText: 'Say Something',
              ),
            ),
          ),
          // Chat interface
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return Text(
                  chats[index],
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: getColor(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
