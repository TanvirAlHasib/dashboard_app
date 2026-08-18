import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigationProvider extends ChangeNotifier{

  final List<int> _branchList = [0];
  List<int> get history => _branchList;

  // adding index on new tap
  void onAdd(int index, BuildContext context, dynamic navigationShell){
    if(navigationShell.currentIndex == index){
      return;
    }
    _branchList.remove(index);
    _branchList.add(index);
    notifyListeners();
    navigationShell.goBranch(index);
  }

  void handleBack(BuildContext context, dynamic navigationShell){
    if(_branchList.length > 1){
      _branchList.removeLast();
    }
    notifyListeners();
    navigationShell.goBranch(_branchList.last);
  }
}