import 'dart:io';

import 'package:com_piton_work_follow/data/dataWork.dart';
import 'package:com_piton_work_follow/models/work.dart';
import 'package:com_piton_work_follow/screens/add_work.dart';
import 'package:com_piton_work_follow/util/tools.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen()
    );
  }

}

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State {

  List<Work> filteredWorks = [];
  List<Work> works = [
    Work.withId(1,"Market","Alışverisş yap",100,DateTime(2020,7,30),1),
    Work.withId(2,"Fatura","Fatura Öde",200,DateTime(2020,6,25),4),
    Work.withId(3,"Temizlik","Araba Yıkanaacak",300,DateTime(2020,7,14),2),
    Work.withId(4,"Koşu","Koşu yap",400,DateTime(2020,7,10),1),
    Work.withId(5,"Ödeme Yap","Meyve ücretini Öde",200,DateTime(2020,6,3),4),
    Work.withId(6,"Oyun","Fifa Oyna",400,DateTime(2020,7,11),2),
    Work.withId(7,"Flutter","Programlama Çalış Flutter",100,DateTime(2020,7,28),1),
    Work.withId(8,"Ütü","Ütü yapılacak",200,DateTime(2020,7,16),4),
    Work.withId(9,"Çizim","REsim yapılacak",300,DateTime(2020,7,15),2),
  ];

  final _tools = Tools();

  int selectedViewType = 4;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("İş Listesi"),),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: getWeeklyButtons(),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: filteredWorks.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(filteredWorks[index].name),
                  subtitle: Text(filteredWorks[index].description),
                  onTap: (){
                    var _work = filteredWorks[index];
                    var body = ListBody(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("İş Açıklaması : ", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_work.description)
                          ],
                        )
                      ],
                    );

                    _tools.showMyDialog(context: context, title: _work.name,body: body);

                  },
                  leading: CircleAvatar(
                    child: Icon(Icons.more_horiz,color: Colors.white,),
                    backgroundColor:_tools.getColorStatus(filteredWorks[index].status),
                  ),
                  trailing: getProcessButtons(filteredWorks[index]),
                );
              }
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: RaisedButton(
                color: Colors.amberAccent,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    SizedBox(width: 1,),
                    Text("Yeni İş"),
                  ],
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddWork(works)));
                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: RaisedButton(
                color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.home),
                    SizedBox(width: 5,),
                    Text("Ana Sayfa")
                  ],
                ),
                onPressed: (){

                },
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: RaisedButton(
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.perm_identity),
                    SizedBox(width: 5,),
                    Text("Liste")
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }


  List<Widget> getWeeklyButtons(){
    return <Widget>[
      Container(
        margin: EdgeInsets.all(3),
        child: ButtonTheme(
          height: 30,
          minWidth: 20,
          child: RaisedButton(
            color: selectedViewType == 1 ? Colors.blue : Colors.black45,
            textColor: Colors.white,
            child: Row(
              children: <Widget>[
                Text("Günlük")
              ],
            ),
            onPressed: (){
              setState(() {
                getRangeWorkList(1);
              });
            },
          ),
        )
      ),
      Container(
          margin: EdgeInsets.all(3),
          child: ButtonTheme(
            height: 30,
            minWidth: 20,
            child: RaisedButton(
              color: selectedViewType == 2 ? Colors.blue : Colors.black45,
              textColor: Colors.white,
              child: Row(
                children: <Widget>[
                  Text("Haftalık")
                ],
              ),
              onPressed: (){
                setState(() {
                  getRangeWorkList(2);
                });
              },
            ),
          )
      ),
      Container(
          margin: EdgeInsets.all(3),
          child: ButtonTheme(
            height: 30,
            minWidth: 20,
            child: RaisedButton(
              color: selectedViewType == 3 ? Colors.blue : Colors.black45,
              textColor: Colors.white,
              child: Row(
                children: <Widget>[
                  Text("Aylık")
                ],
              ),
              onPressed: (){
                setState(() {
                  getRangeWorkList(3);
                });
              },
            ),
          )
      ),
      Container(
          margin: EdgeInsets.all(3),
          child: ButtonTheme(
            height: 30,
            minWidth: 20,
            child: RaisedButton(
              color: selectedViewType == 4 ? Colors.blue : Colors.black45,
              textColor: Colors.white,
              child: Row(
                children: <Widget>[
                  Text("Tümü")
                ],
              ),
              onPressed: (){
                setState(() {
                  getRangeWorkList(4);
                });
              },
            ),
          )
      )
    ];
  }

  Wrap getProcessButtons(Work work){
    List<Widget> buttons = [];

    if(work.status == 100 || work.status == 400){
      buttons.add(
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: (){
              setState(() {
                StartWork(work.id);
              });
            },
          )
      );
    }
    else if(work.status == 300){
      buttons.add(
          IconButton(
            icon: Icon(Icons.flag),
            onPressed: (){
              setState(() {
                FinishWork(work.id);
              });
            },
          )
      );
    }
    buttons.add(
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: (){
            setState(() {
              DeleteWork(work.id);
            });
          },
        ));

    return Wrap(
      children: buttons
    );
  }


  //// status: kıyaslanacak tip
  //// status: 1:Günlük, 2:Haftalık, 3:Aylık
  List<Work> getRangeWorkList(int viewType){
    final DateTime now = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
    selectedViewType = viewType;
    switch(viewType){
      case 1: {
        filteredWorks = works.where((element) => element.workDate.toLocal() == now.toLocal()).toList();
      }
      break;
      case 2: {
        filteredWorks = works.where((element) => (element.workDate.compareTo(now) == 1 && element.workDate.compareTo(now.add(Duration(days: 7))) == -1 ) ).toList();
        print("works.length");
        print(works.length);
      }
      break;
      case 3: {
        filteredWorks = works.where((element) => (element.workDate.compareTo(now) == 1 && element.workDate.compareTo(now.add(Duration(days: 30))) == -1 ) ).toList();
      }
      break;
      case 4: {
        filteredWorks = works;
      }
      break;
    }

    return filteredWorks;

  }

  void DeleteWork(int workId){
    Work findWork = works.firstWhere((element) => element.id == workId);
    works.removeAt(works.indexOf(findWork));
    getRangeWorkList(selectedViewType);
  }

  void StartWork(int workId){
    Work findWork = works.firstWhere((element) => element.id == workId);
    findWork.status = 300;
  }

  void FinishWork(int workId){
    Work findWork = works.firstWhere((element) => element.id == workId);
    findWork.status = 200;
  }

}