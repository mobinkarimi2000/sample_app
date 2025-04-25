import 'package:sample_app/core/data_state.dart';

abstract class CURD<T> {
  Future<DataState<T>> get(int id);
  //Future<DataState<List<T>>> gets(filter);
  Future<DataState<T>> add(T cash);
  Future<DataState<T>> update(T cash);
  Future<DataState<T>> delByID(int id);
  //Future<DataState<T>> del(T id);
}
