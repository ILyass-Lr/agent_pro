import 'dart:convert';

import 'package:agent_pro/core/types/agent_status.dart';
import 'package:agent_pro/core/error/exceptions.dart';
import 'package:agent_pro/features/auth/data/models/agent_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  group('AgentModel.fromJson', () {
    test('should correctly map snake_case and enums', () {
      // arrange
      final jsonString = fixture('agent/valid.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      // act
      final agentModel = AgentModel.fromJson(jsonMap);
      // assert
      expect(agentModel.id, BigInt.from(1));
      expect(agentModel.firstName, 'John');
      expect(agentModel.lastName, 'Doe');
      expect(agentModel.status, Status.pending);
    });

    test('should handle missing optional fields', () {
      // arrange
      final jsonString = fixture('agent/missing_optional_fields.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      // act
      final agentModel = AgentModel.fromJson(jsonMap);
      // assert
      expect(agentModel.avatarUrl, null);
      expect(agentModel.certificationDate, null);
    });

    test('should handle invalid enum values gracefully', () {
      // arrange
      final jsonString = fixture('agent/invalid_status.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      // act
      final agentModel = AgentModel.fromJson(jsonMap);
      // assert
      expect(agentModel.status, Status.pending); // defaults to pending on invalid value
    });
  });

  group('AgentModel.toEntity', () {
    test('should convert to Agent entity correctly', () {
      // arrange
      final jsonString = fixture('agent/valid.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act
      final agentEntity = agentModel.toEntity();
      // assert
      expect(agentEntity.id.value, '1');
      expect(agentEntity.firstName.value, 'John');
      expect(agentEntity.lastName.value, 'Doe');
    });

    test('should throw DataSerializationException on invalid name', () {
      // arrange
      final jsonString = fixture('agent/invalid_name.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate(
            (e) => e is DataSerializationException && e.message.contains('invalid characters'),
          ),
        ),
      );
    });

    test('should throw DataSerializationException on invalid ID', () {
      // arrange
      final jsonString = fixture('agent/invalid_id.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate((e) => e is DataSerializationException && e.message.contains('invalid ID')),
        ),
      );
    });

    test('should throw DataSerializationException on invalid email', () {
      // arrange
      final jsonString = fixture('agent/invalid_email.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate((e) => e is DataSerializationException && e.message.contains('invalid email')),
        ),
      );
    });

    test('should throw DataSerializationException on invalid phone number', () {
      // arrange
      final jsonString = fixture('agent/invalid_phone_number.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate(
            (e) => e is DataSerializationException && e.message.contains('invalid phone number'),
          ),
        ),
      );
    });

    test('should throw DataSerializationException on invalid license number', () {
      // arrange
      final jsonString = fixture('agent/invalid_license.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate(
            (e) => e is DataSerializationException && e.message.contains('invalid characters'),
          ),
        ),
      );
    });

    test('should throw DataSerializationException on invalid license file path', () {
      // arrange
      final jsonString = fixture('agent/invalid_file_path.json');
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final agentModel = AgentModel.fromJson(jsonMap);
      // act & assert
      expect(
        () => agentModel.toEntity(),
        throwsA(
          predicate(
            (e) => e is DataSerializationException && e.message.contains('invalid file path'),
          ),
        ),
      );
    });
  });
}
