import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp_mobile/models/leave.dart';
import 'package:fyp_mobile/services/auth_service.dart';
import 'package:fyp_mobile/services/leaves_service.dart';

final leavesProvider = FutureProvider<List<Leave>>((ref) async {
  final authService = AuthService();
  final leavesService = LeavesService();

  final email = await authService.getUserEmail();
  final leaves = await leavesService.getLeavesByUser(email);
  return leaves;
});
