import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormatView<T extends Cubit<S>, S> extends StatelessWidget {
  const FormatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, S>(
      builder: (context, state) {
        return Center(
          child: Text('State: $state'),
        );
      },
    );
  }
}
