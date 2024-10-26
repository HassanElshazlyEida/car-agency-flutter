abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}
class ChangeBottomNavIndexState extends LayoutStates {}

class LoadingCarsDataState extends LayoutStates {}
class SuccessCarsDataState extends LayoutStates {}
class ErrorCarsDataState extends LayoutStates {
  final String message;
  ErrorCarsDataState(this.message);
}

class LoadingCarsListState extends LayoutStates {}
