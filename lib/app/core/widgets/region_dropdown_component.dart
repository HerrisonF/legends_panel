import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegionDropDownComponent extends StatefulWidget {
  final Function(String region) onRegionChoose;
  final bool isLoading;
  final String initialRegion;

  RegionDropDownComponent({
    required this.onRegionChoose,
    required this.initialRegion,
    this.isLoading = false,
  });

  @override
  State<RegionDropDownComponent> createState() =>
      _RegionDropDownComponentState();
}

class _RegionDropDownComponentState extends State<RegionDropDownComponent> {
  regionChoose(String region) {
    if (!widget.isLoading) {
      widget.onRegionChoose(region);
    }
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
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.region,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color(0xFF2E4053),
          ),
          child: DropdownButton(
            isExpanded: true,
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 20,
            ),
            underline: SizedBox.shrink(),
            menuMaxHeight: 100,
            dropdownColor: Color(0xFF2E4053),
            value: selectedLocation,
            onChanged: widget.isLoading
                ? null
                : (newValue) {
                    setState(() {
                      selectedLocation = newValue.toString();
                      regionChoose(selectedLocation);
                    });
                  },
            items: _locations.map((location) {
              return DropdownMenuItem(
                child: Center(
                  child: Text(
                    location,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                value: location,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
