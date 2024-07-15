// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class PostgreSqlDB {
  final Connection connection;

  PostgreSqlDB({required this.connection});

  bool get isConnected => connection.isOpen;

  Future<void> disconnect() async {
    await connection.close();
    debugPrint('connection: disconnected');
  }

  Future getProducts() async {
    return await connection.execute('SELECT * FROM products');
  }
}
