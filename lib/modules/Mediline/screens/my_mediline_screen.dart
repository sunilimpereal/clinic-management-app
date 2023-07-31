import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinic_app/common_components/widgets/common_drawer.dart';
import 'package:clinic_app/modules/Mediline/bloc/mediline_bloc.dart';
import 'package:clinic_app/modules/Mediline/models/get_appointmens_response.dart';
import 'package:clinic_app/modules/Mediline/screens/search_screen.dart';
import 'package:clinic_app/modules/Mediline/widgets/app_bar_dropdown_menu.dart';
import 'package:clinic_app/modules/Mediline/widgets/date_picker.dart';
import 'package:clinic_app/modules/Mediline/widgets/mediline_tab_view.dart';
import 'package:clinic_app/utils/helper/helper.dart';

import '../../../utils/constants/color_konstants.dart';
import '../../MyJatya/screens/MyJatya.dart';

class MyMedilineScreen extends StatefulWidget {
  const MyMedilineScreen({super.key});

  @override
  State<MyMedilineScreen> createState() => _MyMedilineScreenState();
}

class _MyMedilineScreenState extends State<MyMedilineScreen>
    with SingleTickerProviderStateMixin {
  DateTime? _selecteDate;
  @override
  void initState() {
    context.read<MedilineBloc>().add(const MedilineGetAllAppointmetns());
    // _selecteDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text("My Medi-line"),
            actions: const [AppBarDropDownMenu()],
          ),
          drawer: const CommonDrawer(),
          body: BlocBuilder<MedilineBloc, MedilineState>(
            builder: (context, state) {
              if (state is MedilineLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MedilineSuccessState) {
                if (_selecteDate != null) {
                  List<AppointmentDatum> appointmentsList = state.appointmentList
                      ?.where((element) => element.appointment.appointmentDate
                      .isSameDate(_selecteDate!))
                      .toList() ??
                      [];
                  return MedilineTabView(
                      appointments: appointmentsList,
                      clinicList: state.clinicList ?? []);
                }
                return MedilineTabView(
                    appointments: state.appointmentList ?? [],
                    clinicList: state.clinicList ?? []);
              }
              if (state is MedilineErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return const Center(
                child: Text("Something Went Wrong!"),
              );
            },
          ),
          bottomNavigationBar: SizedBox(
            height: 50,
            child: Row(
              children: [
                button(
                    text: "SELECT DATE",
                    icon: Icons.calendar_month,
                    onPressed: () {
                      _selectDate(context);
                    }),
                button(
                    text: "SEARCH",
                    icon: Icons.search,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MedilineSearchScreen(),
                        ),
                      );
                    })
              ],
            ),
          )
    );
  }

  _selectDate(BuildContext context) {
    DateTime? currentDate = _selecteDate;
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.42,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: RoundedDatePicker(
                    maxDate: DateTime.now().add(const Duration(days: 730)),
                    minDate: DateTime(DateTime.now().year),
                    itemExtent: 50,
                    selectedDate: _selecteDate,
                    onSelectedItemChanged: (date) {
                      currentDate = date;
                    }),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selecteDate = currentDate;
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      },
    );
  }

  Widget button({
    required String text,
    required IconData icon,
    required Function() onPressed,
  }) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            minimumSize: Size.zero,
            padding: const EdgeInsets.all(16),
            side: BorderSide(
                width: 0.5, color: ColorKonstants.primarySwatch.shade100),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
