import 'package:futmm/models/user_models.dart';
import 'package:futmm/utilities/contants.dart';

class DataBaseService{

  static void updateUser(User user){
    usersRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.profileImageUrl,
    });
  }
}