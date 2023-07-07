import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'demo_event.dart';
part 'demo_state.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  DemoBloc() : super(DemoInitial());

  @override
  Stream<DemoState> mapEventToState(DemoEvent event) async* {
    if (event is GetInput) {
      yield* _mapGetInputEventToState(event);
    }
  }

  Stream<DemoState> _mapGetInputEventToState(GetInput event) async* {
    yield DemoInitial(inputText: event.inputText);
  }
}
