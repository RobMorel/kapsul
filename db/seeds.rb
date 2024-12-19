# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Capsule.destroy_all

default_user = User.first || User.create!(
  name: "Default User",
  email: "default@example.com",
  password: "password",
  avatar: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/navy-and-teal-explore-world-map-michelle-eshleman.jpg"
)

# URL de l'audio
audio_url = "https://asset.cloudinary.com/dkrxx2ews/4f75f3abb3dc458be92febe54b7b4b5d"

new_audio_url = "https://asset.cloudinary.com/dkrxx2ews/3a6f244d76b3eaf88d5d1152433e11ad"

# Données pour chaque capsule
locations = [
  {
    city: "Los Angeles",
    places: [
      { name: "Hollywood Sign", category: "history", address: "Hollywood Hills, Los Angeles, CA", latitude: 34.134115, longitude: -118.321548 },
      { name: "Venice Beach", category: "art", address: "Venice, Los Angeles, CA", latitude: 33.985047, longitude: -118.469483 },
      { name: "Griffith Observatory", category: "nature", address: "2800 E Observatory Rd, Los Angeles, CA", latitude: 34.118434, longitude: -118.300393 }
    ]
  },
  {
    city: "New York",
    places: [
      { name: "Statue of Liberty", category: "history", address: "Liberty Island, New York, NY", latitude: 40.689247, longitude: -74.044502 },
      { name: "Brooklyn Bridge", category: "architecture", address: "Brooklyn, New York, NY", latitude: 40.706086, longitude: -73.996864 },
      { name: "Times Square", category: "fantasy", address: "Manhattan, New York, NY", latitude: 40.758896, longitude: -73.985130 }
    ]
  },
  {
    city: "London",
    places: [
      { name: "Tower Bridge", category: "architecture", address: "Tower Bridge Rd, London, UK", latitude: 51.505456, longitude: -0.075356 },
      { name: "Camden Market", category: "art", address: "Camden Town, London, UK", latitude: 51.541427, longitude: -0.146596 },
      { name: "Hyde Park", category: "nature", address: "Hyde Park, London, UK", latitude: 51.507268, longitude: -0.165730 }
    ]
  },
  {
    city: "Sydney",
    places: [
      { name: "Sydney Opera House", category: "architecture", address: "Bennelong Point, Sydney, Australia", latitude: -33.856784, longitude: 151.215297 },
      { name: "Bondi Beach", category: "nature", address: "Bondi Beach, Sydney, Australia", latitude: -33.891476, longitude: 151.276684 },
      { name: "The Rocks", category: "history", address: "The Rocks, Sydney, Australia", latitude: -33.859935, longitude: 151.209029 }
    ]
  },
  {
    city: "Cape Town",
    places: [
      { name: "Table Mountain", category: "nature", address: "Table Mountain, Cape Town, South Africa", latitude: -33.962822, longitude: 18.409777 },
      { name: "V&A Waterfront", category: "fantasy", address: "Waterfront, Cape Town, South Africa", latitude: -33.903945, longitude: 18.422053 },
      { name: "Castle of Good Hope", category: "history", address: "Castle Street, Cape Town, South Africa", latitude: -33.925073, longitude: 18.428455 }
    ]
  },
  { city: "Tokyo", places: [
    { name: "Tokyo Tower", category: "architecture", address: "4 Chome-2-8 Shibakoen, Minato City, Tokyo", latitude: 35.6586, longitude: 139.7454 },
    { name: "Meiji Shrine", category: "history", address: "1-1 Yoyogikamizonocho, Shibuya City, Tokyo", latitude: 35.6764, longitude: 139.6993 }
  ]},

  { city: "Osaka", places: [
    { name: "Osaka Castle", category: "history", address: "1-1 Osakajo, Chūō Ward, Osaka", latitude: 34.6873, longitude: 135.5262 },
    { name: "Dotonbori", category: "art", address: "Dotonbori, Chūō Ward, Osaka", latitude: 34.6686, longitude: 135.5011 }
  ]},

  { city: "Shanghai", places: [
    { name: "The Bund", category: "architecture", address: "Zhongshan East 1st Road, Huangpu, Shanghai", latitude: 31.2377, longitude: 121.4912 },
    { name: "Yu Garden", category: "nature", address: "218 Anren St, Huangpu, Shanghai", latitude: 31.2292, longitude: 121.4900 }
  ]},

  { city: "Hong Kong", places: [
    { name: "Victoria Peak", category: "nature", address: "Victoria Peak, Hong Kong", latitude: 22.2750, longitude: 114.1455 },
    { name: "Tsim Sha Tsui", category: "art", address: "Tsim Sha Tsui, Hong Kong", latitude: 22.2963, longitude: 114.1735 }
  ]},

  { city: "Beijing", places: [
    { name: "Forbidden City", category: "history", address: "4 Jingshan Front St, Dongcheng, Beijing", latitude: 39.9163, longitude: 116.3972 },
    { name: "Great Wall of China", category: "nature", address: "Huairou District, Beijing", latitude: 40.4319, longitude: 116.5704 }
  ]},

  { city: "Manila", places: [
    { name: "Rizal Park", category: "history", address: "Ermita, Manila, Philippines", latitude: 14.5790, longitude: 120.9790 },
    { name: "Intramuros", category: "history", address: "Intramuros, Manila, Philippines", latitude: 14.5850, longitude: 120.9763 }
  ]},

  { city: "Bangkok", places: [
    { name: "Grand Palace", category: "history", address: "Na Phra Lan Rd, Phra Nakhon, Bangkok", latitude: 13.7515, longitude: 100.4913 },
    { name: "Wat Arun", category: "architecture", address: "Wat Arun, Bangkok Yai, Bangkok", latitude: 13.7437, longitude: 100.4885 }
  ]},

  { city: "Dubai", places: [
    { name: "Burj Khalifa", category: "architecture", address: "Downtown Dubai, Dubai", latitude: 25.1972, longitude: 55.2744 },
    { name: "Dubai Creek", category: "nature", address: "Dubai Creek, Dubai", latitude: 25.2654, longitude: 55.3081 }
  ]},

  { city: "Doha", places: [
    { name: "Museum of Islamic Art", category: "art", address: "Museum Park St, Doha", latitude: 25.2854, longitude: 51.5310 },
    { name: "Souq Waqif", category: "history", address: "Souq Waqif, Doha", latitude: 25.2866, longitude: 51.5322 }
  ]},

  { city: "Alger", places: [
    { name: "Khalifa Mosque", category: "architecture", address: "Boulevard Amirouche, Alger", latitude: 36.7541, longitude: 3.0626 },
    { name: "Algiers Kasbah", category: "history", address: "Algiers Kasbah, Algeria", latitude: 36.7528, longitude: 3.0420 }
  ]},

  { city: "Tunis", places: [
    { name: "Bardo Museum", category: "history", address: "Le Bardo, Tunis", latitude: 36.7960, longitude: 10.1441 },
    { name: "Medina of Tunis", category: "history", address: "Medina, Tunis", latitude: 36.8008, longitude: 10.1813 }
  ]},

  { city: "Dakar", places: [
    { name: "Gorée Island", category: "history", address: "Gorée Island, Dakar, Senegal", latitude: 14.6885, longitude: -17.3991 },
    { name: "African Renaissance Monument", category: "art", address: "Blaise Diagne International Airport, Dakar", latitude: 14.7248, longitude: -17.4790 }
  ]},

  { city: "Congo", places: [
    { name: "Brazzaville Cathedral", category: "architecture", address: "Place de la République, Brazzaville, Congo", latitude: -4.2650, longitude: 15.2851 },
    { name: "Congo River", category: "nature", address: "Congo River, Congo", latitude: -4.2582, longitude: 15.3162 }
  ]},

  { city: "Dublin", places: [
    { name: "Trinity College", category: "history", address: "College Green, Dublin", latitude: 53.3440, longitude: -6.2672 },
    { name: "St. Stephen's Green", category: "nature", address: "St Stephen's Green, Dublin", latitude: 53.3342, longitude: -6.2579 }
  ]},

  { city: "Berlin", places: [
    { name: "Brandenburg Gate", category: "history", address: "Pariser Platz, Berlin", latitude: 52.5163, longitude: 13.3777 },
    { name: "Berlin Wall Memorial", category: "history", address: "Bernauer Str. 111, 13355 Berlin", latitude: 52.5372, longitude: 13.3905 }
  ]},

  { city: "Barcelona", places: [
    { name: "Sagrada Familia", category: "architecture", address: "Carrer de Mallorca, 401, 08013 Barcelona", latitude: 41.4036, longitude: 2.1744 },
    { name: "Park Güell", category: "nature", address: "Carrer d'Olot, 08024 Barcelona", latitude: 41.4145, longitude: 2.1527 }
  ]},

  { city: "Madrid", places: [
    { name: "Royal Palace of Madrid", category: "architecture", address: "Calle de Bailén, s/n, 28071 Madrid", latitude: 40.4179, longitude: -3.7110 },
    { name: "Retiro Park", category: "nature", address: "Plaza de la Independencia, 28001 Madrid", latitude: 40.4154, longitude: -3.6846 }
  ]},

  { city: "Seville", places: [
    { name: "Alcázar of Seville", category: "history", address: "Plaza del Triunfo, s/n, 41004 Sevilla", latitude: 37.3826, longitude: -5.9902 },
    { name: "Plaza de España", category: "architecture", address: "Parque de María Luisa, 41013 Sevilla", latitude: 37.3775, longitude: -5.9862 }
  ]},

  { city: "Amsterdam", places: [
    { name: "Rijksmuseum", category: "art", address: "Museumstraat 1, 1071 XX Amsterdam", latitude: 52.3600, longitude: 4.8852 },
    { name: "Vondelpark", category: "nature", address: "Vondelpark, Amsterdam", latitude: 52.3584, longitude: 4.8680 }
  ]},

  { city: "Brugge", places: [
    { name: "Belfry of Bruges", category: "history", address: "Markt, 8000 Brugge", latitude: 51.2082, longitude: 3.2240 },
    { name: "Minnewater", category: "nature", address: "Minnewaterpark, 8000 Brugge", latitude: 51.2094, longitude: 3.2228 }
  ]},

  { city: "Antwerp", places: [
    { name: "Cathedral of Our Lady", category: "architecture", address: "Groenplaats, 2000 Antwerpen", latitude: 51.2001, longitude: 4.3983 },
    { name: "Antwerp Zoo", category: "nature", address: "Koningin Astridplein 26, 2018 Antwerpen", latitude: 51.2175, longitude: 4.4194 }
  ]},
  {
    city: "Vienne",
    places: [
      { name: "Stephansdom", category: "architecture", address: "Stephansplatz 1, 1010 Wien, Austria", latitude: 48.206389, longitude: 16.370501 },
      { name: "Prater", category: "nature", address: "Prater, 1020 Wien, Austria", latitude: 48.211389, longitude: 16.409167 },
      { name: "Hofburg", category: "history", address: "Michaelerkuppel, 1010 Wien, Austria", latitude: 48.206098, longitude: 16.370594 }
    ]
  },
  {
    city: "Albania",
    places: [
      { name: "Butrint", category: "history", address: "Butrint, Vlorë, Albania", latitude: 39.747364, longitude: 20.021695 },
      { name: "Dajti Mountain", category: "nature", address: "Dajti, Tirana, Albania", latitude: 41.327500, longitude: 19.826111 },
      { name: "Tirana Skanderbeg Square", category: "art", address: "Sheshi Skënderbej, Tirana, Albania", latitude: 41.327555, longitude: 19.818893 }
    ]
  },
  {
    city: "Croatie",
    places: [
      { name: "Diocletian's Palace", category: "history", address: "Split, Croatia", latitude: 43.507273, longitude: 16.444891 },
      { name: "Plitvice Lakes", category: "nature", address: "Plitvice Lakes National Park, Croatia", latitude: 44.865209, longitude: 15.582259 },
      { name: "Dubrovnik Old Town", category: "art", address: "Dubrovnik, Croatia", latitude: 42.640230, longitude: 18.114970 }
    ]
  },
  {
    city: "Roumanie",
    places: [
      { name: "Peleș Castle", category: "architecture", address: "Peleș Castle, Sinaia, Romania", latitude: 45.366696, longitude: 25.544278 },
      { name: "Bran Castle", category: "history", address: "Bran, Romania", latitude: 45.515388, longitude: 25.367713 },
      { name: "Transfăgărășan Highway", category: "nature", address: "Transfăgărășan, Romania", latitude: 45.637674, longitude: 24.635748 }
    ]
  },
  {
    city: "Moldavie",
    places: [
      { name: "Orheiul Vechi", category: "history", address: "Orhei, Moldova", latitude: 47.341453, longitude: 28.983661 },
      { name: "Cricova Winery", category: "art", address: "Cricova, Moldova", latitude: 47.133136, longitude: 28.888066 },
      { name: "Stefan Cel Mare Park", category: "nature", address: "Chișinău, Moldova", latitude: 47.011358, longitude: 28.857120 }
    ]
  },
  {
    city: "Istanbul",
    places: [
      { name: "Hagia Sophia", category: "history", address: "Sultanahmet, Istanbul, Turkey", latitude: 41.008583, longitude: 28.979016 },
      { name: "Blue Mosque", category: "architecture", address: "Sultanahmet, Istanbul, Turkey", latitude: 41.005560, longitude: 28.976800 },
      { name: "Bosphorus Bridge", category: "nature", address: "Istanbul, Turkey", latitude: 41.078825, longitude: 29.029896 }
    ]
  },
  {
    city: "Albanie",
    places: [
      { name: "Tirana", category: "history", address: "Tirana, Albania", latitude: 41.3275, longitude: 19.8189 },
      { name: "Berat", category: "architecture", address: "Berat, Albania", latitude: 40.7072, longitude: 19.9543 },
      { name: "Gjirokastër", category: "nature", address: "Gjirokastër, Albania", latitude: 40.0835, longitude: 20.1418 }
    ]
  },
  {
    city: "Oran",
    places: [
      { name: "Fort Santa Cruz", category: "history", address: "Oran, Algeria", latitude: 35.695, longitude: -0.625 },
      { name: "La Corniche", category: "nature", address: "Oran, Algeria", latitude: 35.686, longitude: -0.612 },
      { name: "Place du 1er Novembre", category: "art", address: "Oran, Algeria", latitude: 35.693, longitude: -0.630 }
    ]
  },
  {
    city: "Oujda",
    places: [
      { name: "Medina of Oujda", category: "history", address: "Oujda, Morocco", latitude: 34.681, longitude: -1.910 },
      { name: "Parc Lalla Meryem", category: "nature", address: "Oujda, Morocco", latitude: 34.683, longitude: -1.911 },
      { name: "Palais de la Wilaya", category: "architecture", address: "Oujda, Morocco", latitude: 34.685, longitude: -1.913 }
    ]
  },
  {
    city: "Ouargla",
    places: [
      { name: "Kasbah of Ouargla", category: "history", address: "Ouargla, Algeria", latitude: 31.950, longitude: 5.328 },
      { name: "Oasis of Ouargla", category: "nature", address: "Ouargla, Algeria", latitude: 31.954, longitude: 5.331 },
      { name: "La Place de la Mairie", category: "art", address: "Ouargla, Algeria", latitude: 31.952, longitude: 5.334 }
    ]
  },
  {
    city: "Adrar",
    places: [
      { name: "Tassili n'Ajjer National Park", category: "nature", address: "Adrar, Algeria", latitude: 26.566, longitude: 2.788 },
      { name: "Kasbah of Adrar", category: "history", address: "Adrar, Algeria", latitude: 27.876, longitude: -0.293 },
      { name: "La Gare Routière", category: "architecture", address: "Adrar, Algeria", latitude: 27.876, longitude: -0.295 }
    ]
  },
  {
    city: "Tripoli",
    places: [
      { name: "Red Castle", category: "history", address: "Tripoli, Libya", latitude: 32.882, longitude: 13.191 },
      { name: "Al-Mina", category: "nature", address: "Tripoli, Libya", latitude: 32.889, longitude: 13.200 },
      { name: "Martyrs' Square", category: "art", address: "Tripoli, Libya", latitude: 32.882, longitude: 13.189 }
    ]
  },
  {
    city: "Mauritanie",
    places: [
      { name: "Chinguetti", category: "history", address: "Chinguetti, Mauritania", latitude: 20.467, longitude: -12.663 },
      { name: "Parc National du Banc d'Arguin", category: "nature", address: "Mauritania", latitude: 19.000, longitude: -16.000 },
      { name: "Nouakchott Beach", category: "nature", address: "Nouakchott, Mauritania", latitude: 18.085, longitude: -15.978 }
    ]
  },
  {
    city: "Mali",
    places: [
      { name: "Timbuktu", category: "history", address: "Timbuktu, Mali", latitude: 16.766, longitude: -3.002 },
      { name: "Dogon Country", category: "nature", address: "Mali", latitude: 14.372, longitude: -4.555 },
      { name: "Bamako Grand Mosque", category: "architecture", address: "Bamako, Mali", latitude: 12.639, longitude: -8.002 }
    ]
  },
  {
    city: "Liberia",
    places: [
      { name: "Providence Island", category: "history", address: "Monrovia, Liberia", latitude: 6.307, longitude: -9.429 },
      { name: "Sapo National Park", category: "nature", address: "Liberia", latitude: 5.820, longitude: -8.700 },
      { name: "Liberia National Museum", category: "art", address: "Monrovia, Liberia", latitude: 6.313, longitude: -9.429 }
    ]
  },
  {
    city: "Ghana",
    places: [
      { name: "Cape Coast Castle", category: "history", address: "Cape Coast, Ghana", latitude: 5.105, longitude: -1.247 },
      { name: "Kakum National Park", category: "nature", address: "Ghana", latitude: 5.397, longitude: -1.417 },
      { name: "Kwame Nkrumah Memorial Park", category: "art", address: "Accra, Ghana", latitude: 5.552, longitude: -0.196 }
    ]
  },
  {
    city: "Côte d'Ivoire",
    places: [
      { name: "Basilica of Our Lady of Peace", category: "architecture", address: "Yamoussoukro, Ivory Coast", latitude: 6.433, longitude: -5.292 },
      { name: "Taï National Park", category: "nature", address: "Ivory Coast", latitude: 5.930, longitude: -7.440 },
      { name: "The National Museum of Abidjan", category: "art", address: "Abidjan, Ivory Coast", latitude: 5.335, longitude: -4.031 }
    ]
  },
  {
    city: "Togo",
    places: [
      { name: "Lomé Beach", category: "nature", address: "Lomé, Togo", latitude: 6.137, longitude: 1.212 },
      { name: "The National Museum of Togo", category: "art", address: "Lomé, Togo", latitude: 6.131, longitude: 1.215 },
      { name: "Fétiche Market", category: "history", address: "Lomé, Togo", latitude: 6.138, longitude: 1.217 }
    ]
  },
  {
    city: "San Antonio",
    places: [
      { name: "The Alamo", category: "history", address: "San Antonio, Mexico", latitude: 29.425, longitude: -98.486 },
      { name: "San Antonio River Walk", category: "nature", address: "San Antonio, Mexico", latitude: 29.423, longitude: -98.487 },
      { name: "Tower Life Building", category: "architecture", address: "San Antonio, Mexico", latitude: 29.423, longitude: -98.490 }
    ]
  },
  {
    city: "Mexico",
    places: [
      { name: "Teotihuacan", category: "history", address: "Mexico City, Mexico", latitude: 19.692, longitude: -98.843 },
      { name: "Chapultepec Park", category: "nature", address: "Mexico City, Mexico", latitude: 19.423, longitude: -99.186 },
      { name: "Palacio de Bellas Artes", category: "art", address: "Mexico City, Mexico", latitude: 19.436, longitude: -99.142 }
    ]
  },
  {
    city: "Guatemala",
    places: [
      { name: "Tikal", category: "history", address: "Petén, Guatemala", latitude: 17.221, longitude: -89.623 },
      { name: "Lake Atitlán", category: "nature", address: "Atitlán, Guatemala", latitude: 14.684, longitude: -91.152 },
      { name: "National Palace of Culture", category: "architecture", address: "Guatemala City, Guatemala", latitude: 14.634, longitude: -90.506 }
    ]
  },
  {
    city: "Cancun",
    places: [
      { name: "Chichen Itza", category: "history", address: "Cancun, Mexico", latitude: 20.684, longitude: -88.567 },
      { name: "Isla Mujeres", category: "nature", address: "Cancun, Mexico", latitude: 21.226, longitude: -86.730 },
      { name: "Coco Bongo", category: "art", address: "Cancun, Mexico", latitude: 21.168, longitude: -86.848 }
    ]
  },
  {
    city: "Cuba",
    places: [
      { name: "Old Havana", category: "history", address: "Havana, Cuba", latitude: 23.133, longitude: -82.383 },
      { name: "Varadero Beach", category: "nature", address: "Varadero, Cuba", latitude: 23.147, longitude: -81.251 },
      { name: "National Museum of Fine Arts", category: "art", address: "Havana, Cuba", latitude: 23.141, longitude: -82.357 }
    ]
  },
  {
    city: "Nicaragua",
    places: [
      { name: "Granada", category: "history", address: "Granada, Nicaragua", latitude: 11.933, longitude: -85.966 },
      { name: "Masaya Volcano", category: "nature", address: "Masaya, Nicaragua", latitude: 11.977, longitude: -86.125 },
      { name: "Museo Nacional", category: "art", address: "Managua, Nicaragua", latitude: 12.130, longitude: -86.251 }
    ]
  },
  {
    city: "Costa Rica",
    places: [
      { name: "Arenal Volcano", category: "nature", address: "Arenal, Costa Rica", latitude: 10.463, longitude: -84.703 },
      { name: "Manuel Antonio National Park", category: "nature", address: "Quepos, Costa Rica", latitude: 9.379, longitude: -84.132 },
      { name: "Museo Nacional", category: "art", address: "San José, Costa Rica", latitude: 9.933, longitude: -84.080 }
    ]
  },
  {
    city: "Panama",
    places: [
      { name: "Panama Canal", category: "history", address: "Panama City, Panama", latitude: 8.983, longitude: -79.520 },
      { name: "San Blas Islands", category: "nature", address: "Panama, Panama", latitude: 9.518, longitude: -78.972 },
      { name: "Casco Viejo", category: "art", address: "Panama City, Panama", latitude: 8.980, longitude: -79.529 }
    ]
  },
  {
    city: "Medellin",
    places: [
      { name: "Plaza Botero", category: "art", address: "Medellín, Colombia", latitude: 6.251, longitude: -75.563 },
      { name: "Arví Park", category: "nature", address: "Medellín, Colombia", latitude: 6.186, longitude: -75.495 },
      { name: "Pueblito Paisa", category: "history", address: "Medellín, Colombia", latitude: 6.241, longitude: -75.570 }
    ]
  },
  {
    city: "Cartagena",
    places: [
      { name: "Walled City of Cartagena", category: "history", address: "Cartagena, Colombia", latitude: 10.423, longitude: -75.514 },
      { name: "Castillo San Felipe de Barajas", category: "history", address: "Cartagena, Colombia", latitude: 10.419, longitude: -75.552 },
      { name: "Plaza Santo Domingo", category: "art", address: "Cartagena, Colombia", latitude: 10.424, longitude: -75.518 }
    ]
  },
  {
    city: "Peru",
    places: [
      { name: "Machu Picchu", category: "history", address: "Cusco, Peru", latitude: -13.163, longitude: -72.545 },
      { name: "Sacred Valley", category: "nature", address: "Cusco, Peru", latitude: -13.343, longitude: -72.027 },
      { name: "Museo Larco", category: "art", address: "Lima, Peru", latitude: -12.043, longitude: -77.025 }
    ]
  },
  {
    city: "Guyana",
    places: [
      { name: "Kaieteur Falls", category: "nature", address: "Kaieteur National Park, Guyana", latitude: 5.177, longitude: -59.467 },
      { name: "Stabroek Market", category: "history", address: "Georgetown, Guyana", latitude: 6.804, longitude: -58.155 },
      { name: "Guyana National Museum", category: "art", address: "Georgetown, Guyana", latitude: 6.804, longitude: -58.155 }
    ]
  },
  {
    city: "Venezuela",
    places: [
      { name: "Angel Falls", category: "nature", address: "Venezuela", latitude: 5.967, longitude: -62.536 },
      { name: "Caracas Cathedral", category: "history", address: "Caracas, Venezuela", latitude: 10.497, longitude: -66.877 },
      { name: "Museo de Arte Contemporáneo", category: "art", address: "Caracas, Venezuela", latitude: 10.490, longitude: -66.898 }
    ]
  },
  {
    city: "Suriname",
    places: [
      { name: "St. Peter and Paul Cathedral", category: "history", address: "Paramaribo, Suriname", latitude: 5.866, longitude: -55.167 },
      { name: "Brownsberg Nature Park", category: "nature", address: "Suriname", latitude: 5.551, longitude: -55.365 },
      { name: "Fort Zeelandia", category: "history", address: "Paramaribo, Suriname", latitude: 5.866, longitude: -55.167 }
    ]
  },
  {
    city: "Cuzco",
    places: [
      { name: "Sacsayhuamán", category: "history", address: "Cuzco, Peru", latitude: -13.522, longitude: -71.981 },
      { name: "Qorikancha", category: "history", address: "Cuzco, Peru", latitude: -13.518, longitude: -71.978 },
      { name: "Plaza de Armas", category: "art", address: "Cuzco, Peru", latitude: -13.518, longitude: -71.978 }
    ]
  },
  {
    city: "Bolivia",
    places: [
      { name: "Salar de Uyuni", category: "nature", address: "Uyuni, Bolivia", latitude: -20.133, longitude: -67.489 },
      { name: "Tiwanaku", category: "history", address: "Tiwanaku, Bolivia", latitude: -16.552, longitude: -68.576 },
      { name: "Museo Nacional de Arte", category: "art", address: "La Paz, Bolivia", latitude: -16.500, longitude: -68.119 }
    ]
  },
  {
    city: "Paraguay",
    places: [
      { name: "Itaipu Dam", category: "architecture", address: "Hernandarias, Paraguay", latitude: -25.394, longitude: -54.615 },
      { name: "National Pantheon of the Heroes", category: "history", address: "Asunción, Paraguay", latitude: -25.283, longitude: -57.646 },
      { name: "Ñu Guasu Park", category: "nature", address: "Asunción, Paraguay", latitude: -25.314, longitude: -57.651 }
    ]
  },
  {
    city: "Alexandria",
    places: [
      { name: "Alexandria Library", category: "history", address: "Alexandria, Egypt", latitude: 31.2156, longitude: 29.9553 },
      { name: "Fort Qaitbey", category: "history", address: "Alexandria, Egypt", latitude: 31.2152, longitude: 29.8857 },
      { name: "Montaza Palace", category: "architecture", address: "Alexandria, Egypt", latitude: 31.2150, longitude: 29.8831 }
    ]
  },
  {
    city: "Port Said",
    places: [
      { name: "Port Said Lighthouse", category: "history", address: "Port Said, Egypt", latitude: 31.2656, longitude: 32.3037 },
      { name: "Suez Canal", category: "history", address: "Port Said, Egypt", latitude: 31.2550, longitude: 32.3020 },
      { name: "Port Said Military Museum", category: "history", address: "Port Said, Egypt", latitude: 31.2635, longitude: 32.3027 }
    ]
  },
  {
    city: "Hurghada",
    places: [
      { name: "Hurghada Marina", category: "nature", address: "Hurghada, Egypt", latitude: 27.2570, longitude: 33.8420 },
      { name: "Giftun Islands", category: "nature", address: "Hurghada, Egypt", latitude: 27.1875, longitude: 33.8111 },
      { name: "Sand City Hurghada", category: "art", address: "Hurghada, Egypt", latitude: 27.1885, longitude: 33.8220 }
    ]
  },
  {
    city: "Benghazi",
    places: [
      { name: "Benghazi Archaeological Museum", category: "history", address: "Benghazi, Libya", latitude: 32.1181, longitude: 20.0660 },
      { name: "Tobruk War Cemetery", category: "history", address: "Tobruk, Libya", latitude: 32.083, longitude: 23.981 },
      { name: "Café of the City", category: "nature", address: "Benghazi, Libya", latitude: 32.1150, longitude: 20.0780 }
    ]
  },
  {
    city: "Niger",
    places: [
      { name: "Air and Ténéré National Nature Reserve", category: "nature", address: "Niger", latitude: 17.000, longitude: 11.000 },
      { name: "National Museum of Niger", category: "history", address: "Niamey, Niger", latitude: 13.5120, longitude: 2.1124 },
      { name: "Zinder Sultan's Palace", category: "history", address: "Zinder, Niger", latitude: 13.5074, longitude: 8.0013 }
    ]
  },
  {
    city: "Chad",
    places: [
      { name: "Zakouma National Park", category: "nature", address: "Chad", latitude: 11.0130, longitude: 20.5063 },
      { name: "Chad National Museum", category: "history", address: "N'Djamena, Chad", latitude: 12.1315, longitude: 15.0493 },
      { name: "Bahr el-Ghazal", category: "nature", address: "Chad", latitude: 13.7631, longitude: 17.7017 }
    ]
  },
  {
    city: "Kenya",
    places: [
      { name: "Nairobi National Park", category: "nature", address: "Nairobi, Kenya", latitude: -1.3733, longitude: 36.9261 },
      { name: "Giraffe Centre", category: "nature", address: "Nairobi, Kenya", latitude: -1.2881, longitude: 36.7905 },
      { name: "National Museum of Kenya", category: "history", address: "Nairobi, Kenya", latitude: -1.2921, longitude: 36.8219 }
    ]
  },
  {
    city: "Uganda",
    places: [
      { name: "Bwindi Impenetrable National Park", category: "nature", address: "Kigezi, Uganda", latitude: -1.0702, longitude: 29.6347 },
      { name: "Murchison Falls", category: "nature", address: "Murchison Falls, Uganda", latitude: 2.2385, longitude: 31.7616 },
      { name: "Uganda Museum", category: "history", address: "Kampala, Uganda", latitude: 0.3151, longitude: 32.5816 }
    ]
  },
  {
    city: "Djibouti",
    places: [
      { name: "Lake Assal", category: "nature", address: "Djibouti", latitude: 11.5500, longitude: 42.3153 },
      { name: "Djibouti National Museum", category: "history", address: "Djibouti City, Djibouti", latitude: 11.5910, longitude: 43.1493 },
      { name: "Day Forest National Park", category: "nature", address: "Djibouti", latitude: 11.9114, longitude: 43.1587 }
    ]
  }
]

new_locations = [
  {
    city: "Paris",
    places: [
      { name: "Tour Eiffel", category: "architecture", address: "Champ de Mars, 5 Av. Anatole France, 75007 Paris, France", latitude: 48.858844, longitude: 2.294351 },
      { name: "Montmartre", category: "art", address: "Montmartre, 75018 Paris, France", latitude: 48.886705, longitude: 2.343104 },
      { name: "Le Marais", category: "history", address: "Le Marais, 75004 Paris, France", latitude: 48.858093, longitude: 2.362302 }
    ]
  },
  {
    city: "Marseille",
    places: [
      { name: "Vieux-Port", category: "history", address: "Vieux-Port, 13001 Marseille, France", latitude: 43.295101, longitude: 5.374348 },
      { name: "Notre-Dame de la Garde", category: "architecture", address: "Rue Fort du Sanctuaire, 13281 Marseille, France", latitude: 43.292435, longitude: 5.363121 },
      { name: "Calanques", category: "nature", address: "Parc national des Calanques, Marseille, France", latitude: 43.212307, longitude: 5.430852 }
    ]
  },
  {
    city: "Bruxelles",
    places: [
      { name: "Grand-Place", category: "history", address: "Grand-Place, 1000 Bruxelles, Belgium", latitude: 50.846557, longitude: 4.352474 },
      { name: "Atomium", category: "architecture", address: "Square de l'Atomium, 1020 Bruxelles, Belgium", latitude: 50.894941, longitude: 4.341545 },
      { name: "Parc du Cinquantenaire", category: "nature", address: "Parc du Cinquantenaire, 1000 Bruxelles, Belgium", latitude: 50.841925, longitude: 4.391672 }
    ]
  },
  {
    city: "Grenoble",
    places: [
      { name: "Bastille", category: "history", address: "Fort de la Bastille, Grenoble, France", latitude: 45.199202, longitude: 5.728197 },
      { name: "Place Victor Hugo", category: "art", address: "Place Victor Hugo, 38000 Grenoble, France", latitude: 45.188626, longitude: 5.724757 },
      { name: "Musée de Grenoble", category: "architecture", address: "5 Pl. de Lavalette, 38000 Grenoble, France", latitude: 45.194443, longitude: 5.732751 }
    ]
  },
  {
    city: "Lyon",
    places: [
      { name: "Basilique Notre-Dame de Fourvière", category: "architecture", address: "8 Pl. de Fourvière, 69005 Lyon, France", latitude: 45.762214, longitude: 4.822306 },
      { name: "Parc de la Tête d'Or", category: "nature", address: "Parc de la Tête d'Or, 69006 Lyon, France", latitude: 45.779903, longitude: 4.859234 },
      { name: "Vieux Lyon", category: "history", address: "Vieux Lyon, 69005 Lyon, France", latitude: 45.762413, longitude: 4.827083 }
    ]
  },
  {
    city: "Bordeaux",
    places: [
      { name: "Place de la Bourse", category: "architecture", address: "Pl. de la Bourse, 33000 Bordeaux, France", latitude: 44.841314, longitude: -0.569422 },
      { name: "Quais de la Garonne", category: "nature", address: "Quais de la Garonne, Bordeaux, France", latitude: 44.838275, longitude: -0.567340 },
      { name: "Rue Sainte-Catherine", category: "art", address: "Rue Sainte-Catherine, 33000 Bordeaux, France", latitude: 44.837788, longitude: -0.577328 }
    ]
  },
  {
    city: "Liège",
    places: [
      { name: "Montagne de Bueren", category: "history", address: "Montagne de Bueren, 4000 Liège, Belgium", latitude: 50.647779, longitude: 5.573661 },
      { name: "Parc de la Boverie", category: "nature", address: "Parc de la Boverie, 4020 Liège, Belgium", latitude: 50.632518, longitude: 5.580692 },
      { name: "Carré", category: "art", address: "Carré, 4000 Liège, Belgium", latitude: 50.640281, longitude: 5.573042 }
    ]
  },
  {
    city: "Luxembourg",
    places: [
      { name: "Grund", category: "history", address: "Grund, Luxembourg City, Luxembourg", latitude: 49.611676, longitude: 6.133617 },
      { name: "Place Guillaume II", category: "art", address: "Place Guillaume II, 1648 Luxembourg City, Luxembourg", latitude: 49.611260, longitude: 6.129859 },
      { name: "Parc de Merl", category: "nature", address: "Parc de Merl, Luxembourg City, Luxembourg", latitude: 49.602455, longitude: 6.115176 }
    ]
  },
  {
    city: "Quebec",
    places: [
      { name: "Château Frontenac", category: "architecture", address: "1 Rue des Carrières, Québec, QC, Canada", latitude: 46.811056, longitude: -71.206524 },
      { name: "Plaines d'Abraham", category: "nature", address: "835 Av. Wilfrid-Laurier, Québec, QC, Canada", latitude: 46.799158, longitude: -71.222602 },
      { name: "Vieux-Québec", category: "history", address: "Vieux-Québec, Québec, QC, Canada", latitude: 46.813878, longitude: -71.207981 }
    ]
  },
  {
    city: "Rabat",
    places: [
      { name: "Kasbah des Oudayas", category: "history", address: "Kasbah des Oudayas, Rabat, Morocco", latitude: 34.019606, longitude: -6.834439 },
      { name: "Tour Hassan", category: "architecture", address: "Tour Hassan, Rabat, Morocco", latitude: 34.022562, longitude: -6.836121 },
      { name: "Jardin d'Essais Botaniques", category: "nature", address: "Av. de la Victoire, Rabat, Morocco", latitude: 34.010707, longitude: -6.832441 }
    ]
  },
  {
    city: "Marrakech",
    places: [
      { name: "Jemaa el-Fna", category: "fantasy", address: "Jemaa el-Fna, Marrakech, Morocco", latitude: 31.625825, longitude: -7.989156 },
      { name: "Jardin Majorelle", category: "nature", address: "Rue Yves Saint Laurent, Marrakech, Morocco", latitude: 31.641626, longitude: -8.002666 },
      { name: "Medina", category: "history", address: "Medina, Marrakech, Morocco", latitude: 31.629472, longitude: -7.988045 }
    ]
  },
  {
    city: "Casablanca",
    places: [
      { name: "Mosquée Hassan II", category: "architecture", address: "Boulevard Sidi Mohamed Ben Abdallah, Casablanca, Morocco", latitude: 33.608630, longitude: -7.632446 },
      { name: "Corniche Ain Diab", category: "nature", address: "Corniche Ain Diab, Casablanca, Morocco", latitude: 33.594265, longitude: -7.659432 },
      { name: "Ancienne Medina", category: "history", address: "Ancienne Medina, Casablanca, Morocco", latitude: 33.598796, longitude: -7.613377 }
    ]
  }
]




# Création des capsules
locations.each do |location|
  location[:places].each do |place|
    Capsule.create!(
      title: "#{place[:name]} - #{location[:city]}",
      teasing: "Discover the #{place[:category]} of #{place[:name]} in #{location[:city]}.",
      category: place[:category],
      address: place[:address],
      latitude: place[:latitude],
      longitude: place[:longitude],
      audio_url: audio_url,
      user: default_user
    )
  end
end

new_locations.each do |location|
  location[:places].each do |place|
    Capsule.create!(
      title: "#{place[:name]} - #{location[:city]}",
      teasing: "Discover the #{place[:category]} of #{place[:name]} in #{location[:city]}.",
      category: place[:category],
      address: place[:address],
      latitude: place[:latitude],
      longitude: place[:longitude],
      audio_url: new_audio_url, # Utilisation du second audio_url pour les nouvelles capsules
      user: default_user
    )
  end
end

Capsule.create!(
  title: "Montagne d'Aisemont - Wavre",
  teasing: "Discover the history and nature of Montagne d'Aisemont in Wavre.",
  category: "history",  # Choisi une catégorie appropriée, tu peux la modifier si nécessaire
  address: "Montagne d'Aisemont 55, 1300 Wavre, Belgique",
  latitude: 50.7179,  # Latitude estimée pour Wavre
  longitude: 4.6094,  # Longitude estimée pour Wavre
  audio_url: new_audio_url, # Utilisation du second audio_url
  user: default_user
)
