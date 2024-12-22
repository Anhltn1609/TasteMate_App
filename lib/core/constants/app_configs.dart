class AppConfigs {
  AppConfigs._();

  static const baseUrl = String.fromEnvironment('API_END_POINT');
  static const realtimeApiEndpoint =
      String.fromEnvironment('REALTIME_API_END_POINT');
  static const apiVersion = String.fromEnvironment('API_VERSION');
  static const appName = String.fromEnvironment('APP_NAME');
  static const appSuffix = String.fromEnvironment('APP_SUFFIX');
  static const connectTimeout = String.fromEnvironment('CONNECT_TIME_OUT');
  static const receiveTimeout = String.fromEnvironment('RECEIVE_TIME_OUT');
  static const loggingInterceptorEnabled =
      String.fromEnvironment('LOGGING_INTERCEPTOR_ENABLED');
  static const String fakeUrl =
      'https://images.unsplash.com/photo-1534944645004-bf75556ce377?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  // 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?q=80&w=2043&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
}
