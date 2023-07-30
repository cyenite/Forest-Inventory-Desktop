
# Forest Inventory Desktop App

The Forest Inventory Desktop App is a comprehensive tool designed to assist in the management and monitoring of forest land. 

## Description

The Forest Inventory Desktop App aids in the detailed monitoring and management of several forest attributes:

- **Land Cover Change (LCC)**: This feature enables users to monitor and track the changes in forest cover over time. By inputting satellite or aerial imagery at different time intervals, the app can provide analytics about the rate and areas of deforestation or reforestation.

- **Land Use and Land Cover (LULC)**: Users can classify and identify various types of land use (e.g., agriculture, urban, forest) and the corresponding land cover (e.g., tree canopy, grassland). This information is vital in understanding the impact of human activities on forested areas and aids in planning conservation or developmental projects.

- **Tree Specie Distribution**: This feature provides a detailed breakdown of the different tree species in a given forested area. It can help forest managers in maintaining biodiversity and can also be used to identify areas rich in specific commercially valuable species.

- **Growth Monitoring using NDVI Changes**: The app utilizes the Normalized Difference Vegetation Index (NDVI) to monitor and track forest growth over time. By comparing NDVI values from different time frames, users can gauge the health and growth rate of the forest.

## Getting Started

1. **Frontend (Flutter) Setup**:
   - Clone the repository: `git clone https://github.com/cyenite/Forest-Inventory-Desktop.git`
   - Navigate to the flutter directory: `cd Forest-Inventory-Desktop`
   - Run the app: `flutter run`

2. **Backend (Python) Setup**:
   - Navigate to the backend directory: `cd Forest-Inventory-Backend>`
   - Install the required packages: `pip install -r requirements.txt`
   - Start the server: `python server.py`

## Requirements

- Flutter SDK (Version 3.0.0) or higher
- Python (Version 3.x.x)
- Additional Python Libraries:
  - Flask
  - OpenGl

## Technical Backend Details

- **Forest Land Cover Change (FLCC)**: The backend processes sentinel satellite imagery using NDVI change of the selected range to determe the regions with forest cover changes.
  
- **Land Use and Land Cover (LULC)**: Implemented using ML-based land use classification process to classify and identify different land types.
  
- **Tree Specie Distribution**: Uses ML-based land use classification process to detect and classify tree species from imagery data.
  
- **Growth Monitoring using NDVI Changes**: Utilizes the Landsat Bands(4, 5) to derive NDVI values from satellite images and monitor forest growth.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

**MIT**
