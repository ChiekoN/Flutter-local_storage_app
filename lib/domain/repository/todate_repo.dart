import '../models/todate.dart';

abstract class TodateRepo {
  
  Future<List<Todate>> getTodates();

  Future<void> addTodate(Todate newTodate);

  Future<void> updateTodate(Todate todate);

  Future<void> deleteTodate(Todate todate);
  
  /*
  List<Todate> getTodates();

  //List<Todate> getFutureTodates();

  void addTodate(Todate newTodate);

  void updateTodate(Todate todate);

  void deleteTodate(Todate todate);
  */
}
