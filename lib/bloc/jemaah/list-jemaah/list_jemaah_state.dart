import 'package:equatable/equatable.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';

abstract class ListJemaahState extends Equatable {
  @override  
  List<Object> get props => [];
}

class ListJemaahInitial extends ListJemaahState {}

class ListJemaahLoading extends ListJemaahState {}


class ListJemaahLoaded extends ListJemaahState {
  final List<DataListJemaah> jemaah;

  ListJemaahLoaded(this.jemaah);

  @override  
  List<Object> get props => [jemaah];
}

class ListJemaahError extends ListJemaahState {
  final String message;

  ListJemaahError(this.message);

  @override  

  List<Object> get props => [message];
}