import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config_failure.freezed.dart';

@freezed
class RemoteConfigureFailure with _$RemoteConfigureFailure {
  const RemoteConfigureFailure._();
  const factory RemoteConfigureFailure.throttled() = Throttled;
  const factory RemoteConfigureFailure.clientFailure() = ClientFailure;
  const factory RemoteConfigureFailure.serverFailure() = ServerFailure;
}
