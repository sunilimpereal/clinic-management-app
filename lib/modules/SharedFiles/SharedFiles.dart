import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/modules/SharedFiles/models/sharedfiles_model.dart';
import 'package:clinic_app/modules/SharedFiles/widgets/sharedfiles_card.dart';

import '../../common_components/widgets/common_drawer.dart';
import '../../utils/constants/color_konstants.dart';
import 'bloc/sharedfiles_bloc.dart';

class SharedFiles extends StatefulWidget {
  const SharedFiles({Key? key}) : super(key: key);

  @override
  State<SharedFiles> createState() => _SharedFilesState();
}

class _SharedFilesState extends State<SharedFiles> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.read<SharedFilesBloc>().add(const SharedFilesInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorKonstants.primarySwatch,
          title: Text(
            'Shared Files',
            style: TextStyle(color: ColorKonstants.primarySwatch.shade50),
          ),
          centerTitle: false,
        ),
        drawer: const CommonDrawer(),
        body: BlocBuilder<SharedFilesBloc, SharedFilesState>(
            builder: (context, state) {
          if (state is SharedFileSloadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SharedFileErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          if (state is SharedFilesSuccessState) {
            GetSharedFilesResponse sharedfilesList = state.list;
            return sharedfilesList.data.isEmpty
                ? const Center(
                    child: Text('There are no shared files currently'),
                  )
                : Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => SharedFilesCard(
                            refresh: refresh,
                            sharedfiles: sharedfilesList.data[index],
                          ),
                          itemCount: sharedfilesList.data.length,
                          shrinkWrap: true,
                        ),
                      )
                    ]),
                  );
          }
          return Center(
            child: Text("Unrecognized state occurred: $state"),
          );
        }));
  }
}
