import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:toss2decide/models/toss.dart';

part 'toss_state.dart';

class TossCubit extends Cubit<TossState> {
  TossCubit() : super(TossState.initial());

  setPriority(Priority priority) {
    emit(state.copyWith(priority: priority));
  }

  setReason(String reason) {
    emit(state.copyWith(reason: reason));
  }

  Future<Toss> toss() async {
    emit(state.copyWith(isProcessing: true));
    var result = await toss2Decide(state.priority);
    emit(state.copyWith(isProcessing: false));
    return Toss(
        priority: state.priority.inInt,
        reason: state.reason,
        decission: result);
  }

  resset() {
    emit(TossState.initial());
  }
}

Future<bool> toss2Decide(Priority priority) async {
  int tries = 0;
  int duration = 0;
  if (priority.isLow) {
    tries = 2;
    duration = 2;
  } else if (priority.isMedium) {
    tries = 5;
    duration = 3;
  } else {
    tries = 10;
    duration = 5;
  }

  await Future.delayed(Duration(seconds: duration));

  var rnd = Random();

  var tossResults = <int>[];

  for (int i = 0; i < tries; i++) {
    var res = rnd.nextInt(2);
    tossResults.add(res);
    print('try number $i -> $res');
  }

  print(tossResults);

  var zeroes = 0;
  var ones = 0;

  tossResults.map((e) {
    if (e == 0) {
      print('bla');
      zeroes += 1;
    } else {
      ones += 1;
    }
  }).toList();

  print("In favour $ones");
  print("Not in favour $zeroes");

  var decession = ones > zeroes;

  print("Decession $decession");
  return decession;
}
