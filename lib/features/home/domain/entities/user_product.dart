import 'package:equatable/equatable.dart';

class UserProducts extends Equatable {
  final String id;
  final String userId;
  final String productId;

  const UserProducts({
    required this.id,
    required this.userId,
    required this.productId,
  });

  @override
  List<Object?> get props => [id];
}
