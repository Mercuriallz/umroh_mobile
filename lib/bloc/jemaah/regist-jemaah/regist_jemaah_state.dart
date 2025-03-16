import 'package:equatable/equatable.dart';

abstract class RegistJemaahState extends Equatable{
  @override  
  List<Object> get props => [];
}

class RegisterJemaahInitial extends RegistJemaahState {}

class RegisterJemaahLoading extends RegistJemaahState {}

class RegisterJemaahSuccess extends RegistJemaahState {
  @override  
  List<Object> get props => [];
}

class RegisterJemaahError extends RegistJemaahState {
  final String message;

  RegisterJemaahError(this.message);

  @override  
  List<Object> get props => [];
}