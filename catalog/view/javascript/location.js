
let autocomplete;
let isAutocompleteValid = false; // Flag to track if a Google place was successfully selected
let isProgrammaticCityUpdate = false; // Flag to prevent clearing the address input on self-update

// This function dynamically loads the Google Maps script
function loadGoogleMapsScript() {
    if (document.getElementById('googleMapsScript')) {
        if (typeof google === 'object' && typeof google.maps === 'object') {
            window.initAutocomplete();
        }
        return;
    }

    const script = document.createElement('script');
    script.id = 'googleMapsScript';
    // Load the 'places' library for Autocomplete
    script.src = `https://maps.googleapis.com/maps/api/js?key=${GOOGLE_API_KEY}&libraries=places&callback=initAutocomplete`;
    script.async = true;
    document.head.appendChild(script);
}

// This function is called once the Google Maps script is fully loaded
window.initAutocomplete = function () {
    const districtInput = document.getElementById('districtInput');

    // 3. Initialize Google Places Autocomplete
    autocomplete = new google.maps.places.Autocomplete(districtInput, {
        // Restrict results to Turkey
        componentRestrictions: {
            country: ["tr"]
        },
        // Suggest addresses (geocodes)
        types: ['geocode'],
    });

    // 4. Listen for the place selection event
    autocomplete.addListener('place_changed', () => {
        const place = autocomplete.getPlace();
        const saveBtn = document.getElementById('saveLocationBtn');
        const manualDropdown = document.getElementById('manualDistrictDropdown');
        const cityDropdown = document.getElementById('cityDropdown');

        if (place.geometry) {
            isAutocompleteValid = true;
            saveBtn.disabled = false;

            let districtName = null;
            let cityName = null;

            // 1. Extract City (administrative_area_level_1) and District (administrative_area_level_2)
            for (const component of place.address_components) {
                if (component.types.includes('administrative_area_level_1')) {
                    cityName = component.long_name;
                }
                if (component.types.includes('administrative_area_level_2')) {
                    districtName = component.long_name;
                }
            }
            console.log(cityName);

            console.log(districtName);

            // 2. Programmatically update the City Dropdown
            if (cityName && turkishCitiesAndDistricts[cityName]) {
                isProgrammaticCityUpdate = true; // Set flag
                cityDropdown.value = cityName;
                // Dispatch change event to populate the district dropdown
                cityDropdown.dispatchEvent(new Event('change'));
                isProgrammaticCityUpdate = false; // Clear flag
            } else {
                // Clear the city dropdown if city is not one of our hardcoded options
                cityDropdown.value = "";
                cityDropdown.dispatchEvent(new Event('change'));
            }

            // 3. Update the District Dropdown
            const currentCity = cityDropdown.value;
            if (districtName && currentCity && turkishCitiesAndDistricts[currentCity] && turkishCitiesAndDistricts[currentCity].includes(districtName)) {
                manualDropdown.value = districtName;
                // Ensure change listeners run so the save button state updates
                manualDropdown.dispatchEvent(new Event('change'));
            } else {
                // Clear the manual selection if the extracted district isn't found
                manualDropdown.value = "";
                manualDropdown.dispatchEvent(new Event('change'));
            }

            // Ensure the save button correctly reflects the new state after programmatic updates
            // Enable if there's a city and either a valid autocomplete selection or a manual district value
            saveBtn.disabled = !(cityDropdown.value && (isAutocompleteValid || manualDropdown.value));

        } else {
            // If user types and leaves without selecting a valid suggestion
            isAutocompleteValid = false;
            // Re-check if save button should be enabled based on manual selection
            saveBtn.disabled = !(cityDropdown.value && manualDropdown.value);
        }
    });

    console.log("Google Places Autocomplete Initialized.");
}

// --- Geolocation Function (Get User's Real Location Link) ---
function getUserLocationLink() {
    const button = document.getElementById('openLocationModalBtn');
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            (position) => {
                const lat = position.coords.latitude;
                const lng = position.coords.longitude;
                const mapLink = `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`;

                // Update the button to be a link
                button.innerHTML = `📍 View Your Current Location`;
                button.classList.remove('btn-primary');
                button.classList.add('btn-info');
                button.setAttribute('onclick', `window.open('${mapLink}', '_blank')`);
                button.removeAttribute('data-bs-toggle');
                button.removeAttribute('data-bs-target');

                // Create a separate link to open the selection modal
                const container = document.querySelector('.container');
                let modalLink = container.querySelector('.modal-selection-link');
                if (!modalLink) {
                    const p = document.createElement('p');
                    p.className = 'mt-3 modal-selection-link';
                    p.innerHTML = `<a href="#" class="text-secondary" data-bs-toggle="modal" data-bs-target="#locationModal">Or click here to manually select a city/district.</a>`;
                    container.appendChild(p);
                }

            },
            (error) => {
                console.error("Geolocation failed:", error);
                button.innerHTML = `📍 Select Your Location`;
            }, {
            enableHighAccuracy: true,
            timeout: 5000,
            maximumAge: 0
        }
        );
    } else {
        console.log("Geolocation is not supported by this browser.");
    }
}

// --- Populate Manual Dropdown ---
function populateManualDropdown(city) {
    const dropdown = document.getElementById('manualDistrictDropdown');
    dropdown.innerHTML = '<option selected value="">Select a District...</option>'; // Clear existing options

    if (!city || !turkishCitiesAndDistricts[city]) {
        dropdown.disabled = true;
        return;
    }

    dropdown.disabled = false;
    turkishCitiesAndDistricts[city].forEach(district => {
        const option = document.createElement('option');
        option.value = district;
        option.textContent = district;
        dropdown.appendChild(option);
    });
}

// --- Main Logic and Event Listeners ---

document.addEventListener('DOMContentLoaded', () => {
    const cityDropdown = document.getElementById('cityDropdown');
    const districtInput = document.getElementById('districtInput');
    const manualDistrictDropdown = document.getElementById('manualDistrictDropdown');
    const saveLocationBtn = document.getElementById('saveLocationBtn');
    const locationModal = document.getElementById('locationModal');

    // The address input is now enabled by default (removed the disabling line)
    manualDistrictDropdown.disabled = true;
    saveLocationBtn.disabled = true;



    // Load Google Maps script when the modal is about to be shown
    locationModal.addEventListener('show.bs.modal', loadGoogleMapsScript);


    // 5. Handle City Dropdown Change
    cityDropdown.addEventListener('change', () => {
        const city = cityDropdown.value;

        // If the update was not triggered programmatically (i.e., user clicked the dropdown)
        if (!isProgrammaticCityUpdate) {
            // 1. Clear autocomplete input and validation state when user manually changes city
            districtInput.value = '';
            isAutocompleteValid = false;


        }

        // 3. Always update manual district dropdown based on selected city
        populateManualDropdown(city);

        // 4. Clear district dropdown value and re-evaluate save button state
        manualDistrictDropdown.value = '';
        saveLocationBtn.disabled = true;
    });

    // Listener for Manual District Dropdown change to enable save button
    manualDistrictDropdown.addEventListener('change', () => {
        const selectedCity = cityDropdown.value;
        const selectedDistrict = manualDistrictDropdown.value;
        // Enable if city and district are selected, REGARDLESS of autocomplete state
        saveLocationBtn.disabled = !(selectedCity && selectedDistrict);
    });

    // Listener for Autocomplete Input text entry (typing)
    // Typing disables autocomplete validation, but keeps save button enabled if manual is valid.
    districtInput.addEventListener('input', () => {
        isAutocompleteValid = false;
        // Only disable save button if neither autocomplete is valid nor manual is selected
        const selectedCity = cityDropdown.value;
        const selectedDistrict = manualDistrictDropdown.value;
        saveLocationBtn.disabled = !(isAutocompleteValid || (selectedCity && selectedDistrict));
    });


    // 6. Handle Save Button Click
    saveLocationBtn.addEventListener('click', () => {
        const selectedCity = cityDropdown.value;

        let selectedLocation;
        let source;

        // Priority 1: Google Autocomplete (Full Address) - most specific
        if (isAutocompleteValid) {
            selectedLocation = districtInput.value;
            source = "(Google Address)";
        }
        // Priority 2: Manual Dropdown (District Name)
        else if (manualDistrictDropdown.value) {
            selectedLocation = manualDistrictDropdown.value;
            source = "(Manual District)";
        } else {
            selectedLocation = null;
        }

        if (selectedCity && selectedLocation) {
            const display = document.getElementById('currentLocationDisplay');
            display.innerHTML = `✅ **Selected Location:** **${selectedLocation}**, **${selectedCity}** ${source}`;

            // Close the modal
            const modal = bootstrap.Modal.getInstance(locationModal);
            modal.hide();

        }
    });

    // 7. Initial Geolocation Call
    getUserLocationLink();
});

$(function () {
    $('#saveLocationBtn').on('click', function () {
        var $btn = $(this);
        var city = $('#cityDropdown').val() ? $('#cityDropdown').val().trim() : '';
        var district = $('#manualDistrictDropdown').val() ? $('#manualDistrictDropdown').val().trim() : '';

        // If manual district empty, fallback to the free-text autocomplete input
        if (!district) {
            district = $('#districtInput').val() ? $('#districtInput').val().trim() : '';
        }

        if (!city && !district) {
            alert('Please select a city or enter an address/district.');
            return;
        }

        $btn.prop('disabled', true).text('Saving...');

        $.ajax({
            url: 'index.php?route=common/home.location',
            type: 'POST',
            data: { city: city, district: district },
            dataType: 'json'
        }).done(function (json) {
            if (json && json.success) {
                // Update the visible location label (the modal trigger)
                var label = city ? city + (district ? ', ' + district : '') : district;
                var $trigger = $('[data-bs-target="#locationModal"]').first();
                if ($trigger.length) {
                    $trigger.find('span').first().text(label);
                }

                // Hide the modal (Bootstrap 5)
                var modalEl = document.getElementById('locationModal');
                if (modalEl) {
                    var modalInstance = bootstrap.Modal.getInstance(modalEl) || new bootstrap.Modal(modalEl);
                    modalInstance.hide();
                }
            } else {
                var msg = (json && json.error) ? json.error : 'Unable to save location.';
                alert(msg);
            }
        }).fail(function () {
            alert('An error occurred while saving the location.');
        }).always(function () {
            $btn.prop('disabled', false).text('Save Location');
        });
    });
});