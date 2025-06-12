part of 'loader_cubit.dart';

@immutable
sealed class LoaderState extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoaderInitial extends LoaderState {}

final class LoaderLoading extends LoaderState {
  final String message;
  LoaderLoading({required this.message});

  @override
  List<Object> get props => [message];
}

final class LoaderLoaded extends LoaderState {}
