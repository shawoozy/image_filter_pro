class NamedColorFilter {
  final List<double> colorFilterMatrix;
  final String name;

  const NamedColorFilter({required this.colorFilterMatrix, required this.name});
}

const List<NamedColorFilter> defaultColorFilters = [
  NamedColorFilter(
    colorFilterMatrix: [],
    name: "None",
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.8, 0.1, 0.1, 0, 20,
      0.1, 0.8, 0.1, 0, 20,
      0.1, 0.1, 0.8, 0, 20,
      0, 0, 0, 1, 0,
    ],
    name: "Vintage",
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0.1, 0.1, 0, 10,
      0.1, 1, 0.1, 0, 10,
      0.1, 0.1, 1, 0, 10,
      0, 0, 0, 1, 0,
    ],
    name: 'Mood',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0, 0, 0, 0,
      0, 1.2, 0, 0, 0,
      0, 0, 1.2, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Crisp',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.9, 0, 0.2, 0, 0,
      0, 1, 0.1, 0, 0,
      0.1, 0, 1.2, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Cool',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.1, 0.1, 0.1, 0, 10,
      0.1, 1, 0.1, 0, 10,
      0.1, 0.1, 1, 0, 5,
      0, 0, 0, 1, 0,
    ],
    name: 'Blush',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.3, 0, 0.1, 0, 15,
      0, 1.1, 0.1, 0, 10,
      0, 0, 0.9, 0, 5,
      0, 0, 0, 1, 0,
    ],
    name: 'Sunkissed',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0, 0, 0, 20,
      0, 1.2, 0, 0, 20,
      0, 0, 1.1, 0, 20,
      0, 0, 0, 1, 0,
    ],
    name: 'Fresh',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.1, 0, -0.1, 0, 10,
      -0.1, 1.1, 0.1, 0, 5,
      0, -0.1, 1.1, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Classic',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.5, 0, 0.1, 0, 0,
      0, 1.45, 0, 0, 0,
      0.1, 0, 1.3, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Lomo-ish',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0.15, -0.15, 0, 15,
      0.1, 1.1, 0.1, 0, 10,
      -0.05, 0.2, 1.25, 0, 5,
      0, 0, 0, 1, 0,
    ],
    name: 'Nashville',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.15, 0.1, 0.1, 0, 20,
      0.1, 1.1, 0, 0, 10,
      0.1, 0.1, 1.2, 0, 5,
      0, 0, 0, 1, 0,
    ],
    name: 'Valencia',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0, 0, 0, 10,
      0, 1.25, 0, 0, 10,
      0, 0, 1.3, 0, 10,
      0, 0, 0, 1, 0,
    ],
    name: 'Clarendon',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.33, 0.33, 0.33, 0, 0,
      0.33, 0.33, 0.33, 0, 0,
      0.33, 0.33, 0.33, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Moon',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.5, 0.5, 0.5, 0, 20,
      0.5, 0.5, 0.5, 0, 20,
      0.5, 0.5, 0.5, 0, 20,
      0, 0, 0, 1, 0,
    ],
    name: 'Willow',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.3, 0.1, -0.1, 0, 10,
      0, 1.25, 0.1, 0, 10,
      0, -0.1, 1.1, 0, 5,
      0, 0, 0, 1, 0,
    ],
    name: 'Kodak',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.8, 0.2, 0.1, 0, 0,
      0.2, 1.1, 0.1, 0, 0,
      0.1, 0.1, 1.2, 0, 10,
      0, 0, 0, 1, 0,
    ],
    name: 'Frost',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.1, 0.95, 0.2, 0, 0,
      0.1, 1.5, 0.1, 0, 0,
      0.2, 0.7, 0, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Night Vision',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.5, 0.2, 0, 0, 0,
      0.1, 0.9, 0.1, 0, 0,
      -0.1, -0.2, 1.3, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Sunset',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.3, -0.3, 0.1, 0, 0,
      -0.1, 1.2, -0.1, 0, 0,
      0.1, -0.2, 1.3, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Noir',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.1, 0.1, 0.1, 0, 0,
      0.1, 1.1, 0.1, 0, 0,
      0.1, 0.1, 1.1, 0, 15,
      0, 0, 0, 1, 0,
    ],
    name: 'Dreamy',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.393, 0.769, 0.189, 0, 0,
      0.349, 0.686, 0.168, 0, 0,
      0.272, 0.534, 0.131, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Sepia',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.438, -0.062, -0.062, 0, 0,
      -0.122, 1.378, -0.122, 0, 0,
      -0.016, -0.016, 1.483, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Radium',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.2126, 0.7152, 0.0722, 0, 0,
      0.2126, 0.7152, 0.0722, 0, 0,
      0.7873, 0.2848, 0.9278, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Aqua',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.3, 0, 1.2, 0, 0,
      0, 1.1, 0, 0, 0,
      0.2, 0, 1.3, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Purple Haze',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.2, 0.1, 0, 0, 0,
      0, 1.1, 0.2, 0, 0,
      0.1, 0, 0.7, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Lemonade',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.6, 0.2, 0, 0, 0,
      0.1, 1.3, 0.1, 0, 0,
      0, 0.1, 0.9, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Caramel',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.3, 0.5, 0, 0, 0,
      0.2, 1.1, 0.3, 0, 0,
      0.1, 0.1, 1.2, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Peachy',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.8, 0.2, 0.5, 0, 0,
      0.1, 1.2, 0.1, 0, 0,
      0.3, 0.1, 1.7, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Cool Blue',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.5, 0, 0, 0, 0,
      0, 0.5, 0, 0, 0,
      0, 0, 0.5, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Contrast',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1, 0, 1, 0, 0,
      0, 2, 0, 0, 0,
      0, 0, 3, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Neon',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.9, 0.1, 0.2, 0, 0,
      0, 1, 0.1, 0, 0,
      0.1, 0, 1.2, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Cold Morning',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.9, 0.2, 0, 0, 0,
      0, 1.2, 0, 0, 0,
      0, 0, 1.1, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Lush',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      1.1, 0, 0.3, 0, 0,
      0, 0.9, 0.3, 0, 0,
      0.3, 0.1, 1.2, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Urban Neon',
  ),
  NamedColorFilter(
    colorFilterMatrix: [
      0.6, 0.2, 0.2, 0, 0,
      0.2, 0.6, 0.2, 0, 0,
      0.2, 0.2, 0.7, 0, 0,
      0, 0, 0, 1, 0,
    ],
    name: 'Moody Monochrome',
  ),
];
