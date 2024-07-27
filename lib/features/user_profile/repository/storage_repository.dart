import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  Future<String> storeFile({
    required String path,
    required String id,
    required File? file,
    required BuildContext context,
  }) async {
    final ref = _firebaseStorage.ref().child(path).child(id);

    UploadTask uploadTask;
    uploadTask = ref.putFile(file!);

    final snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }
}