import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:agent_pro/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockConnectivity = MockConnectivity();
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(mockConnectivity, mockInternetConnection);
  });

  group('isConnected', () {
    test('should return true when there is an internet connection', () async {
      // Arrange
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(() => mockInternetConnection.hasInternetAccess).thenAnswer((_) async => true);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      verify(() => mockInternetConnection.hasInternetAccess).called(1);
      expect(result, true);
    });

    test('should return false when there is no internet connection', () async {
      // Arrange
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      verifyNever(() => mockInternetConnection.hasInternetAccess);
      expect(result, false);
    });

    test('should return false when there is no internet access', () async {
      // Arrange
      when(
        () => mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);
      when(() => mockInternetConnection.hasInternetAccess).thenAnswer((_) async => false);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      verify(() => mockConnectivity.checkConnectivity()).called(1);
      verify(() => mockInternetConnection.hasInternetAccess).called(1);
      expect(result, false);
    });
  });
}
