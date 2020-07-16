import 'package:com_piton_work_follow/models/work.dart';
import 'package:com_piton_work_follow/util/tools.dart';
import 'package:flutter/material.dart';

class AddWork extends StatefulWidget {
  List<Work> works;

  //AddWork(List<Work> works){
      //this.works = works;
  //}

  AddWork(this.works);

  @override
  State<StatefulWidget> createState(){
    return _AddWorkState();
  }
}

class _AddWorkState extends State<AddWork>{

  var formKey = GlobalKey<FormState>();
  final _tools = Tools();
  Work _work = Work('','',0,null,0);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Yeni İş"),),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildWorkNameField(),
              buildWorkDescField(),
              buildWorkImportanceField(),
              buildDatePickerField(context),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                child: buildSubmitButtonField(),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildWorkNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "İş Adı *", hintText: "Alışveriş"),
      onSaved: (String value){
        _work.name = value;
      },
    );
  }

  buildWorkDescField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Açıklama (İsteğe Bağlı)", hintText: "Domates, Biber, Salatalık Alınacak..."),
      style: TextStyle(color: Colors.black),
      onSaved: (String value){
        _work.description = value;
      },
    );
  }

  var dropdownValue = 1;
  buildWorkImportanceField() {

    return DropdownButton<int>(
      value: dropdownValue,
      isExpanded: true,
      icon: Icon(Icons.arrow_downward),
      iconSize: 14,
      itemHeight: 70,
      onChanged: (int newValue) {
        setState(() {
          dropdownValue = newValue;
          _work.importance = newValue;
        });
      },
      items: <int>[1,2,3,4]
          .map<DropdownMenuItem<int>>((int value) {
            print(value);


            return DropdownMenuItem<int>(
              value: value,
              child: Text(_tools.getImportanceValue(value),style: TextStyle(color: _tools.getColorImportance(value)),),
            );


      }).toList(),
    );
  }

  DateTime selectedDate = DateTime.now();
  buildDatePickerField(BuildContext context){

    return TextFormField(
      decoration: InputDecoration(labelText: "Tarih Seçiniz",icon: Icon(Icons.date_range),hintText: selectedDate.toString()),
      readOnly: true,
      onTap: (){
         setState(() {
            _selectDate(context);
         });
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _work.workDate = picked;
      });
  }
  buildSubmitButtonField() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        print(_work.workDate);
        print(_work.name == null);
        print(_work.name == "");
        if(_work.workDate == null || _work.name == null || _work.importance == 0){

          var body = ListBody(
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  child: Icon(Icons.info_outline,color: Colors.deepOrange,size: 50,),
                  margin:EdgeInsets.all(5),
                ),
                Text("Zorunlu Alanları Doldurunuz!")
              ],)
            ],
          );
          _tools.showMyDialog(context: context,title: 'Hata Oluştu', body: body);
        }
        else{
          setState(() {
            formKey.currentState.save();
            print("SAYI:: "+widget.works.length.toString());
            widget.works.add(_work);
            Navigator.pop(context);
          });

        }
      },
    );
  }


}