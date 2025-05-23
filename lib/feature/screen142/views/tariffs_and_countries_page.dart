import 'package:flex_travel_sim/components/widgets/go_back_arrow.dart';
import 'package:flex_travel_sim/components/widgets/helvetica_neue_font.dart';
import 'package:flex_travel_sim/constants/lozalization.dart';
import 'package:flex_travel_sim/feature/screen142/widgets/country_list.dart';
import 'package:flutter/material.dart';

class TariffsAndCountriesScreen extends StatelessWidget {
  const TariffsAndCountriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIGMA NUMBER - 142
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Row(
                children: [
                  GoBackArrow(
                    onTap: () => Navigator.pop(context),
                    width: 10,
                    height: 14,
                  ),
                    
                  Expanded(
                    child: Center(
                      child: HelveticaneueFont(
                        text: AppLocalization.tariffsAndCountries,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        color: Color(0xFF363C45),
                      ),
                    ),
                  ),                
                ],
              ),
            ),
        
            const Divider(thickness: 0),
        
            // body 
        
            Expanded(child: CountryList()),
        
          ],
        ),
      ),
    );
  }
}