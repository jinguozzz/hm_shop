import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/userController.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器
  final Usercontroller usercontroller = Get.find();
  // 添加表单Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isChecked = false;

  // 添加正则表达式
  static const String _phonePattern = r'^1[3-9]\d{9}$';
  static const String _passwordPattern = r'^[a-zA-Z0-9_]{6,16}$';

  // 添加手机号校验方法
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '手机号不能为空';
    }
    String phone = value.trim();
    RegExp regExp = RegExp(_phonePattern);
    if (!regExp.hasMatch(phone)) {
      return '请输入正确的11位手机号';
    }
    return null;
  }

  // 添加密码校验方法
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '密码不能为空';
    }
    RegExp regExp = RegExp(_passwordPattern);
    if (!regExp.hasMatch(value)) {
      return '密码必须为6-16位的字母、数字或下划线';
    }
    return null;
  }

  // 用户账号Widget - 只添加了validator
  Widget _buildPhoneTextField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone, // 添加数字键盘
      inputFormatters: [
        // 添加输入限制
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: TextStyle(fontSize: 12), // 错误提示样式
      ),
      validator: _validatePhone, // ← 添加这行：绑定手机号校验
    );
  }

  // 用户密码Widget - 只添加了validator
  Widget _buildCodeTextField() {
    return TextFormField(
      controller: _codeController,
      obscureText: true,
      inputFormatters: [
        // 添加输入限制
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
        LengthLimitingTextInputFormatter(16),
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
        errorStyle: TextStyle(fontSize: 12), // 错误提示样式
      ),
      validator: _validatePassword, // ← 添加这行：绑定密码校验
    );
  }

  _login() async {
    try {
      final res = await LoginApi({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      print(res);
      usercontroller.updateUserInfo(res);
      Toastutils.showToast(context, "登陆成功");
      Navigator.pop(context);
    } catch (e) {
      print(e.toString());
      Toastutils.showToast(context, e.toString());
    }
  }

  // 登录按钮Widget - 只添加了校验调用
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 添加校验逻辑
          if (_formKey.currentState?.validate() ?? false) {
            // 校验通过，执行原有的登录逻辑
            _login();
            // 你的登录逻辑
          }
          // 如果校验失败，会自动显示错误信息
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  // 勾选Widget - 保持不变
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            _isChecked = value!;
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget - 保持不变
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey, // ← 添加这行：绑定表单Key
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
