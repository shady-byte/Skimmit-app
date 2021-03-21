import 'package:mobx/mobx.dart';
part 'blocControl.g.dart';

class BlocStore = _BlocControl with _$BlocStore;

abstract class _BlocControl with Store {
  @observable
  String name = '';
  @observable
  String gender = 'male';
  @observable
  bool signedIn = false;
  @observable
  String token = '';
  @observable
  double height = 0;
  @observable
  double weight = 0;
  @observable
  int age = 0;
  @observable
  String email = '';
  @observable
  String password = '';
  @observable
  List<String> diseases = [];
  @observable
  double bmr = 0;

  @action
  void setName(String val) {
    name = val;
  }

  @action
  void setGender(String val) {
    gender = val;
  }

  @action
  void setSignIn(bool val) {
    signedIn = val;
  }

  @action
  void setToken(String val) {
    token = val;
  }

  @action
  void setHeight(double val) {
    height = val;
  }

  @action
  void setWeight(double val) {
    weight = val;
  }

  @action
  void setAge(int val) {
    age = val;
  }

  @action
  void setEmail(String val) {
    email = val;
  }

  @action
  void setPassword(String val) {
    password = val;
  }

  @action
  void setDiseases(List<String> val) {
    diseases = val;
  }

  @action
  void setBmr(double val) {
    bmr = val;
  }
}

_BlocControl blocControl = BlocStore();
final String url = 'https://ramizeattia.com/skimmit/';
