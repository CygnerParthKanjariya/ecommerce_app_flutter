import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> getCachedSession();
  Future<void> cacheSession(UserModel user);
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({
    required this.databaseHelper,
    required this.secureStorage,
  });

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    final db = await databaseHelper.database;
    final hashedPassword = _hashPassword(password);
    
    final maps = await db.query(
      'users',
      where: 'email = ? AND hashedPassword = ?',
      whereArgs: [email, hashedPassword],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      throw ServerException(); // You can map this to AuthException
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    final db = await databaseHelper.database;
    final hashedPassword = _hashPassword(password);

    // Check if email exists
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      throw ServerException(); // Throw specific exception for duplicate email
    }

    final user = UserModel(
      name: name,
      email: email,
      hashedPassword: hashedPassword,
    );

    final id = await db.insert('users', user.toJson());
    
    return UserModel(
      id: id,
      name: name,
      email: email,
      hashedPassword: hashedPassword,
      createdAt: user.createdAt,
    );
  }

  @override
  Future<UserModel> getCachedSession() async {
    final sessionString = await secureStorage.read(key: 'CACHED_SESSION');
    if (sessionString != null) {
      return UserModel.fromJson(json.decode(sessionString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSession(UserModel user) async {
    await secureStorage.write(
      key: 'CACHED_SESSION',
      value: json.encode(user.toJson()),
    );
  }

  @override
  Future<void> clearSession() async {
    await secureStorage.delete(key: 'CACHED_SESSION');
  }
}
