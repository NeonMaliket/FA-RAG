import 'package:fa_rag_ui/state/cubit/loader/loader_cubit.dart';
import 'package:fa_rag_ui/theme/rag_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalLoaderDecorator extends StatelessWidget {
  const GlobalLoaderDecorator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoaderCubit, LoaderState>(
      builder: (_, state) {
        if (state is LoaderLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              CircularProgressIndicator(
                color: context.theme().colorScheme.secondary,
                strokeWidth: 3.0,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  state.message,
                  style: context.theme().textTheme.labelSmall?.copyWith(
                    color: context.theme().colorScheme.secondary,
                  ),
                ),
              ),
            ],
          );
        }
        return child;
      },
    );
  }
}
