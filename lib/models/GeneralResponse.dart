class GeneralResponse{
  late String error;
  late bool ok;

  GeneralResponse({
    required this.error,
    required this.ok
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
        error: json['error'],
        ok: json['ok'],
    );
  }
}