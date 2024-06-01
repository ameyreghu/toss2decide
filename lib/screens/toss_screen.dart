import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:toss2decide/cubits/toss/toss_cubit.dart';
import 'package:toss2decide/main.dart';
import 'package:toss2decide/models/toss.dart';

class TossScreen extends StatelessWidget {
  const TossScreen({super.key});

  Widget buildLoading() {
    return Center(
      child: LottieBuilder.asset('assets/toss.json'),
    );
  }

  showResultDialog(BuildContext context, Toss toss) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            toss.decission ? "You Should" : "You Should Not",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(
                  toss.decission ? 'assets/sucess.json' : 'assets/fail.json'),
              Text(
                toss.reason,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Retry")),
            TextButton(
                onPressed: () {
                  context.read<TossCubit>().resset();
                  Navigator.of(context).pop();
                },
                child: const Text("OKAY"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.read<TossCubit>();
    var state = context.watch<TossCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toss2Decide"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: state.isProcessing
            ? buildLoading()
            : Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Reason",
                      hintText: "eg : - Buy a new phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusColor: Theme.of(context).primaryColorDark),
                  onChanged: (val) => vm.setReason(val),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Cannot be Empty" : null,
                ),
                const Gap(10),
                Text(
                  "Priority",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Low"),
                    Radio.adaptive(
                      value: Priority.low,
                      groupValue: state.priority,
                      onChanged: (value) =>
                          value != null ? vm.setPriority(value) : null,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Medium"),
                    Radio.adaptive(
                      value: Priority.medium,
                      groupValue: state.priority,
                      onChanged: (value) =>
                          value != null ? vm.setPriority(value) : null,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("High"),
                    Radio.adaptive(
                      value: Priority.high,
                      groupValue: state.priority,
                      onChanged: (value) =>
                          value != null ? vm.setPriority(value) : null,
                    )
                  ],
                ),
                const Gap(10),
                InkWell(
                  onTap: () {
                    if (state.reason.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Reason cannot be empty')));
                      return;
                    }
                    vm.toss().then(
                          (toss) => showResultDialog(context, toss),
                        );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        // begin: Alignment.topCenter,
                        // end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF3c8ce7),
                          Color(0xFF3c8ce7),
                        ],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TOSS",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "ARLABS",
                  style: GoogleFonts.shizuru(
                    color: const Color(0xFF3c8ce7),
                  ),
                )
              ]),
      ),
    );
  }
}
