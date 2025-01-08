// cart count
abstract class CartCountState {}

class CartCountInitialState extends CartCountState {}

class CartCountLoadingState extends CartCountState {}

class CartCountLoadedState extends CartCountState {
  final int count;

  CartCountLoadedState(this.count);
}

class CartCountErrorState extends CartCountState {
  final String errorMessage;

  CartCountErrorState(this.errorMessage);
}
