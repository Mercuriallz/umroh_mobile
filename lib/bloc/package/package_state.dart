import 'package:equatable/equatable.dart';
import 'package:mobile_umroh/model/package/package_model.dart';

abstract class PackageState extends Equatable {
  @override
  List<Object> get props => [];
}

class PackageInitial extends PackageState {}

class PackageLoaded extends PackageState {
  final List<DataPackage> package;

  PackageLoaded(this.package);

  @override
  List<Object> get props => [package];
}

class PackageError extends PackageState {
  final String message;

  PackageError(this.message);

  @override 
  List<Object> get props => [message];
}