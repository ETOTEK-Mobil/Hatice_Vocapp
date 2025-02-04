import 'package:flutter/material.dart';
import 'package:vocabulary_app/cubit/register_cubit.dart';
import 'package:vocabulary_app/model/register_model.dart';
import 'package:vocabulary_app/ui/home_view.dart';
import 'package:vocabulary_app/ui/utils/validators/auth_validators.dart';
import 'package:vocabulary_app/ui/widgets/auth_form_fields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      try {
        await context.read<RegisterCubit>().register(
              RegisterModel(
                username: nameController.text,
                email: emailController.text,
                password: passwordController.text,
              ),
            );
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
            (route) => false,
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      }
    } else {
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              AuthFormField(
                hintText: 'Adınız',
                controller: nameController,
                labelText: 'Adınız',
                icon: Icons.person,
                obscureText: false,
                validator: AuthValidators.validateName,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                hintText: 'E-posta adresiniz',
                controller: emailController,
                labelText: 'E-posta',
                icon: Icons.email,
                obscureText: false,
                validator: AuthValidators.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                hintText: 'Şifreniz',
                controller: passwordController,
                labelText: 'Şifre',
                icon: Icons.lock,
                obscureText: true,
                validator: AuthValidators.validatePassword,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              AuthFormField(
                hintText: 'Şifrenizi tekrar girin',
                controller: passwordConfirmController,
                labelText: 'Şifre Tekrar',
                icon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Şifreler uyuşmuyor';
                  }
                  return AuthValidators.validatePassword(value);
                },
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: register,
                child: const Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
