import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/partner_register_cubit.dart';
import 'partner_register_screen.dart';

class PartnerRegisterWrapper extends StatelessWidget {
  const PartnerRegisterWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PartnerRegisterCubit(),
      child: const PartnerRegisterScreen(),
    );
  }
}
