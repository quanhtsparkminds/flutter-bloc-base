import 'package:myapp/gen/assets.gen.dart';

enum CountryResidence {
  italy,
  unitedState,
  norway,
  england,
  brazil,
  vietnam,
  ireland,
  netherlands,
  germany,
  korea,
  china,
  unknown
}

extension ExCountryResidence on CountryResidence {
  String get countryName {
    switch (this) {
      case CountryResidence.italy:
        return 'Italy';
      case CountryResidence.unitedState:
        return 'United State';
      case CountryResidence.norway:
        return 'Norway';
      case CountryResidence.england:
        return 'England';
      case CountryResidence.brazil:
        return 'Brazil';
      case CountryResidence.vietnam:
        return 'Vietnam';
      case CountryResidence.ireland:
        return 'Ireland';
      case CountryResidence.netherlands:
        return 'Netherlands';
      case CountryResidence.germany:
        return 'Germany';
      case CountryResidence.korea:
        return 'Korea';
      case CountryResidence.china:
        return 'China';
      default:
        return '';
    }
  }

  String get flag {
    switch (this) {
      case CountryResidence.italy:
        return Assets.svg.italyFlag;
      case CountryResidence.unitedState:
        return Assets.svg.unitedStateFlag;
      case CountryResidence.norway:
        return Assets.svg.norwayFlag;
      case CountryResidence.england:
        return Assets.svg.unitedKingdomFlag;
      case CountryResidence.brazil:
        return Assets.svg.brazillFlag;
      case CountryResidence.vietnam:
        return Assets.svg.vietnamFlag;
      case CountryResidence.ireland:
        return Assets.svg.irelandFlag;
      case CountryResidence.netherlands:
        return Assets.svg.netherlandsFlag;
      case CountryResidence.germany:
        return Assets.svg.germanyFlag;
      case CountryResidence.korea:
        return Assets.svg.koreaFlag;
      case CountryResidence.china:
        return Assets.svg.chinaFlag;
      case CountryResidence.unknown:
        return Assets.svg.vietnamFlag;
    }
  }
}
