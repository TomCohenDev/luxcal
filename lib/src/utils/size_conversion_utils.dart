class SizeConversionUtils {
  static final List<String> topSizes = [
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "XXXL",
  ];

  static final List<String> topSizesEU = [
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "XXXL",
  ];

  static final List<String> topSizesUK = [
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "XXXL",
  ];

  static List<String> generateHeightCMSizes() {
    List<String> heights = [];

    for (int i = 140; i <= 190; i += 1) {
      heights.add("$i");
    }

    return heights;
  }

  static List<String> generateHeightINCHSizes() {
    List<String> heights = [];

    for (int i = 140; i <= 190; i += 2) {
      var lastValue = heights.isNotEmpty ? heights.last : null;
      var newValue = "${(i ~/ 30.48)}'${((i % 30.48) / 2.54).round()}\"";
      if (newValue != lastValue) {
        heights.add(newValue);
      }
      // heights.add("${(i ~/ 30.48)}'${((i % 30.48) / 2.54).round()}\"");
    }

    return heights;
  }

  static List<String> generateBottomSizes() {
    List<String> sizes = [];
    sizes.add("00");

    for (int i = 0; i <= 20; i += 2) {
      sizes.add("$i");
    }

    sizes.addAll(["22W", "24W", "26W"]);

    return sizes;
  }

  static List<String> generateBottomSizesEU() {
    List<String> sizes = [];

    for (int i = 30; i <= 58; i += 2) {
      sizes.add(i.toString());
    }

    return sizes;
  }

  static List<String> generateBottomSizesUK() {
    List<String> sizes = [];

    for (int i = 2; i <= 30; i += 2) {
      sizes.add(i.toString());
    }

    return sizes;
  }

  static List<String> generateJeansSizes() {
    List<String> sizes = [];

    for (int i = 23; i <= 46; i++) {
      sizes.add(i.toString());
    }

    return sizes;
  }

  static final List<String> jeansSizesEU = generateJeansSizes();

  static final List<String> jeansSizesUK = generateJeansSizes();

  static final List<String> dressSizes = generateBottomSizes();

  static final List<String> dressSizesEU = [
    "XXS",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "XXL",
    "XXXL",
  ];

  static List<String> generateDressSizesUK() {
    List<String> sizes = [];

    for (int i = 2; i <= 30; i += 2) {
      sizes.add(i.toString());
    }

    return sizes;
  }

  static final double minEUSize = 35.0;
  static final double maxEUSize = 43.5;

  static List<String> generateShoeSizesEU() {
    List<String> sizes = [];

    for (double size = minEUSize; size <= maxEUSize; size += 0.5) {
      if (size.remainder(1) == 0) {
        sizes.add(size.toInt().toString());
      } else {
        sizes.add(size.toString());
      }
    }

    return sizes;
  }

  static List<String> generateShoeSizesUK() {
    List<String> sizes = [];

    for (double size = minEUSize - 33; size <= maxEUSize - 33; size += 0.5) {
      if (size.remainder(1) == 0) {
        sizes.add(size.toInt().toString());
      } else {
        sizes.add(size.toString());
      }
    }

    return sizes;
  }

  static List<String> generateShoeSizesUS() {
    List<String> sizes = [];

    for (double size = minEUSize - 30; size <= maxEUSize - 30; size += 0.5) {
      if (size.remainder(1) == 0) {
        sizes.add(size.toInt().toString());
      } else {
        sizes.add(size.toString());
      }
    }

    return sizes;
  }

  static List<String> getSizeList(String unit, String category) {
    unit = unit.toUpperCase();
    category = category.toUpperCase();

    switch (unit) {
      case "EU":
        switch (category) {
          case "DRESSES":
            return dressSizesEU;
          case "JUMPSUITS":
            return dressSizesEU;
          case "TOPS":
            return topSizesEU;
          case "COATS & JACKETS":
            return topSizesEU;
          case "JEANS":
            return jeansSizesEU;
          case "SHOES":
            return generateShoeSizesEU();
          case "PANTS":
            return generateBottomSizesEU();

          case "BOTTOMS":
            return generateBottomSizesEU();
          case "HEIGHT":
            return generateHeightCMSizes();
          default:
            throw Exception("Invalid category: $category");
        }
      case "US":
        switch (category) {
          case "DRESSES":
            return dressSizes;
          case "JUMPSUITS":
            return dressSizes;
          case "TOPS":
            return topSizes;

          case "COATS & JACKETS":
            return topSizes;
          case "JEANS":
            return generateJeansSizes();
          case "SHOES":
            return generateShoeSizesUS();
          case "PANTS":
            return generateBottomSizes();
          case "BOTTOMS":
            return generateBottomSizes();
          case "HEIGHT":
            return generateHeightINCHSizes();
          default:
            throw Exception("Invalid category: $category");
        }
      case "UK":
        switch (category) {
          case "DRESSES":
            return generateDressSizesUK();
          case "JUMPSUITS":
            return generateDressSizesUK();
          case "TOPS":
            return topSizesUK;
          case "COATS & JACKETS":
            return topSizesUK;
          case "JEANS":
            return jeansSizesUK;
          case "SHOES":
            return generateShoeSizesUK();
          case "PANTS":
            return generateBottomSizesUK();
          case "BOTTOMS":
            return generateBottomSizesUK();
          case "HEIGHT":
            return generateHeightCMSizes();
          default:
            throw Exception("Invalid category: $category");
        }
      default:
        throw Exception("Invalid unit: $unit");
    }
  }

  // Bottom Size Conversion Functions
  static String convertUSToEUBottom(String size) {
    if (size == "00") return "30";

    int numericSize = int.tryParse(size.replaceAll('W', '')) ?? 0;
    return (numericSize + 32).toString();
  }

  static String convertUSToUKBottom(String size) {
    if (size == "00") return "2";

    int numericSize = int.tryParse(size.replaceAll('W', '')) ?? 0;
    return (numericSize + 4).toString();
  }

  static String convertEUToUSBottom(String size) {
    if (size == "30") return "00";
    int numericSize = int.tryParse(size) ?? 0;
    if (numericSize - 32 >= 22) {
      return (numericSize - 32).toString() + 'W';
    }
    return (numericSize - 32).toString();
  }

  static String convertEUToUKBottom(String size) {
    int numericSize = int.tryParse(size) ?? 0;

    return (numericSize - 28).toString();
  }

  static String convertUKToUSBottom(String size) {
    int numericSize = int.tryParse(size) ?? 0;
    return convertEUToUSBottom((numericSize + 28).toString());
  }

  static String convertUKToEUBottom(String size) {
    int numericSize = int.tryParse(size) ?? 0;

    return (numericSize + 28).toString();
  }

  static String convertBottomSize(
      String currentUnit, String wantedUnit, String bottomSize) {
    if (currentUnit == "US" && wantedUnit == "EU") {
      return convertUSToEUBottom(bottomSize);
    } else if (currentUnit == "US" && wantedUnit == "UK") {
      return convertUSToUKBottom(bottomSize);
    } else if (currentUnit == "EU" && wantedUnit == "US") {
      return convertEUToUSBottom(bottomSize);
    } else if (currentUnit == "EU" && wantedUnit == "UK") {
      return convertEUToUKBottom(bottomSize);
    } else if (currentUnit == "UK" && wantedUnit == "US") {
      return convertUKToUSBottom(bottomSize);
    } else if (currentUnit == "UK" && wantedUnit == "EU") {
      return convertUKToEUBottom(bottomSize);
    }
    return "Error";
    // Consider adding a default return/error if no matches.
  }

  static String convertPantsSize(
      String currentUnit, String wantedUnit, String pantsSize) {
    return convertBottomSize(currentUnit, wantedUnit,
        pantsSize); // Using the same function since the conversion pattern is the same
  }

  // Conversion from US to EU for dresses
  static String convertUSToEUDress(String dressSize) {
    switch (dressSize) {
      case "00":
        return "XXS";
      case "0":
      case "2":
        return "XS";
      case "4":
      case "6":
        return "S";
      case "8":
      case "10":
        return "M";
      case "12":
      case "14":
        return "L";
      case "16":
      case "18":
        return "XL";
      case "20":
      case "22W":
        return "XXL";
      case "24W":
      case "26W":
        return "XXXL";
      default:
        throw Exception("Invalid US dress size: $dressSize");
    }
  }

  static String convertUSToUKDress(String dressSize) {
    if (dressSize == "00") return "2";
    int numericSize = int.tryParse(dressSize.replaceAll('W', '')) ?? 0;
    return (numericSize + 4).toString();
  }

  static String convertEUToUSDress(String dressSize) {
    switch (dressSize) {
      case "XXS":
        return "00";
      case "XS":
        return "0";
      case "S":
        return "4";
      case "M":
        return "8";
      case "L":
        return "12";
      case "XL":
        return "16";
      case "XXL":
        return "20";
      case "XXXL":
        return "24W";
      default:
        throw Exception("Invalid EU dress size: $dressSize");
    }
  }

  static String convertEUToUKDress(String dressSize) {
    return convertUSToUKDress(convertEUToUSDress(dressSize));
  }

  static String convertUKToUSDress(String dressSize) {
    if (dressSize == "2") return "00";
    int numericSize = int.tryParse(dressSize) ?? 0;
    if (numericSize >= 26) {
      return "${(numericSize - 4).toString()}W";
    }
    return (numericSize - 4).toString();
  }

  static String convertUKToEUDress(String dressSize) {
    return convertUSToEUDress(convertUKToUSDress(dressSize));
  }

  // Unified conversion function for dresses
  static String convertDressSize(
      String currentUnit, String wantedUnit, String dressSize) {
    if (currentUnit == "US" && wantedUnit == "EU") {
      return convertUSToEUDress(dressSize);
    } else if (currentUnit == "US" && wantedUnit == "UK") {
      return convertUSToUKDress(dressSize);
    } else if (currentUnit == "EU" && wantedUnit == "US") {
      return convertEUToUSDress(dressSize);
    } else if (currentUnit == "EU" && wantedUnit == "UK") {
      return convertEUToUKDress(dressSize);
    } else if (currentUnit == "UK" && wantedUnit == "US") {
      return convertUKToUSDress(dressSize);
    } else if (currentUnit == "UK" && wantedUnit == "EU") {
      return convertUKToEUDress(dressSize);
    } else {
      throw Exception(
          "Unsupported conversion: $currentUnit to $wantedUnit for dresses");
    }
  }

  static String convertUSToEUShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    // Simple conversion - add 31. Adjust based on your conversion chart.
    return (numericSize + 31).toString();
  }

  static String convertUSToUKShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    print(numericSize);
    // Simple conversion - subtract 1. Adjust based on your conversion chart.
    return (numericSize - 2).toString();
  }

  static String convertEUToUSShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    // Inverse of the above conversion.
    return (numericSize - 31).toString();
  }

  static String convertEUToUKShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    // Inverse of the US to UK conversion + the EU to US conversion.
    return (numericSize - 33).toString();
  }

  static String convertUKToUSShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    // Inverse of the US to UK conversion.
    return (numericSize + 2).toString();
  }

  static String convertUKToEUShoe(String size) {
    double numericSize = double.tryParse(size) ?? 0;
    // Sum of the US to EU conversion and the UK to US conversion.
    return (numericSize + 33).toString();
  }
}
