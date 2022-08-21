import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Welcome to Union Suites App, here you can communicate with the management at the comfort of your home and book facilities available at our building',
                style: TextStyle(color: Colors.white, fontSize: 15.0),textAlign: TextAlign.center,),
              const SizedBox(height: 50.0,),
              const Text(
                '©Godopetza',
                style: TextStyle(color: Colors.white12, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
