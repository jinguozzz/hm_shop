import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

//在对象中定义需要共享的属性
class Usercontroller extends GetxController {
  var user = UserInfo.fromJSON({}).obs; //.obs用来监听

  updateUserInfo(UserInfo newuser) {
    user.value = newuser;
  }
}
