import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/account_group_model.dart';

class AccountService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<AccountGroup>> getAccountGroups() {
    return _firestore
        .collection('account_groups').orderBy('order', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AccountGroup.fromMap(doc))
          .toList();
    });
  }


  Future<void> addAccount({
    required String groupId, // document ID
    required String name,
    required String number,
    required double amount,
  }) async {
    final newAccount = {
      'name': name,
      'number': number,
      'amount': amount,
    };

    await _firestore
        .collection('account_groups')
        .doc(groupId)
        .update({
      'accounts': FieldValue.arrayUnion([newAccount]),
    });
  }



}
