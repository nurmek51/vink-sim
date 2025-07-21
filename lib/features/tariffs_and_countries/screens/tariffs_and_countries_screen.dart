import 'package:flex_travel_sim/features/tariffs_and_countries/widgets/country_list_tile.dart';
import 'package:flex_travel_sim/shared/widgets/start_registration_button.dart';
import 'package:flutter/material.dart';

class TariffsAndCountriesScreen extends StatelessWidget {
  final bool isAuthorized;

  const TariffsAndCountriesScreen({
    super.key,
    this.isAuthorized = false,
  });

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);
    const paddingSettings = EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 50,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Тарифы и страны', style: titleStyle),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey.shade300, height: 1),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: paddingSettings,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CountryListTile(
                        imagePath: 'assets/icons/russian_flag.svg',
                        countryTitle: 'Страна ${index + 1}',
                        countrySubtitle: 'Описание страны ${index + 1}',
                        price: '\$${(index + 1) * 10}',
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              Visibility(
                visible: isAuthorized,
                child: StartRegistrationButton(),
              ),             

            ],
          ),
        ),
      ),
    );
  }
}
