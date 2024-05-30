class Toss {
  final int priority;
  final String reason;
  final bool decission;
  Toss({
    required this.priority,
    required this.reason,
    required this.decission,
  });

  Toss copyWith({
    int? priority,
    String? reason,
    bool? decission,
  }) {
    return Toss(
      priority: priority ?? this.priority,
      reason: reason ?? this.reason,
      decission: decission ?? this.decission,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'priority': priority,
      'reason': reason,
      'decission': decission,
    };
  }

  factory Toss.fromMap(Map<String, dynamic> map) {
    return Toss(
      priority: map['priority'] as int,
      reason: map['reason'] as String,
      decission: map['decission'] as bool,
    );
  }

}
