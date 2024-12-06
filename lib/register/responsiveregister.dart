import 'package:flutter/material.dart';
import 'package:remotefilesystem/register/register.dart';
import 'package:remotefilesystem/register/registermobile.dart';

class Responsiveregister extends StatelessWidget {
  const Responsiveregister({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 600){
          return const RegisterUI(role: '');
        }else{
          return const RegisterMobileUI();
        }
      },
    );
    }
}