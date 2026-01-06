import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/account_group_model.dart';

class AccountService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<AccountGroup>> getAccountGroups() {
    return _firestore
        .collection('account_groups')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AccountGroup.fromMap(doc.data()))
          .toList();
    });
  }
}
