import 'dart:async';

import 'package:counter/haptic_feedback.dart' as feedback;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  static const MethodChannel platform = MethodChannel('counter');

  final ValueNotifier<int> _counter = ValueNotifier(0);
  final _max = kDebugMode ? 20 : 40;
  final _step = kDebugMode ? 5 : 10;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(
      // SystemUiMode.edgeToEdge,
      SystemUiMode.immersive,
    );

    platform.setMethodCallHandler((call) async {
      final method = call.method;

      if (method == 'onVolumeUpButtonDown' ||
          method == 'onVolumeDownButtonDown') {
        _increment();
      }
    });
  }

  void _increment() {
    if (_counter.value == _max) {
      _error();
    } else {
      if (++_counter.value == _max) {
        _finish();
      } else {
        print('increment');
        if (_counter.value % _step == 0) {
          _feedbackStep();
        } else {
          _feedback();
        }
      }
    }
  }

  Future<void> _feedback() => feedback.impact();

  Future<void> _feedbackStep() => feedback.warning();

  Future<void> _finish() async {
    print('finish');
    await feedback.warning();
    await Future<void>.delayed(const Duration(milliseconds: 400));
    await feedback.back();
  }

  Future<void> _error() async {
    print('error');
    await feedback.warning();
    await Future<void>.delayed(const Duration(milliseconds: 400));
    await feedback.back();
  }

  void _reset() {
    _counter.value = 0;
  }

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white12,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _increment,
                    child: Align(
                      alignment: const Alignment(0, -0.4),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _counter,
                        builder: (_, value, __) => Text('$value'),
                      ),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('reset'),
                ),
              ],
            ),
          ),
        ),
      );
}
