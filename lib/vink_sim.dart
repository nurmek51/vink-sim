library;

import 'package:vink_sim/config/feature_config.dart';
import 'package:vink_sim/core/di/injection_container.dart';

export 'config/feature_config.dart';
export 'ui/feature_root.dart';

Future<void> initVinkSim(FeatureConfig config) =>
    DependencyInjection.initForFeature(config);
