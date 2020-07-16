import 'dart:ui';

import 'package:flutter/material.dart';

class Tools {

  static Color _color;
  static Color _importance;
  static String importanceValue;

   Color getColorStatus(int status){
     _color = Color.fromARGB(128, 0, 0, 0);
    switch(status){
      case 100: {
        _color = Color.fromARGB(255,30, 144, 255);
      }
      break;
      case 200: {
        _color = Color.fromARGB(255, 0, 128, 0);
      }
      break;
      case 300: {
        _color = Color.fromARGB(255, 255, 165, 0);
      }
      break;
      case 400: {
        _color = Color.fromARGB(255, 255, 0, 0);
      }
      break;
    }
    return _color;
  }

  Color getColorImportance(int importance){
    _importance = Colors.black;
    switch(importance){
      case 1: {
        _importance = Colors.green;
      }
      break;
      case 2: {
        _importance = Colors.blue;
      }
      break;
      case 3: {
        _importance = Colors.deepOrange;
      }
      break;
      case 4: {
        _importance = Color.fromARGB(255, 125, 0, 0);
      }
      break;
    }
    return _importance;
  }

  getImportanceValue(importance){
    importanceValue = "";
    switch(importance){
      case 1: {
        importanceValue = "Önemsiz";
      }
      break;
      case 2: {
        importanceValue = "Normal";
      }
      break;
      case 3: {
        importanceValue = "Önemli";
      }
      break;
      case 4: {
        importanceValue = "Kritik";
      }
      break;
    }
    return importanceValue;
  }

  Future<void> showMyDialog({BuildContext context, String title, ListBody body}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
            child: body
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}