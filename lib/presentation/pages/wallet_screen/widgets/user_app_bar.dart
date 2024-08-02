import 'package:crypto_wallet/core/network/result.dart';
import 'package:crypto_wallet/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../bloc/wallet_bloc.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (previous, current) {
        return current is UserDataLoadingState ||
            current is UserDataFailureState ||
            current is UserDataSuccessState;
      },
      builder: (context, state) {
        if (state is UserDataLoadingState) {
          return Row(children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: CircleAvatar(
                backgroundColor: Colors.grey[700],
                radius: 25,
              ),
            ),
            const SizedBox(width: 30),
            Shimmer.fromColors(
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[500]!,
              child: Container(
                color: Colors.grey[700],
                width: 100,
                height: 20,
              ),
            ),
          ]);
        } else if (state is UserDataFailureState) {
          return Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[700],
                radius: 25,
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[200],
                    )),
              ),
              const SizedBox(width: 30),
              const Text("Error fetching user details"),
            ],
          );
        } else if (state is UserDataSuccessState) {
          final user = (state.user as Success<User>).data;
          return UserAppBarSuccessWidget(user: user);
        }
        return const SizedBox();
      },
    );
  }
}

@widgetbook.UseCase(
  name: 'with green color',
  type: Container,
)
Widget successAppBarUseCase(BuildContext context) {
  return UserAppBarSuccessWidget(
    user: User(
      userId: "111",
      firstName: "firstName",
      lastName: "lastName",
      email: "email",
      avatar: "https://placehold.co/400.png",
    ),
  );
}

class UserAppBarSuccessWidget extends StatelessWidget {
  const UserAppBarSuccessWidget({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[700],
          radius: 25,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.network(user.avatar),
          ),
        ),
        const SizedBox(width: 30),
        Text("${user.firstName} ${user.lastName}"),
      ],
    );
  }
}
