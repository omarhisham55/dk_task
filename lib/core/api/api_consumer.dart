abstract class ApiConsumer {
  Future<dynamic> get(
    String path,
    {Map<String, dynamic>? parameters}
  );
  Future<dynamic> post(
    String path,
    {Map<String, dynamic>? parameters, Map<String, dynamic>? body}
  );
  Future<dynamic> put(
    String path,
    {Map<String, dynamic>? parameters, Map<String, dynamic>? body}
  );
}