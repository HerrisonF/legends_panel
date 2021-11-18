import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegionDropDownComponent extends StatefulWidget {
  final Function(String region) onRegionChoose;

  RegionDropDownComponent({required this.onRegionChoose});

  @override
  State<RegionDropDownComponent> createState() =>
      _RegionDropDownComponentState();
}

class _RegionDropDownComponentState extends State<RegionDropDownComponent> {
  regionChoose(String region) {
    widget.onRegionChoose(region);
  }

  final List<String> _locations = [
    'BR1',
    'EUN1',
    'EUW1',
    'JP1',
    'KR',
    'LA1',
    'LA2',
    'NA1',
    'OC1',
    'TR1',
    'RU'
  ];
  String _selectedLocation = 'NA1';

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).backgroundColor,
      ),
      child: DropdownButton(
        menuMaxHeight: 250,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        elevation: 8,
        underline: SizedBox.shrink(),
        dropdownColor: Theme.of(context).backgroundColor,
        value: _selectedLocation,
        onChanged: (newValue) {
          setState(() {
            if (newValue.toString().isNotEmpty) {
              _selectedLocation = newValue.toString();
            }
            regionChoose(_selectedLocation);
          });
        },
        items: _locations.map((location) {
          return DropdownMenuItem(
            child: Text(
              location,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            value: location,
          );
        }).toList(),
      ),
    );
  }
}
