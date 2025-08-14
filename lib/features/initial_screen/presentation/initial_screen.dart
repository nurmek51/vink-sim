import 'dart:async';
import 'package:flex_travel_sim/core/di/injection_container.dart';
import 'package:flex_travel_sim/core/router/app_router.dart';
import 'package:flex_travel_sim/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool _navigated = false;
  bool _subscribed = false;
  StreamSubscription? _subscriberSub;
  Timer? _timeout;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  @override
  void dispose() {
    _subscriberSub?.cancel();
    _timeout?.cancel();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    final authLocal = sl.get<AuthLocalDataSource>();
    final token = await authLocal.getToken();
    debugPrint('Initial: Fetched token - $token');

    if (!mounted) return;

    if (token == null || token.isEmpty) {
      if (kDebugMode) print('Initial: Token empty → go(welcome)');
      _safeGo(AppRoutes.welcome);
      return;
    }

    final subscriberBloc = context.read<SubscriberBloc>();

    if (!_subscribed) {
      _subscribed = true;
      _subscriberSub = subscriberBloc.stream.listen((state) {
        if (_navigated) return;

        if (state is SubscriberLoaded) {
          _decideAndNavigate(state);
        } else if (state is SubscriberError) {
          _safeGo(AppRoutes.welcome);
        }
      });
    }

    if (subscriberBloc.state is SubscriberLoaded) {
      _decideAndNavigate(subscriberBloc.state as SubscriberLoaded);
      return;
    }

    if (subscriberBloc.state is SubscriberInitial ||
        subscriberBloc.state is SubscriberError) {
      subscriberBloc.add(LoadSubscriberInfoEvent(token: token));
    } else {
      if (kDebugMode)
        print(
          'Initial: Skip dispatch, current state: ${subscriberBloc.state.runtimeType}',
        );
    }

    _timeout = Timer(const Duration(seconds: 20), () {
      if (_navigated || !mounted) return;
      if (kDebugMode)
        print('Initial: Waiting for subscriber too long → go(welcome)');
      _safeGo(AppRoutes.welcome);
    });
  }

  void _decideAndNavigate(SubscriberLoaded loaded) {
    final imsiList = loaded.subscriber.imsiList;
    if (kDebugMode) print('Initial: IMSI list len: ${imsiList.length}');
    if (kDebugMode)
      print('Initial: IMSI values: ${imsiList.map((e) => e.imsi).toList()}');

    final hasRealImsi = imsiList.isNotEmpty;
    final route = hasRealImsi ? AppRoutes.mainFlow : AppRoutes.esimEntry;

    debugPrint('Initial: Decide route: $route');
    _safeGo(route);
  }

  void _safeGo(String route) {
    if (_navigated || !mounted) return;
    _navigated = true;
    _timeout?.cancel();
    debugPrint('Initial: context.go($route)');
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.grey)),
    );
  }
}
