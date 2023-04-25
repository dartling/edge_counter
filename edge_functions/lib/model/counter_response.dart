class CounterResponse {
  final int count;

  CounterResponse(this.count);

  factory CounterResponse.fromJson(Map<String, dynamic> json) =>
      CounterResponse(json['count'] as int);

  Map<String, dynamic> get toJson => {'count': count};
}
