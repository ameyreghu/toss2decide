// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'toss_cubit.dart';

class TossState {
  final bool isProcessing;
  final String reason;
  final Priority priority;
  TossState({
    required this.isProcessing,
    required this.reason,
    required this.priority,
  });

  factory TossState.initial() =>
      TossState(isProcessing: false, priority: Priority.low, reason: '');

  TossState copyWith({
    bool? isProcessing,
    String? reason,
    Priority? priority,
  }) {
    return TossState(
      isProcessing: isProcessing ?? this.isProcessing,
      reason: reason ?? this.reason,
      priority: priority ?? this.priority,
    );
  }
}

enum Priority { low, medium, high }

extension PEX on Priority {
  bool get isLow => this == Priority.low;
  bool get isMedium => this == Priority.medium;
  bool get isHigh => this == Priority.high;

  int get inInt => isLow
      ? 1
      : isMedium
          ? 2
          : 3;
}
