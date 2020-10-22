import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int length = 8;
  List<bool> low = List.generate(length, (i) => true);
  List<String> data = ["A","A","B","B","C","C","D","D"];
  List<GlobalKey<FlipCardState>> cardStateKey = List.generate(length, (i) => GlobalKey<FlipCardState>());
  int previosIndex = -1;
  bool flip = false;
  int time = 0;
  Timer timer;
  startTime(){
    timer = Timer.periodic(Duration(seconds:1),(t) {
      setState(() {
        time += 1;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    data.shuffle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.8),
                child: Text(
                  "Time: $time",
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (context, index) => FlipCard(
                  key: cardStateKey[index],
                  onFlip: (){
                    if(!flip){
                      flip = true;
                      previosIndex = index;
                    }else{
                      flip = false;
                      if(previosIndex != index){
                        if(data[previosIndex] != data[index]){
                          cardStateKey[previosIndex].currentState.toggleCard();
                          previosIndex = index;
                        }else{
                          low[previosIndex] = false;
                          low[index] = false;
                          print("achou");
                          if(low.every((element) => element == false)){
                            print("vitoria");
                            showResult();
                          }
                        }
                      }
                    }
                  },
                  direction: FlipDirection.HORIZONTAL,
                  flipOnTouch: low[index],
                  front: Container(
                    margin: EdgeInsets.all(4.0),
                    color: Colors.blueAccent.withOpacity(0.8),
                  ),
                  back: Container(
                    margin: EdgeInsets.all(4.0),
                    color: Colors.deepPurpleAccent.withOpacity(0.4),
                    child: Center(
                      child: Text("${data[index]}", style: Theme.of(context).textTheme.display2,),
                    ),
                  ),
                ),
                itemCount: data.length,
              )
            ],
          ),
        )
      ),
    );
  }

  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("INCRIVEL"),
        content: Text(
          "SEU TEMPO FOI DE $time",
          style: Theme.of(context).textTheme.display2,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Text("Proxima"),
          ),
        ],
      ),
    );
  }
}
