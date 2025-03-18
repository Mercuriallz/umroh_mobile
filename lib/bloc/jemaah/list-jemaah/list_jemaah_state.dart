import 'package:equatable/equatable.dart';
import 'package:mobile_umroh/model/jemaah/list-jemaah/list_jemaah_model.dart';

abstract class ListJemaahState extends Equatable {
  @override  
  List<Object> get props => [];
}

class ListJemaahInitial extends ListJemaahState {}

class ListJemaahLoading extends ListJemaahState {
  final List <DataListJemaah> dataListJemaah;
  final bool isLoadingMore;

  ListJemaahLoading(this.dataListJemaah, {this.isLoadingMore = false});

  @override 
  List<Object> get props => [dataListJemaah, isLoadingMore];
}


class ListJemaahLoaded extends ListJemaahState {
  final List<DataListJemaah> jemaah;
  final bool isLoadingMore;

  ListJemaahLoaded(this.jemaah, {this.isLoadingMore = false});

  @override  
  List<Object> get props => [jemaah, isLoadingMore];
}

class ListJemaahError extends ListJemaahState {
  final String message;

  ListJemaahError(this.message);

  @override  

  List<Object> get props => [message];
}