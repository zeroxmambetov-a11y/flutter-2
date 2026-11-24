import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cat_model.dart';
import '../../data/repositories/cat_repository.dart';


class LoadCatsEvent {}


class CatInitialState {}
class CatLoadingState {}


class CatLoadedState {
  final List<CatModel> cats;
  CatLoadedState(this.cats);
}


class CatErrorState {
  final String message;
  CatErrorState(this.message);
}


class CatBloc extends Bloc<LoadCatsEvent, dynamic> {
  final CatRepository _repository = CatRepository();

  CatBloc() : super(CatInitialState()) {

    on<LoadCatsEvent>((event, emit) async {
      emit(CatLoadingState()); 
      try {
        final cats = await _repository.getCats(); 
        emit(CatLoadedState(cats)); 
      } catch (e) {
        emit(CatErrorState('Ошибка: $e')); 
      }
    });
  }
}
