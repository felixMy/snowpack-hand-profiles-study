
"""
Module provides functions for preprocessing CAAML snow profiles.
"""
import xml.etree.ElementTree as ET
import numpy as np
import defusedxml.ElementTree as et # Safe version for parsing untrusted XML data

# XML Namespaces
CAAML_URI = "http://caaml.org/Schemas/SnowProfileIACS/v6.0.3"
CAAML_NS = "{" + CAAML_URI + "}"
ET.register_namespace('caaml', CAAML_URI)
GML_URI = "http://www.opengis.net/gml"
GML_NS = "{" + GML_URI + "}"
ET.register_namespace('gml', GML_URI)

grain_forms = ["PP", "PPgp", "DF", "SH", "DH", "FC", "FCxr", "RG", "MF", "MFcr", "IF"]
hardness = ["F-", "F+", "4F", "4F+", "1F", "1F+", "P", "P+", "K", "K+", "I"]
wetness = ["D", "D-M", "M", "W", "W-M", "W-D", "M-W"]


def add_monti_density(input_profile_path: str, output_profile_path: str, remove_observed_density=False) -> str:
    """
    Adds an estimated density of the snow layers based on the grain type and hardness parameterization alla Monti (2014) to the snow profile.
    If the snow profile already contains a density profile, nothing is changed (unless remove_observed_density is True).
    
    Parameters:
    - input_profile_path: str - The path to the input CAAML file containing the snow profile data.
    - output_profile_path: str - The path of the output CAAML file to be created.
    - remove_observed_density: bool - If True, removes the observed density from the snow profile and replaces it with the estimated density.

    Returns:
    - Path of the resulting CAAML file.
    """
    # Parse the XML file
    tree = et.parse(input_profile_path)
    snow_profile_measurements = tree.getroot().find(f"{CAAML_NS}snowProfileResultsOf/{CAAML_NS}SnowProfileMeasurements")

    if remove_observed_density and snow_profile_measurements.find(f"{CAAML_NS}densityProfile") is not None:
        # If density is already provided, remove it
        snow_profile_measurements.remove(snow_profile_measurements.find(f"{CAAML_NS}densityProfile"))

    # If no density profile exists, add an estimated density profile 
    if snow_profile_measurements.find(f"{CAAML_NS}densityProfile") is None:

        # Add density section
        density_profile = ET.Element(CAAML_NS + 'densityProfile')
        density_profile_meta = ET.Element(CAAML_NS + 'densityMetaData')
        method_of_meas = ET.Element(CAAML_NS + 'methodOfMeas')
        method_of_meas.text = "Monti et al. (2014)"
        density_profile_meta.append(method_of_meas)
        density_profile.append(density_profile_meta)
        snow_profile_measurements.append(density_profile)
        
        # Iterate over all layers and compute the density estimate and create the density profile
        for layer in snow_profile_measurements.findall(f"{CAAML_NS}stratProfile/{CAAML_NS}Layer"):
            # Parse relevant layer data
            depth_top = layer.find(f"{CAAML_NS}depthTop")
            thickness = layer.find(f"{CAAML_NS}thickness")
            grain_form_primary = layer.find(f"{CAAML_NS}grainFormPrimary").text
            grain_form_secondary = layer.find(f"{CAAML_NS}grainFormSecondary").text if layer.find(f"{CAAML_NS}grainFormSecondary") is not None else None
            hardness = layer.find(f"{CAAML_NS}hardness").text

            # Compute the density estimate and add it to the density profile
            density_layer = ET.Element(CAAML_NS + 'Layer')
            density = ET.Element(CAAML_NS + 'density', uom='kgm-3')
            density.text = str(_compute_monti_density(grain_form_primary, grain_form_secondary, hardness))
            density_layer.extend([depth_top, thickness, density])
            density_profile.append(density_layer)
    
    # Write the new file
    ET.indent(tree)
    tree.write(output_profile_path, xml_declaration=True, encoding='utf-8')
    return output_profile_path


def _compute_monti_density(primary_form: str, secondary_form: str, observed_hardness: str) -> float:
    """Compute the Monti density of the snow profile based on the grain type and the estimated desitiy in the hand profile."""
    # TODO: Use secondary form for more accurate density estimation
    ice = 910
    sho = 50
    mfc = 520

    # Density by grain form and hand hardness
    # Values based on https://gitlab.com/avalanche-warning/models/snowpack/snowpacktools/-/blob/main/snowpacktools/caaml/caamlv6_processor.py?ref_type=heads
    density_by_grain_form = {
        'PP':   {'F': 48,  'F-4F': 96,  '4F': 144, '4F-1F': 144, '1F': np.nan, '1F-P': np.nan, 'P': np.nan, 'P-K': np.nan, 'K': np.nan, 'K-I': np.nan, 'I': np.nan}, 
        'PPgp': {'F': 48,  'F-4F': 96,  '4F': 144, '4F-1F': 144, '1F': np.nan, '1F-P': np.nan, 'P': np.nan, 'P-K': np.nan, 'K': np.nan, 'K-I': np.nan, 'I': np.nan}, 
        'DF':   {'F': 71,  'F-4F': 142, '4F': 232, '4F-1F': 250, '1F': 269,    '1F-P': 269,    'P': np.nan, 'P-K': np.nan, 'K': np.nan, 'K-I': np.nan, 'I': np.nan}, 
        'SH':   {'F': sho, 'F-4F': sho, '4F': sho, '4F-1F': sho, '1F': sho,    '1F-P': sho,    'P': sho,    'P-K': sho,    'K': sho,    'K-I': sho,    'I': sho}, 
        'DH':   {'F': 96,  'F-4F': 192, '4F': 307, '4F-1F': 325, '1F': 345,    '1F-P': np.nan, 'P': np.nan, 'P-K': np.nan, 'K': np.nan, 'K-I': np.nan, 'I': np.nan}, 
        'FC':   {'F': 82,  'F-4F': 164, '4F': 272, '4F-1F': 295, '1F': 347,    '1F-P': 373,    'P': 440,    'P-K': 479,    'K': 519,    'K-I': np.nan, 'I': np.nan}, 
        'FCxr': {'F': 86,  'F-4F': 172, '4F': 282, '4F-1F': 304, '1F': 350,    '1F-P': 373,    'P': 426,    'P-K': 455,    'K': 485,    'K-I': np.nan, 'I': np.nan}, 
        'RG':   {'F': 63,  'F-4F': 126, '4F': 219, '4F-1F': 248, '1F': 308,    '1F-P': 338,    'P': 394,    'P-K': 418,    'K': 444,    'K-I': np.nan, 'I': np.nan}, 
        'MF':   {'F': 73,  'F-4F': 146, '4F': 248, '4F-1F': 283, '1F': 348,    '1F-P': 377,    'P': 518,    'P-K': 629,    'K': 740,    'K-I': np.nan, 'I': np.nan}, 
        'MFcr': {'F': mfc, 'F-4F': mfc, '4F': mfc, '4F-1F': mfc, '1F': mfc,    '1F-P': mfc,    'P': mfc,    'P-K': mfc,    'K': mfc,    'K-I': mfc,    'I': mfc}, 
        'IF':   {'F': ice, 'F-4F': ice, '4F': ice, '4F-1F': ice, '1F': ice,    '1F-P': ice,    'P': ice,    'P-K': ice,    'K': ice,    'K-I': ice,    'I': ice}
    }

    try:    
        return density_by_grain_form[primary_form][observed_hardness]
    except KeyError as e:
        print(f"Primary Form {primary_form} or hardness {observed_hardness} not found supported")
        return np.nan


def create_snow_profile():
    snow_profile = ET.Element('SnowProfile')
    
    location = input("Enter location: ")
    ET.SubElement(snow_profile, 'Location').text = location
    
    observer = input("Enter observer: ")
    ET.SubElement(snow_profile, 'Observer').text = observer
    
    date = input("Enter date (YYYY-MM-DD): ")
    ET.SubElement(snow_profile, 'Date').text = date
    
    current_depth_from_top = 0
    print("Starting from the top of the snowpack...")
    print("Enter layer data (press Enter to skip a field):")
    layer_count = 1
    while True:
        layer = ET.Element('Layer')
        
        depth_top_elem = ET.SubElement(layer, 'depthTop', uom="cm")
        depth_top_elem.text = str(current_depth_from_top)
        
        thickness = input(f"Enter thickness of layer {layer_count} (cm): ")
        thickness_elem = ET.SubElement(layer, 'thickness', uom="cm")
        thickness_elem.text = thickness
        current_depth_from_top += float(thickness)
        
        grain_form_primary = input(f"Enter primary grain form of layer {layer_count} (e.g., R, FC, SH, DH, C, NP): ")
        ET.SubElement(layer, 'grainFormPrimary').text = grain_form_primary
        
        grain_form_secondary = input(f"Enter secondary grain form of layer {layer_count} (e.g., FC, SH, DH, C, RF, IC, MF, MFC, NP): ")
        ET.SubElement(layer, 'grainFormSecondary').text = grain_form_secondary
        
        grain_size_avg = input(f"Enter AVERAGE grain size of layer {layer_count} (mm): ")
        grain_size_max = input(f"Enter MAX grain size of layer {layer_count} (mm): ")
        grain_size = ET.SubElement(layer, 'grainSize', uom="mm")
        components = ET.SubElement(grain_size, 'Components')
        avg_elem = ET.SubElement(components, 'avg')
        avg_elem.text = grain_size_avg
        avg_max_elem = ET.SubElement(components, 'avgMax')
        avg_max_elem.text = grain_size_max
        
        hardness = input(f"Enter hardness of layer {layer_count} (e.g., I, K, P, 4F, 1F, F): ")
        ET.SubElement(layer, 'hardness', uom="").text = hardness
        
        wetness_options = ["D", "M", "D-M", "W", "W-M", "W-D", "M-W"]
        wetness = input(f"Enter wetness of layer {layer_count} ({', '.join(wetness_options)}): ")
        while wetness not in wetness_options:
            print("Invalid option! Choose from:", ", ".join(wetness_options))
            wetness = input(f"Enter wetness of layer {layer_count} ({', '.join(wetness_options)}): ")
        ET.SubElement(layer, 'wetness', uom="").text = wetness
        
        ET.SubElement(snow_profile, 'Layer').append(layer)

        # Ask if there are more layers
        more_layers = input("Add another layer? (y/n): ")
        if more_layers.lower() != "y":
            break
        layer_count += 1
    
    return snow_profile

def prettify_xml(element):
    rough_string = ET.tostring(element, 'utf-8')
    return rough_string.decode('utf-8')

def profile_interactive_form():
    snow_profile = create_snow_profile()
    caaml_xml = prettify_xml(snow_profile)
    
    print("\nGenerated CAAML snow profile:")
    print(caaml_xml)
    #ET.indent(caaml_xml)
    caaml_xml.write("interactive.caaml", xml_declaration=True, encoding='utf-8')

if __name__ == "__main__":
    print("Running snow profile preprocessing module...")
    input_file = ""
    ouput_file = ""
    add_monti_density(input_file, ouput_file)
