import 'package:com_piton_work_follow/models/work.dart';

class DataList {

  static List<Work> works = [
    Work.withId(1,"Market","Alışverisş yap",100,DateTime(2020,8,1),1),
    Work.withId(2,"Fatura","Fatura Öde",200,DateTime(2020,1,1),4),
    Work.withId(3,"Temizlik","Araba Yıkanaacak",300,DateTime(2020,7,11),2),
    Work.withId(4,"Koşu","Koşu yap",400,DateTime(2020,1,1),1),
    Work.withId(5,"Ödeme Yap","Meyve ücretini Öde",200,DateTime(2020,1,1),4),
    Work.withId(6,"Oyun","Fifa Oyna",400,DateTime(2020,6,1),2),
    Work.withId(7,"Flutter","Programlama Çalış Flutter",100,DateTime(2020,8,1),1),
    Work.withId(8,"Ütü","Ütü yapılacak",200,DateTime(2020,1,10),4),
    Work.withId(9,"Çizim","REsim yapılacak",300,DateTime(2020,6,1),2),
  ];

  List<Work> List_Work(){
    return works;
  }

  void AddWork(Work ){

  }

}
