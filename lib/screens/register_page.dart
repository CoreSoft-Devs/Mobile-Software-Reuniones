import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:core_soft_meeting/services/index.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../config/navigation/application_routes.dart';
import '../widgets/index.dart';

class RegisterPage extends StatefulWidget {
  static const name = 'register-page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  TextEditingController role = TextEditingController(text: 'Administrador');
  final authServices = AuthServices();

  bool isPasswordVisible = false;
  bool isLoading = false;
  bool validEmail = false;
  bool validPassword = false;
  bool validName = false;
  bool validLastName = false;
  /* bool validRole = false; */

  final String welcomeText = '¡Bienvenido!';
  final String signInText = 'Por favor, regístrate para continuar.';
  final String emailPlaceholder = 'Correo Electrónico';
  final String passwordPlaceholder = 'Contraseña';
  final String forgotPasswordText = '¿Olvidaste tu contraseña?';
  final String registerButtonText = 'Regístrate';
  final String signUpText = '¿Ya tienes una cuenta?';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    role.dispose();
    super.dispose();
  }

  void validateEmail(String email) {
    setState(() {
      validEmail = isValidEmail(email);
    });
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void validatePassword(String password) {
    setState(() {
      validPassword = password.length >= 4;
    });
  }

  Future<void> onRegisterTap() async {
    setState(() {
      isLoading = true;
    });
    FocusScope.of(context).unfocus();

    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        //? Logina para mandar el token mobile
        final hash = await authServices.postRegister(
          nameController.text,
          lastNameController.text,
          emailController.text,
          passwordController.text,
          token,
          role.text,
        );
        // Si todo sale bien
        if (hash.isNotEmpty) {
          final hash2 = await authServices.postLogin(
            emailController.text,
            passwordController.text,
          );
          if (hash2.isNotEmpty) {
            // Si todo sale bien
            if (mounted) {
              Navigator.pushReplacementNamed(context, Routes.home);
              CustomDialog.showSuccessDialog(
                context,
                "¡Bienvenido!",
                "Has iniciado sesión correctamente.",
              );
            }
          } else {
            if (mounted) {
              CustomDialog.showErrorDialog(
                context,
                "Error de autenticación",
                "Correo o contraseña incorrectos",
              );
            }
          }
        } else {
          if (mounted) {
            CustomDialog.showErrorDialog(
              context,
              "Error de autenticación",
              "Correo o contraseña incorrectos",
            );
          }
        }
      } else {
        if (mounted) {
          CustomDialog.showErrorDialog(
            context,
            "Error de autenticación",
            "Correo o contraseña incorrectos",
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomDialog.showErrorDialog(
          context,
          "Error",
          "Hubo un problema al procesar tu solicitud.",
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40.0),
                      Text(
                        welcomeText,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        signInText,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 40.0),
                      CustomTextField(
                        placeholder: emailPlaceholder,
                        leftIcon: Icons.email,
                        controller: emailController,
                        onChanged: validateEmail,
                        errorText: validEmail ? null : 'El correo es inválido',
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        placeholder: passwordPlaceholder,
                        leftIcon: Icons.lock,
                        isPassword: true,
                        controller: passwordController,
                        onChanged: validatePassword,
                        errorText:
                            validPassword ? null : 'La contraseña es inválida',
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        placeholder: 'Nombre',
                        leftIcon: Icons.person,
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            validName = value.length >= 3;
                          });
                        },
                        errorText: validName ? null : 'El nombre es inválido',
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        placeholder: 'Apellido',
                        leftIcon: Icons.person,
                        controller: lastNameController,
                        onChanged: (value) {
                          setState(() {
                            validLastName = value.length >= 3;
                          });
                        },
                        errorText:
                            validLastName ? null : 'El apellido es inválido',
                      ),
                      const SizedBox(height: 16.0),
                      /* Rol */
                      Text('Rol:',
                          style: Theme.of(context).textTheme.bodyLarge),
                      DropdownButton<String>(
                        value: role.text,
                        hint: const Text('Rol'),
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: black),
                        underline: Container(
                          height: 2,
                          color: black,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            role.text = newValue!;
                            /* validRole = true; */
                          });
                        },
                        items: <String>['Administrador', 'Basico']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        height: 44.0,
                        child: ElevatedButton(
                          onPressed: validEmail &&
                                  validPassword &&
                                  validName &&
                                  validLastName /* &&
                                  validRole */
                              ? onRegisterTap
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(registerButtonText,
                              style:
                                  const TextStyle(fontSize: 16, color: white)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(signUpText),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.login);
                            },
                            child: const Text("Inicia Sesión",
                                style: TextStyle(color: black)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: black,
                ),
              ),
            )
        ],
      ),
    );
  }
}
