// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocControl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BlocStore on _BlocControl, Store {
  final _$nameAtom = Atom(name: '_BlocControl.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$genderAtom = Atom(name: '_BlocControl.gender');

  @override
  String get gender {
    _$genderAtom.reportRead();
    return super.gender;
  }

  @override
  set gender(String value) {
    _$genderAtom.reportWrite(value, super.gender, () {
      super.gender = value;
    });
  }

  final _$signedInAtom = Atom(name: '_BlocControl.signedIn');

  @override
  bool get signedIn {
    _$signedInAtom.reportRead();
    return super.signedIn;
  }

  @override
  set signedIn(bool value) {
    _$signedInAtom.reportWrite(value, super.signedIn, () {
      super.signedIn = value;
    });
  }

  final _$_BlocControlActionController = ActionController(name: '_BlocControl');

  @override
  void setName(String val) {
    final _$actionInfo = _$_BlocControlActionController.startAction(
        name: '_BlocControl.setName');
    try {
      return super.setName(val);
    } finally {
      _$_BlocControlActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGender(String val) {
    final _$actionInfo = _$_BlocControlActionController.startAction(
        name: '_BlocControl.setGender');
    try {
      return super.setGender(val);
    } finally {
      _$_BlocControlActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSignIn(bool val) {
    final _$actionInfo = _$_BlocControlActionController.startAction(
        name: '_BlocControl.setSignIn');
    try {
      return super.setSignIn(val);
    } finally {
      _$_BlocControlActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
gender: ${gender},
signedIn: ${signedIn}
    ''';
  }
}
