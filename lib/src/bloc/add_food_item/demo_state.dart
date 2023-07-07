part of 'demo_bloc.dart';

@immutable
abstract class DemoState {}

class DemoInitial extends DemoState {
  String? inputText;

  DemoInitial({this.inputText});
}
