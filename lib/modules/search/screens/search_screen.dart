import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jatya_patient_mobile/common_components/widgets/common_drawer.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/models/prescription_deatils/prescription_details.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/latest_prescription_tabs/about_the_clinic.dart';
import 'package:jatya_patient_mobile/modules/MyPrescription/screens/latest_prescription_tabs/doctors_profile.dart';
import 'package:jatya_patient_mobile/modules/search/bloc/search_bloc.dart';
import 'package:jatya_patient_mobile/modules/search/bloc/search_event.dart';
import 'package:jatya_patient_mobile/modules/search/bloc/search_state.dart';
import 'package:jatya_patient_mobile/modules/search/models/clinic_response.dart';
import 'package:jatya_patient_mobile/modules/search/models/doctor_response.dart';
import 'package:jatya_patient_mobile/modules/search/models/medicine_response.dart';
import 'package:jatya_patient_mobile/modules/search/screens/medicine_info_screen.dart';
import 'package:jatya_patient_mobile/modules/search/services/debouncer.dart';
import 'package:jatya_patient_mobile/utils/constants/color_konstants.dart';
import 'package:jatya_patient_mobile/utils/constants/image_konstants.dart';
import 'package:jatya_patient_mobile/utils/enums.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _debouncer = Debouncer();
  SearchTypes _selectedSearchType = SearchTypes.everthing;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<GetDoctorsData> doctorsList = [];
  List<GetClinicData> clinicsList = [];
  List<GetMedicineData> medicinesList = [];
  @override
  initState() {
    _selectedSearchType = SearchTypes.everthing;
    super.initState();
  }

  final IconData _searchIcon = Icons.search;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: const CommonDrawer(),
      appBar: AppBar(
        title: const Text('Search'),
        actions: [popUpMenu()],
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Column(
              children: [
                searchField(),
                const SizedBox(
                  height: 20,
                ),
                _searchController.text == ""
                    ? Container()
                    : SingleChildScrollView(
                        controller: _scrollController,
                        child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                          if (state is SearchLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SearchLoadedState) {
                            return searchListView(
                              height,
                              doctorsList: state.doctors,
                              clinicsList: state.clinics,
                              medicinesList: state.medicines,
                            );
                          } else if (state is SearchErrorState) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else {
                            return Container();
                          }
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget searchListView(double height,
      {required List<GetDoctorsData> doctorsList,
      required List<GetClinicData> clinicsList,
      required List<GetMedicineData> medicinesList}) {
    List<Widget> searchResults = [];
    bool toBeShown(SearchTypes searchType) =>
        _selectedSearchType == SearchTypes.everthing ||
        searchType == _selectedSearchType;
    if (toBeShown(SearchTypes.doctor)) {
      searchResults.add(doctorItemsBuilder(doctorsList, height));
      searchResults.add(const SizedBox(height: 20));
    }
    if (toBeShown(SearchTypes.medicine)) {
      searchResults.add(medicineItemsBuilder(medicinesList, height));
      searchResults.add(const SizedBox(height: 20));
    }
    if (toBeShown(SearchTypes.clinic)) {
      searchResults.add(clinicitemsBuilder(clinicsList, height));
    }
    return Column(children: searchResults);
  }

  Widget searchField() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide());
    return TextField(
      controller: _searchController,
      focusNode: _focusNode,
      onChanged: (value) {
        if (value.isNotEmpty) {
          _debouncer.run(() {
            final searchBloc = BlocProvider.of<SearchBloc>(context);
            switch (_selectedSearchType) {
              case SearchTypes.doctor:
                searchBloc.add(SearchDoctorEvent(query: value));
                break;
              case SearchTypes.medicine:
                searchBloc.add(SearchMedicineEvent(query: value));
                break;
              case SearchTypes.everthing:
                searchBloc.add(SearchEverthingEvent(query: value));
                break;
              case SearchTypes.clinic:
                searchBloc.add(SearchClinicEvent(query: value));
                break;
            }
          });
        }
        setState(() {});
      },
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          hintText: "Search",
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 24, maxWidth: 50),
          suffixIcon: InkWell(
              onTap: () {
                setState(() => _searchController.clear());
              },
              child: _searchController.text != ""
                  ? clearButton()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(_searchIcon, color: Colors.grey))),
          border: border,
          enabledBorder: border),
    );
  }

  Widget countertext(int length, SearchTypes type) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(
          "$length matches found in ${type.name}",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorKonstants.subHeadingTextColor),
        ));
  }

  Widget clinicitemsBuilder(List<GetClinicData> list, double height) {
    return Column(
      children: [
        countertext(list.length, SearchTypes.clinic),
        const SizedBox(height: 20),
        list.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) => searchItem(
                        list[index].clinic.logo,
                        list[index].clinic.name,
                        list[index].clinic.address, () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => Scaffold(
                                appBar:
                                    AppBar(title: const Text('Clinic Details')),
                                body: AbouttheClinicScreen(
                                  clinicInformation: ClinicDetails.fromJson(
                                      list[index].clinic.toJson()),
                                ),
                              )),
                        ),
                      );
                    }))
            : const Text(
                'No results found Please try with diffrent search',
                style: TextStyle(fontSize: 16),
              ),
      ],
    );
  }

  Widget medicineItemsBuilder(List<GetMedicineData> list, double height) {
    return Column(
      children: [
        countertext(list.length, SearchTypes.medicine),
        const SizedBox(height: 20),
        list.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) => searchItem(
                  list[index].icon,
                  list[index].title,
                  list[index].brandName ?? "",
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineInfo(
                        medicineData: list[index],
                      ),
                    ),
                  ),
                ),
              )
            : const Text(
                'No results found Please try with diffrent search',
                style: TextStyle(fontSize: 16),
              ),
      ],
    );
  }

  Widget doctorItemsBuilder(List<GetDoctorsData> list, double height) {
    return Column(
      children: [
        countertext(list.length, SearchTypes.doctor),
        const SizedBox(height: 20),
        list.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) => searchItem(
                        list[index].user.photo,
                        list[index].user.name,
                        list[index].doctor.qualification,
                        //() {}))
                        () {
                      Doctorr doctorr = list[index].doctor;
                      User user = list[index].user;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(title: const Text('Doctor Details')),
                            body: DoctorsProfile(
                              doctorDetails: DoctorDetails(
                                doctor: Doctor(
                                    clinicId: doctorr.clinicId,
                                    specialisation: list[index].specialisation),
                                userData: UserData(
                                  photo: user.photo,
                                  name: user.name,
                                  phoneNumber: user.phoneNumber,
                                  email: user.email,
                                  address: user.address,
                                ),
                                specialisation: list[index].specialisation,
                              ),
                            ),
                          ),
                        ),
                      );
                    }))
            : const Text(
                'No results found Please try with diffrent search',
                style: TextStyle(fontSize: 16),
              ),
      ],
    );
  }

  Widget popUpMenu() {
    return Row(
      children: [
        Text(_selectedSearchType.name,
            style: const TextStyle(color: Colors.white)),
        PopupMenuButton(
            icon: const Icon(Icons.filter_list_sharp, color: Colors.white),
            itemBuilder: (_) {
              return [
                popmenuItem(
                    value: 0, icon: Icons.search, type: SearchTypes.everthing),
                popmenuItem(
                    value: 2,
                    icon: Icons.medical_services,
                    type: SearchTypes.doctor),
                popmenuItem(
                    value: 3,
                    icon: Icons.local_hospital_outlined,
                    type: SearchTypes.clinic),
                popmenuItem(
                    value: 1, icon: Icons.circle, type: SearchTypes.medicine),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  _selectedSearchType = SearchTypes.everthing;
                  break;
                case 1:
                  _selectedSearchType = SearchTypes.medicine;
                  break;
                case 2:
                  _selectedSearchType = SearchTypes.doctor;
                  break;
                case 3:
                  _selectedSearchType = SearchTypes.clinic;
                  break;
              }
              setState(() {});
            }),
      ],
    );
  }

  PopupMenuItem<int> popmenuItem(
      {required value, required IconData icon, required SearchTypes type}) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: ColorKonstants.blueccolor,
          ),
          const SizedBox(width: 15),
          Text(type.name),
        ],
      ),
    );
  }

  Widget clearButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: CircleAvatar(
          radius: 10,
          backgroundColor: ColorKonstants.textgrey,
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 15,
          )),
    );
  }

  Widget searchItem(
      String? imageUrl, String title, String subtitle, Function()? onTap) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          onTap: onTap,
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: Image.network(
              imageUrl ?? ImagesConstants.networkImageProfilePicPlacholder,
              fit: BoxFit.cover,
            ).image,
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              subtitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
