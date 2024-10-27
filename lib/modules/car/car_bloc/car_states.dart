abstract class CarStates {}

class CarInitialState extends CarStates {}
class CarCreationLoadingState extends CarStates {}
class CarCreationErrorState extends CarStates {
  String message;
  
  CarCreationErrorState(this.message);
}
class CarCreatedState extends CarStates {}

class CarUpdateLoadingState extends CarStates {}
class CarUpdateErrorState extends CarStates {
  String message;
  
  CarUpdateErrorState(this.message);
}
class CarUpdatedState extends CarStates {}
