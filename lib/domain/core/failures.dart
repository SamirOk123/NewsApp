import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class MainFailure with _$MainFailure {
  const MainFailure._();
  const factory MainFailure.clientFailure() = ClientFailure;
  const factory MainFailure.serverFailure() = ServerFailure;
}
