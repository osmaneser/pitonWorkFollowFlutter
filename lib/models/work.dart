class Work{
  int id;
  String name;
  String description;
  int status;
  DateTime workDate;
  DateTime startDate;
  DateTime endDate;
  int importance;

  Work(String name, String description, int status, DateTime workDate, int importance){
    this.name = name;
    this.description = description;
    this.status = status;
    this.workDate = workDate;
    this.importance = importance;
  }
  Work.withId(int id, String name, String description, int status, DateTime workDate, int importance){
    this.id = id;
    this.name = name;
    this.description = description;
    this.status = status;
    this.workDate = workDate;
    this.importance = importance;
  }

}