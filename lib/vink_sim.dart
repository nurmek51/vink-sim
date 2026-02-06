library;

import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/di/injection_container.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:vink_sim/features/subscriber/presentation/bloc/subscriber_event.dart';

export 'config/feature_config.dart';
export 'ui/feature_root.dart';
export 'l10n/app_localizations.dart';

Future<void> initVinkSim(FeatureConfig config) =>
    DependencyInjection.initForFeature(config);

Future<void> resetVinkSim() async {
  if (sl.isRegistered<SubscriberBloc>()) {
    sl<SubscriberBloc>().add(const ResetSubscriberStateEvent());
  }
}
