class CountryCodeUtils {
  // PLMN to country codes mapping from plmn-countries.json
  static final Map<String, String> _plmnCountryMap = {
    "AAMOM": "XX",
    "AAMT1": "NO",
    "ABWDC": "AW",
    "AFGAR": "AF",
    "AFGAW": "AF",
    "AFGEA": "AF",
    "AFGTD": "AF",
    "AGOUT": "AO",
    "AIACW": "AI",
    "ALBAM": "AL",
    "ALBEM": "AL",
    "ALBM4": "AL",
    "ALBVF": "AL",
    "ANDMA": "AD",
    "ANTCT": "BQ",
    "ANTK8": "CW",
    "ANTTC": "BQ",
    "AREDU": "AE",
    "ARETC": "AE",
    "ARETH": "XX",
    "ARGCM": "AR",
    "ARM01": "AM",
    "ARM05": "AM",
    "ARMOR": "AM",
    "ATGCW": "AG",
    "AUSOP": "AU",
    "AUSTA": "AU",
    "AUSVF": "AU",
    "AUTCA": "AT",
    "AUTMM": "AT",
    "AUTPT": "AT",
    "AZEAC": "AZ",
    "AZEAF": "AZ",
    "AZEBC": "AZ",
    "BDIL1": "BI",
    "BDIVG": "BI",
    "BELKO": "BE",
    "BELMO": "BE",
    "BELTB": "BE",
    "BEN02": "BJ",
    "BENK8": "BJ",
    "BFACT": "BF",
    "BGDBL": "BD",
    "BGDGP": "BD",
    "BGR01": "BG",
    "BGRCM": "BG",
    "BHRB2": "BH",
    "BHRBT": "BH",
    "BHRMV": "BH",
    "BHSBH": "BS",
    "BHSNC": "BS",
    "BIHER": "BA",
    "BIHMS": "BA",
    "BIHPT": "BA",
    "BLR02": "BY",
    "BLRBT": "BY",
    "BLRMD": "BY",
    "BLZ67": "BZ",
    "BLZSC": "BZ",
    "BMU01": "XX",
    "BMUK9": "BM",
    "BOLNT": "BO",
    "BOLK9": "BO",
    "BOLTE": "BO",
    "BRABT": "BR",
    "BRAC4": "BR",
    "BRACL": "BR",
    "BRACS": "BR",
    "BRARN": "BR",
    "BRASP": "BR",
    "BRATC": "BR",
    "BRATM": "BR",
    "BRAV1": "BR",
    "BRAV2": "BR",
    "BRAV3": "BR",
    "BTNTC": "BT",
    "BRBCW": "BB",
    "BRNBR": "BN",
    "BRNDS": "BN",
    "BWABC": "BW",
    "BWAGA": "BW",
    "CAF03": "CF",
    "CANBM": "CA",
    "CANMC": "CA",
    "CANRW": "CA",
    "CANST": "CA",
    "CANTS": "CA",
    "CANVT": "CA",
    "CHEC1": "CH",
    "CHEDX": "CH",
    "CHEOR": "CH",
    "CHLMV": "CL",
    "CHLSM": "CL",
    "CHLTM": "CL",
    "CHNCM": "CN",
    "CHNCU": "CN",
    "CHNTD": "CN",
    "CIV02": "CI",
    "CIVTL": "CI",
    "CMRMT": "CM",
    "CMRVG": "CM",
    "CODAC": "CD",
    "CODCT": "CD",
    "CODOR": "CD",
    "CODSA": "CD",
    "CODVC": "CD",
    "COGCT": "CG",
    "COLCM": "CO",
    "COLCO": "CO",
    "COLTM": "CO",
    "COMHR": "KM",
    "COMTM": "KM",
    "CPVCV": "CV",
    "CPVTM": "CV",
    "CRICL": "CR",
    "CRICR": "CR",
    "CRITC": "CR",
    "CUB01": "CU",
    "CYMCW": "KY",
    "CYPCT": "CY",
    "CYPPT": "CY",
    "CYPSC": "CY",
    "CZECM": "CZ",
    "CZEET": "CZ",
    "CZERM": "CZ",
    "DEUD1": "DE",
    "DEUD2": "DE",
    "DEUE2": "DE",
    "DJIDJ": "DJ",
    "DMACW": "DM",
    "DNKDM": "DK",
    "DNKHU": "DK",
    "DNKIA": "DK",
    "DNKTD": "DK",
    "DOMCL": "DO",
    "DZAA1": "DZ",
    "DZAOT": "DZ",
    "DZAWT": "DZ",
    "ECUAL": "EC",
    "ECUPG": "EC",
    "EGYAR": "EG",
    "EGYEM": "EG",
    "EGYMS": "EG",
    "ESPAT": "ES",
    "ESPRT": "ES",
    "ESPTE": "ES",
    "ESPXF": "ES",
    "ESTEM": "EE",
    "ESTRB": "EE",
    "ESTRE": "EE",
    "ETH01": "ET",
    "FIN2G": "FI",
    "FINAM": "FI",
    "FINRL": "FI",
    "FINTA": "FI",
    "FINTF": "FI",
    "FJIDP": "FJ",
    "FJIK9": "FJ",
    "FRAF1": "FR",
    "FRAF2": "FR",
    "FRAF3": "FR",
    "FRAF4": "BL",
    "FRAFM": "FR",
    "FRATK": "PF",
    "FROFT": "FO",
    "FROKA": "FO",
    "GAB01": "GA",
    "GABAZ": "GA",
    "GABCT": "GA",
    "GABTL": "GA",
    "GBRCN": "GB",
    "GBRHU": "GB",
    "GBRJT": "GB",
    "GBRME": "GB",
    "GBRMT": "GB",
    "GBROR": "GB",
    "GBRVF": "GB",
    "GEOGC": "GE",
    "GEOMT": "GE",
    "GHAGM": "GH",
    "GHAGT": "GH",
    "GHAMT": "GH",
    "GHASC": "GH",
    "GHAK8": "GH",
    "GHAZN": "GH",
    "GIBGT": "GI",
    "GINAG": "GN",
    "GINGS": "GN",
    "GLPK9": "GP",
    "GLP01": "BL",
    "REU02": "RE",
    "REUOT": "RE",
    "GMBAC": "GM",
    "GMBQC": "GM",
    "GNBSB": "GW",
    "GNQHT": "GQ",
    "GRCCO": "GR",
    "GRCCT": "GR",
    "GRCPF": "GR",
    "GRCSH": "GR",
    "GRDCW": "GD",
    "GRLTG": "GL",
    "GTMSC": "GT",
    "GTMTG": "GT",
    "GUMDP": "US",
    "GUMHT": "GU",
    "GUYUM": "GY",
    "HKGH3": "HK",
    "HKGHT": "HK",
    "HKGM3": "HK",
    "HKGMC": "HK",
    "HKGNW": "HK",
    "HKGPP": "HK",
    "HKGSM": "HK",
    "HNDDC": "HN",
    "HNDK7": "HN",
    "HNDME": "HN",
    "HRVCN": "HR",
    "HRVT2": "HR",
    "HRVVI": "HR",
    "HTICL": "HT",
    "HTIVT": "HT",
    "HUNH1": "HU",
    "HUNH2": "HU",
    "HUNVR": "HU",
    "IDN89": "ID",
    "IDNEX": "ID",
    "IDNIM": "ID",
    "IDNLT": "ID",
    "IDNSL": "ID",
    "IDNTS": "ID",
    "IND02": "IN",
    "IND03": "IN",
    "IND04": "IN",
    "IND05": "IN",
    "IND06": "IN",
    "IND07": "IN",
    "IND09": "IN",
    "IND10": "IN",
    "IND11": "IN",
    "IND12": "IN",
    "IND14": "IN",
    "IND15": "IN",
    "IND16": "IN",
    "IND17": "IN",
    "IND18": "IN",
    "IND19": "IN",
    "IND20": "IN",
    "IND21": "IN",
    "IND22": "IN",
    "IND23": "IN",
    "IND24": "IN",
    "IND25": "IN",
    "IND26": "IN",
    "IND27": "IN",
    "IND28": "IN",
    "IND29": "IN",
    "INDA1": "IN",
    "INDA2": "IN",
    "INDA5": "IN",
    "INDA7": "IN",
    "INDA8": "IN",
    "INDA9": "IN",
    "INDAC": "IN",
    "INDAT": "IN",
    "INDBI": "IN",
    "INDBK": "IN",
    "INDBL": "IN",
    "INDBM": "IN",
    "INDBO": "IN",
    "INDBT": "IN",
    "INDCC": "IN",
    "INDDL": "IN",
    "INDE1": "IN",
    "INDEH": "IN",
    "INDEK": "IN",
    "INDEU": "IN",
    "INDF1": "IN",
    "INDHM": "IN",
    "INDIB": "IN",
    "INDID": "IN",
    "INDIK": "IN",
    "INDIM": "IN",
    "INDIO": "IN",
    "INDIT": "IN",
    "INDIW": "IN",
    "INDJ1": "IN",
    "INDJ2": "IN",
    "INDJ3": "IN",
    "INDJ4": "IN",
    "INDJ5": "IN",
    "INDJ6": "IN",
    "INDJ7": "IN",
    "INDJ8": "IN",
    "INDJ9": "IN",
    "INDJH": "IN",
    "INDJL": "IN",
    "INDJM": "IN",
    "INDJN": "IN",
    "INDJO": "IN",
    "INDJP": "IN",
    "INDJQ": "IN",
    "INDJR": "IN",
    "INDJS": "IN",
    "INDJT": "IN",
    "INDJU": "IN",
    "INDJV": "IN",
    "INDJW": "IN",
    "INDJX": "IN",
    "INDMB": "IN",
    "INDMP": "IN",
    "INDMT": "IN",
    "INDRC": "IN",
    "INDRM": "IN",
    "INDSK": "IN",
    "INDSP": "IN",
    "INDT0": "IN",
    "INDT1": "IN",
    "INDT2": "IN",
    "INDT3": "IN",
    "INDT4": "IN",
    "INDT5": "IN",
    "INDT6": "IN",
    "INDT7": "IN",
    "INDT8": "IN",
    "INDT9": "IN",
    "INDTB": "IN",
    "INDTD": "IN",
    "INDTG": "IN",
    "INDTH": "IN",
    "INDTK": "IN",
    "INDTM": "IN",
    "INDTO": "IN",
    "INDTP": "IN",
    "INDTR": "IN",
    "INDWB": "IN",
    "IRLDF": "IE",
    "IRLEC": "IE",
    "IRLH3": "IE",
    "IRLME": "IE",
    "IRN11": "IR",
    "IRNMI": "IR",
    "IRNTT": "IR",
    "IRQAC": "IQ",
    "IRQKK": "IQ",
    "ISLNO": "IS",
    "ISLPS": "IS",
    "ISLTL": "IS",
    "ISLVW": "IS",
    "ISR01": "IL",
    "ISRCL": "IL",
    "ISRMS": "IL",
    "ISRPL": "IL",
    "ITAFM": "IT",
    "ITAGT": "XX",
    "ITAH3": "IT",
    "ITAOM": "IT",
    "ITASI": "IT",
    "ITAWI": "IT",
    "JAMCW": "JM",
    "JAMDC": "TC",
    "JORFL": "JO",
    "JORMC": "JO",
    "JORUM": "JO",
    "JPNDO": "JP",
    "JPNJP": "JP",
    "JPNKI": "JP",
    "K0001": "XK",
    "KAZ77": "KZ",
    "KAZKT": "KZ",
    "KAZK9": "KZ",
    "KAZKZ": "KZ",
    "KENEC": "KE",
    "KENKC": "KE",
    "KENSA": "KE",
    "KENTK": "KE",
    "KGZ01": "KG",
    "KHMCC": "KH",
    "KHMGM": "KH",
    "KHMK5": "KH",
    "KHMVC": "KH",
    "KIRKL": "KI",
    "KNACW": "KN",
    "KORKF": "KR",
    "KORLU": "KR",
    "KORSK": "KR",
    "KWTKT": "KW",
    "KWTMT": "KW",
    "KWTK9": "KW",
    "KWTNM": "KW",
    "LAOAS": "LA",
    "LAOET": "LA",
    "LAOTC": "LA",
    "LAOK7": "LA",
    "LAOTL": "LA",
    "LBNFL": "LB",
    "LBNLC": "LB",
    "LBRLC": "LR",
    "LBY01": "LY",
    "LCACW": "LC",
    "LIEMK": "LI",
    "LIETG": "LI",
    "LIEVE": "LI",
    "LKA71": "LK",
    "LKACT": "LK",
    "LKADG": "LK",
    "LKAK5": "LK",
    "LKAHT": "LK",
    "LSOET": "LS",
    "LSOVL": "LS",
    "LTU03": "LT",
    "LTUMT": "LT",
    "LTUOM": "LT",
    "LUXPT": "LU",
    "LUXTG": "LU",
    "LUXVM": "LU",
    "LVABC": "LV",
    "LVALM": "LV",
    "MACCT": "MO",
    "MACHT": "MO",
    "MARM1": "MA",
    "MARM3": "MA",
    "MCOK8": "MC",
    "MCOM2": "MC",
    "MDAK8": "MD",
    "MDAMC": "MD",
    "MDAVX": "MD",
    "MDGCO": "MG",
    "MDGTM": "MG",
    "MDV01": "MV",
    "MDVWM": "MV",
    "MEXAL": "MX",
    "MEXIU": "MX",
    "MEXMS": "MX",
    "MEXN3": "MX",
    "MEXTL": "MX",
    "MKDNO": "MK",
    "MLI02": "ML",
    "MLTGO": "MT",
    "MLTMA": "XX",
    "MLTTL": "MT",
    "MMROM": "MM",
    "MMRPT": "MM",
    "MMRTN": "MM",
    "MNEMT": "ME",
    "MNETM": "ME",
    "MNEPM": "ME",
    "MNGMC": "MN",
    "MNGMN": "MN",
    "MNGSK": "MN",
    "MOZ01": "MZ",
    "MOZVC": "MZ",
    "MOZVG": "MZ",
    "MRTMT": "MR",
    "MSRCW": "MS",
    "MUSCP": "MU",
    "MUSEM": "MU",
    "MUSMT": "MU",
    "MWICP": "MW",
    "MWICT": "MW",
    "MYSBC": "MY",
    "MYSCC": "MY",
    "MYSMI": "MY",
    "MYSMR": "MY",
    "MYSMT": "MY",
    "NAM01": "NA",
    "NAM03": "NA",
    "NCLPT": "NC",
    "NERCT": "NE",
    "NEROR": "NE",
    "NGAEM": "NG",
    "NGAET": "NG",
    "NGAGM": "NG",
    "NGAMN": "NG",
    "NGANT": "NG",
    "NICEN": "NI",
    "NICSC": "NI",
    "NLDDT": "NL",
    "NLDLT": "NL",
    "NLDPN": "NL",
    "NLDPT": "NL",
    "NORAM": "XX",
    "NORMC": "XX",
    "NORNN": "NO",
    "NORTD": "NO",
    "NORIC": "NO",
    "NORNC": "NO",
    "NORTM": "NO",
    "NPLM2": "NP",
    "NPLNM": "NP",
    "NZLBS": "NZ",
    "NZLNH": "NZ",
    "NZLK8": "NZ",
    "NZLTM": "NZ",
    "OMNGT": "OM",
    "OMNNT": "OM",
    "OMNVF": "OM",
    "PAKMK": "PK",
    "PAKTP": "PK",
    "PAKUF": "PK",
    "PAKWA": "PK",
    "PANCL": "PA",
    "PANCW": "PA",
    "PANDC": "PA",
    "PANMS": "PA",
    "PERMO": "PE",
    "PERTM": "PE",
    "PERVG": "PE",
    "PHLDG": "PH",
    "PHLGT": "PH",
    "PHLSR": "PH",
    "PNGDP": "PG",
    "PNGPM": "PG",
    "POL02": "PL",
    "POL03": "PL",
    "POLKM": "PL",
    "POLP4": "PL",
    "PRICL": "PR",
    "PRTOP": "PT",
    "PRTTL": "PT",
    "PRTTM": "PT",
    "PRYHT": "PY",
    "PRYNP": "PY",
    "PRYTC": "PY",
    "PRYVX": "PY",
    "PSEJE": "PS",
    "QATB1": "QA",
    "QATQT": "QA",
    "ROMCS": "RO",
    "ROMMF": "RO",
    "ROMMR": "RO",
    "RUS01": "RU",
    "RUSBD": "RU",
    "RUSEC": "RU",
    "RUSNW": "RU",
    "RUST2": "RU",
    "RWAAR": "RW",
    "RWAMN": "RW",
    "RWAK9": "RW",
    "RWATG": "RW",
    "SAUAJ": "SA",
    "SAUET": "SA",
    "SAUZN": "SA",
    "SDNBT": "SD",
    "SENEX": "SN",
    "SENAZ": "SN",
    "SENSG": "SN",
    "WSMDP": "WS",
    "SGPM1": "SG",
    "SGPML": "SG",
    "SGPSH": "SG",
    "SGPST": "SG",
    "SLEAC": "SL",
    "SLECT": "SL",
    "SLVDC": "SV",
    "SLVTM": "SV",
    "SLVTP": "SV",
    "SLVTS": "SV",
    "SOM01": "SO",
    "SRBNO": "RS",
    "SSDMN": "SS",
    "SSDZS": "SS",
    "STPST": "ST",
    "SUDMO": "SD",
    "SURDC": "SR",
    "SURTG": "SR",
    "SVKET": "SK",
    "SVKGT": "SK",
    "SVKO2": "SK",
    "SVNMT": "SI",
    "SVNSM": "SI",
    "SWEEP": "SE",
    "SWEHU": "SE",
    "SWEIQ": "SE",
    "SWETR": "SE",
    "SWZMN": "SZ",
    "SYCAT": "SC",
    "SYCCW": "SC",
    "SYRSP": "SY",
    "TCACW": "TC",
    "TCDCT": "TD",
    "TCDML": "TD",
    "TGOTC": "TG",
    "TGOTL": "TG",
    "THACA": "TH",
    "THACO": "TH",
    "THADT": "TH",
    "THAWN": "TH",
    "THAWP": "TH",
    "TJK91": "TJ",
    "TJKK6": "TJ",
    "TLSVG": "TL",
    "TONDP": "TO",
    "TTODL": "TT",
    "TUNOR": "TN",
    "TUNTA": "TN",
    "TUNTT": "TN",
    "TURAC": "TR",
    "TURIS": "TR",
    "TURTC": "TR",
    "TURTS": "TR",
    "TWNFE": "TW",
    "TWNLD": "TW",
    "TWNPC": "TW",
    "TWNTG": "TW",
    "TZACT": "TZ",
    "TZAMB": "TZ",
    "TZAVC": "TZ",
    "TZAVG": "TZ",
    "TZAYA": "TZ",
    "TZAZN": "TZ",
    "UGACE": "UG",
    "UGAMN": "UG",
    "UGAOR": "UG",
    "UGASU": "UG",
    "UGATL": "UG",
    "UGAWT": "UG",
    "UKRAS": "UA",
    "UKRKS": "UA",
    "UKRRS": "UA",
    "UKRUM": "UA",
    "UKRUT": "UA",
    "URYAM": "UY",
    "URYTM": "UY",
    "USACB": "US",
    "USACD": "US",
    "USACG": "US",
    "USACI": "US",
    "USACO": "US",
    "USACW": "US",
    "USAGC": "US",
    "USAGU": "US",
    "USAIN": "US",
    "USAPE": "US",
    "USASP": "US",
    "USAUD": "US",
    "USAUN": "US",
    "USAVZ": "US",
    "USAW6": "US",
    "UZB05": "UZ",
    "UZBDU": "UZ",
    "VCTCW": "VC",
    "VEND2": "VE",
    "VENMS": "VE",
    "VGBCC": "VG",
    "VGBCW": "VG",
    "VGBDC": "VG",
    "VNMMO": "VN",
    "VNMVI": "VN",
    "VNMVM": "VN",
    "VNMVT": "VN",
    "VUTDP": "VU",
    "YUGMT": "RS",
    "ZAFCC": "ZA",
    "ZAFJT": "ZA",
    "ZAFMN": "ZA",
    "ZAFVC": "ZA",
    "ZMBCE": "ZM",
    "ZMBCZ": "ZM",
    "ZWEET": "ZW",
    "ZWEN3": "ZW",
  };

  static String getCountryCode(String countryName) {
    // Extract unique country codes from PLMN mapping and create reverse lookup
    final uniqueCountries = <String, String>{};
    for (final code in _plmnCountryMap.values) {
      if (code != 'XX') {
        // Map common country names to codes for fallback
        switch (code) {
          case 'US':
            uniqueCountries['United States'] = code;
            break;
          case 'GB':
            uniqueCountries['United Kingdom'] = code;
            break;
          case 'DE':
            uniqueCountries['Germany'] = code;
            break;
          case 'FR':
            uniqueCountries['France'] = code;
            break;
          case 'CN':
            uniqueCountries['China'] = code;
            break;
          case 'JP':
            uniqueCountries['Japan'] = code;
            break;
          case 'IN':
            uniqueCountries['India'] = code;
            break;
          case 'BR':
            uniqueCountries['Brazil'] = code;
            break;
          case 'CA':
            uniqueCountries['Canada'] = code;
            break;
          case 'AU':
            uniqueCountries['Australia'] = code;
            break;
          case 'RU':
            uniqueCountries['Russia'] = code;
            break;
          case 'ES':
            uniqueCountries['Spain'] = code;
            break;
          case 'IT':
            uniqueCountries['Italy'] = code;
            break;
          case 'AZ':
            uniqueCountries['Azerbaijan'] = code;
            break;
          case 'BY':
            uniqueCountries['Belarus'] = code;
            break;
          case 'BJ':
            uniqueCountries['Benin'] = code;
            break;
          case 'BT':
            uniqueCountries['Bhutan'] = code;
            break;
          case 'BO':
            uniqueCountries['Bolivia'] = code;
            break;
          case 'BM':
            uniqueCountries['Bermuda'] = code;
            break;
          case 'KZ':
            uniqueCountries['Kazakhstan'] = code;
            break;
          case 'KH':
            uniqueCountries['Cambodia'] = code;
            break;
          case 'FJ':
            uniqueCountries['Fiji'] = code;
            break;
          case 'GH':
            uniqueCountries['Ghana'] = code;
            break;
          case 'GP':
            uniqueCountries['Guadeloupe'] = code;
            break;
          case 'GU':
            uniqueCountries['Guam'] = code;
            break;
          case 'HN':
            uniqueCountries['Honduras'] = code;
            break;
          case 'IQ':
            uniqueCountries['Iraq'] = code;
            break;
          case 'KW':
            uniqueCountries['Kuwait'] = code;
            break;
          case 'LA':
            uniqueCountries['Laos'] = code;
            break;
          case 'LR':
            uniqueCountries['Liberia'] = code;
            break;
          case 'MD':
            uniqueCountries['Moldova'] = code;
            break;
          case 'MC':
            uniqueCountries['Monaco'] = code;
            break;
          case 'MN':
            uniqueCountries['Mongolia'] = code;
            break;
          case 'ME':
            uniqueCountries['Montenegro'] = code;
            break;
          case 'CW':
            uniqueCountries['Netherlands Antilles'] = code;
            break;
          case 'NZ':
            uniqueCountries['New Zealand'] = code;
            break;
          case 'NO':
            uniqueCountries['Norway'] = code;
            break;
          case 'OM':
            uniqueCountries['Oman'] = code;
            break;
          case 'RE':
            uniqueCountries['Reunion'] = code;
            break;
          case 'RW':
            uniqueCountries['Rwanda'] = code;
            break;
          case 'WS':
            uniqueCountries['Samoa'] = code;
            break;
          case 'SN':
            uniqueCountries['Senegal'] = code;
            break;
          case 'LK':
            uniqueCountries['Sri Lanka'] = code;
            break;
          case 'TJ':
            uniqueCountries['Tajikistan'] = code;
            break;
          case 'VE':
            uniqueCountries['Venezuela'] = code;
            break;
        }
      }
    }

    final lowerCountryName = countryName.toLowerCase().trim();

    // Direct match first
    for (final entry in uniqueCountries.entries) {
      if (entry.key.toLowerCase() == lowerCountryName) {
        return entry.value;
      }
    }

    // Simple contains match for common variations
    if (lowerCountryName.contains('united states') ||
        lowerCountryName.contains('usa'))
      return 'US';
    if (lowerCountryName.contains('united kingdom') ||
        lowerCountryName.contains('britain'))
      return 'GB';
    if (lowerCountryName.contains('germany')) return 'DE';
    if (lowerCountryName.contains('france')) return 'FR';
    if (lowerCountryName.contains('china')) return 'CN';
    if (lowerCountryName.contains('japan')) return 'JP';
    if (lowerCountryName.contains('india')) return 'IN';
    if (lowerCountryName.contains('brazil')) return 'BR';
    if (lowerCountryName.contains('canada')) return 'CA';
    if (lowerCountryName.contains('australia')) return 'AU';
    if (lowerCountryName.contains('russia')) return 'RU';
    if (lowerCountryName.contains('spain')) return 'ES';
    if (lowerCountryName.contains('italy')) return 'IT';
    if (lowerCountryName.contains('azerbaijan')) return 'AZ';
    if (lowerCountryName.contains('belarus')) return 'BY';
    if (lowerCountryName.contains('benin')) return 'BJ';
    if (lowerCountryName.contains('bhutan')) return 'BT';
    if (lowerCountryName.contains('bolivia')) return 'BO';
    if (lowerCountryName.contains('bermuda')) return 'BM';
    if (lowerCountryName.contains('kazakhstan')) return 'KZ';
    if (lowerCountryName.contains('cambodia')) return 'KH';
    if (lowerCountryName.contains('fiji')) return 'FJ';
    if (lowerCountryName.contains('ghana')) return 'GH';
    if (lowerCountryName.contains('guadeloupe')) return 'GP';
    if (lowerCountryName.contains('guam')) return 'GU';
    if (lowerCountryName.contains('honduras')) return 'HN';
    if (lowerCountryName.contains('iraq')) return 'IQ';
    if (lowerCountryName.contains('kuwait')) return 'KW';
    if (lowerCountryName.contains('laos')) return 'LA';
    if (lowerCountryName.contains('liberia')) return 'LR';
    if (lowerCountryName.contains('moldova')) return 'MD';
    if (lowerCountryName.contains('monaco')) return 'MC';
    if (lowerCountryName.contains('mongolia')) return 'MN';
    if (lowerCountryName.contains('montenegro')) return 'ME';
    if (lowerCountryName.contains('netherlands antilles')) return 'CW';
    if (lowerCountryName.contains('new zealand')) return 'NZ';
    if (lowerCountryName.contains('norway')) return 'NO';
    if (lowerCountryName.contains('oman')) return 'OM';
    if (lowerCountryName.contains('reunion')) return 'RE';
    if (lowerCountryName.contains('rwanda')) return 'RW';
    if (lowerCountryName.contains('samoa')) return 'WS';
    if (lowerCountryName.contains('senegal')) return 'SN';
    if (lowerCountryName.contains('sri lanka')) return 'LK';
    if (lowerCountryName.contains('tajikistan')) return 'TJ';
    if (lowerCountryName.contains('venezuela')) return 'VE';

    return 'UN'; // Default to UN flag if not found
  }

  // Get country code from PLMN code
  static String getCountryCodeFromPLMN(String plmnCode) {
    final countryCode = _plmnCountryMap[plmnCode.toUpperCase()];
    return countryCode != null && countryCode != 'XX' ? countryCode : 'UN';
  }

  // Enhanced method that tries both country name matching and PLMN lookup
  static String getCountryCodeEnhanced(String identifier, {String? plmnCode}) {
    // First try PLMN if provided
    if (plmnCode != null && plmnCode.isNotEmpty) {
      final plmnResult = getCountryCodeFromPLMN(plmnCode);
      if (plmnResult != 'UN') {
        return plmnResult;
      }
    }

    // Fallback to country name matching
    return getCountryCode(identifier);
  }
}
