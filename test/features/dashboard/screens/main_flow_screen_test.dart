import 'package:bloc_test/bloc_test.dart';
import 'package:flex_travel_sim/core/models/imsi_model.dart';
import 'package:flex_travel_sim/core/models/subscriber_model.dart';
import 'package:flex_travel_sim/features/dashboard/screens/main_flow_screen.dart';
import 'package:flex_travel_sim/features/dashboard/bloc/main_flow_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_bloc.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_event.dart';
import 'package:flex_travel_sim/features/subscriber/presentation/bloc/subscriber_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockMainFlowBloc extends MockBloc<MainFlowEvent, MainFlowState>
    implements MainFlowBloc {}

class MockSubscriberBloc extends MockBloc<SubscriberEvent, SubscriberState>
    implements SubscriberBloc {}

class FakeMainFlowEvent extends Fake implements MainFlowEvent {}

class FakeSubscriberEvent extends Fake implements SubscriberEvent {}

void main() {
  group('GIVEN $MainFlowScreen', () {
    group('calculateAvailableGB', () {
      testWidgets('WHEN valid balance and rate '
          'THEN calculates correct GB', (tester) async {
        const balance = 1024.0 * 1024.0;
        const rate = 1024.0;
        final result = MainFlowDataProcessor.calculateAvailableGB(
          balance,
          rate,
        );

        await tester.pumpWidget(tester.buildGBWidget(result));

        expect(find.text('1.0 GB'), findsOneWidget);
      });

      testWidgets('WHEN large balance '
          'THEN calculates correct GB value', (tester) async {
        const balance = 5.0 * 1024.0 * 1024.0;
        const rate = 1024.0;
        final result = MainFlowDataProcessor.calculateAvailableGB(
          balance,
          rate,
        );

        await tester.pumpWidget(tester.buildGBWidget(result));

        expect(find.text('5.0 GB'), findsOneWidget);
      });

      testWidgets('WHEN different rate '
          'THEN calculates proportional result', (tester) async {
        const balance = 2048.0 * 1024.0;
        const rate = 2048.0;
        final result = MainFlowDataProcessor.calculateAvailableGB(
          balance,
          rate,
        );

        await tester.pumpWidget(tester.buildGBWidget(result));

        expect(find.text('1.0 GB'), findsOneWidget);
      });

      testWidgets('WHEN rate is zero '
          'THEN returns 0', (tester) async {
        const balance = 1024.0;
        const rate = 0.0;
        final result = MainFlowDataProcessor.calculateAvailableGB(
          balance,
          rate,
        );

        await tester.pumpWidget(tester.buildGBWidget(result));

        expect(find.text('0.0 GB'), findsOneWidget);
      });

      testWidgets('WHEN balance is zero '
          'THEN returns 0', (tester) async {
        const balance = 0.0;
        const rate = 1024.0;
        final result = MainFlowDataProcessor.calculateAvailableGB(
          balance,
          rate,
        );

        await tester.pumpWidget(tester.buildGBWidget(result));

        expect(find.text('0.0 GB'), findsOneWidget);
      });
    });

    group('processImsiList', () {
      testWidgets('WHEN loaded state '
          'THEN displays IMSI list', (tester) async {
        const imsiList = [
          ImsiModel(
            imsi: 'test123',
            balance: 50.0,
            country: 'USA',
            rate: 1024.0,
          ),
          ImsiModel(
            imsi: 'test456',
            balance: 100.0,
            country: 'Canada',
            rate: 2048.0,
          ),
        ];
        final state = SubscriberLoaded(
          subscriber: const SubscriberModel(balance: 150.0, imsiList: imsiList),
        );
        final result = MainFlowDataProcessor.processImsiList(state);

        await tester.pumpWidget(tester.buildImsiListWidget(result));

        expect(find.text('USA'), findsOneWidget);
        expect(find.text('Canada'), findsOneWidget);
      });

      testWidgets('WHEN empty list '
          'THEN displays default IMSI', (tester) async {
        final state = SubscriberLoaded(
          subscriber: const SubscriberModel(balance: 100.0, imsiList: []),
        );
        final result = MainFlowDataProcessor.processImsiList(state);

        await tester.pumpWidget(tester.buildSingleImsiWidget(result.first));

        expect(find.text('default'), findsOneWidget);
        expect(find.text('N/A'), findsOneWidget);
        expect(find.text('100.0'), findsOneWidget);
      });

      testWidgets('WHEN loading state '
          'THEN displays loading country', (tester) async {
        final state = SubscriberLoading();
        final result = MainFlowDataProcessor.processImsiList(state);

        await tester.pumpWidget(tester.buildSingleImsiWidget(result.first));

        expect(find.text('default'), findsOneWidget);
        expect(find.text('loading'), findsOneWidget);
      });

      testWidgets('WHEN error state '
          'THEN displays error country', (tester) async {
        final state = SubscriberError(message: 'Test error');
        final result = MainFlowDataProcessor.processImsiList(state);

        await tester.pumpWidget(tester.buildSingleImsiWidget(result.first));

        expect(find.text('default'), findsOneWidget);
        expect(find.text('error'), findsOneWidget);
      });

      testWidgets('WHEN initial state '
          'THEN displays N/A country', (tester) async {
        final state = SubscriberInitial();
        final result = MainFlowDataProcessor.processImsiList(state);

        await tester.pumpWidget(tester.buildSingleImsiWidget(result.first));

        expect(find.text('default'), findsOneWidget);
        expect(find.text('N/A'), findsOneWidget);
      });
    });

    group('isLoadingWithNoData', () {
      testWidgets('WHEN loading with empty list '
          'THEN returns true', (tester) async {
        final state = SubscriberLoading();
        const imsiList = <ImsiModel>[];
        final result = MainFlowDataProcessor.isLoadingWithNoData(
          state,
          imsiList,
        );

        await tester.pumpWidget(tester.buildLoadingWidget(result));

        expect(find.text('Loading: true'), findsOneWidget);
      });

      testWidgets('WHEN loading with non-empty list '
          'THEN returns false', (tester) async {
        final state = SubscriberLoading();
        const imsiList = [
          ImsiModel(
            imsi: 'test123',
            balance: 50.0,
            country: 'USA',
            rate: 1024.0,
          ),
        ];
        final result = MainFlowDataProcessor.isLoadingWithNoData(
          state,
          imsiList,
        );

        await tester.pumpWidget(tester.buildLoadingWidget(result));

        expect(find.text('Loading: false'), findsOneWidget);
      });

      testWidgets('WHEN not loading state '
          'THEN returns false', (tester) async {
        final state = SubscriberLoaded(
          subscriber: const SubscriberModel(balance: 0.0, imsiList: []),
        );
        const imsiList = <ImsiModel>[];
        final result = MainFlowDataProcessor.isLoadingWithNoData(
          state,
          imsiList,
        );

        await tester.pumpWidget(tester.buildLoadingWidget(result));

        expect(find.text('Loading: false'), findsOneWidget);
      });
    });
  });
}

extension on WidgetTester {
  Widget buildGBWidget(double value) =>
      MaterialApp(home: Scaffold(body: Text('${value.toStringAsFixed(1)} GB')));

  Widget buildImsiListWidget(List<ImsiModel> imsiList) => MaterialApp(
    home: Scaffold(
      body: Column(
        children: imsiList.map((imsi) => Text(imsi.country ?? '')).toList(),
      ),
    ),
  );

  Widget buildSingleImsiWidget(ImsiModel imsi) => MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Text(imsi.imsi),
          Text(imsi.country ?? ''),
          Text(imsi.balance.toString()),
        ],
      ),
    ),
  );

  Widget buildLoadingWidget(bool isLoading) =>
      MaterialApp(home: Scaffold(body: Text('Loading: $isLoading')));
}
