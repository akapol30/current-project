part of 'demo_bloc.dart';

@immutable
abstract class DemoEvent {}

class GetInput extends DemoEvent {
  String inputText;

  GetInput(this.inputText);
}
