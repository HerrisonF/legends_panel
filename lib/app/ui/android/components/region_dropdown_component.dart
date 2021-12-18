import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionDropDownComponent extends StatefulWidget {
  final Function(String region) onRegionChoose;
  final String initialRegion;

  RegionDropDownComponent(
      {required this.onRegionChoose, required this.initialRegion});

  @override
  State<RegionDropDownComponent> createState() =>
      _RegionDropDownComponentState();
}

class _RegionDropDownComponentState extends State<RegionDropDownComponent> {
  regionChoose(String region) {
    widget.onRegionChoose(region);
  }

  final List<String> _locations = [
    'BR',
    'EUN',
    'EUW',
    'JP',
    'KR',
    'LA',
    'NA',
    'OC',
    'TR',
    'RU'
  ];

  String selectedLocation = 'NA';

  @override
  void initState() {
    selectedLocation = widget.initialRegion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.height > 800
            ? MediaQuery.of(context).size.width / 3.6
            : MediaQuery.of(context).size.width / 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
      ),
      child: DropdownButton(
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          size: MediaQuery.of(context).size.height > 800 ? 25 : 20,
        ),
        elevation: 8,
        underline: SizedBox.shrink(),
        dropdownColor: Theme.of(context).backgroundColor,
        value: selectedLocation,
        onChanged: (newValue) {
          setState(() {
            if (newValue.toString().isNotEmpty) {
              selectedLocation = newValue.toString();
            }
            regionChoose(selectedLocation);
          });
        },
        items: _locations.map((location) {
          return DropdownMenuItem(
            child: Text(
              location,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: MediaQuery.of(context).size.height > 800 ? 14 : 12),
            ),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
