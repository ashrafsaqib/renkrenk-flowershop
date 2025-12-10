/**
 * Common Subscription Management JavaScript
 * Shared between Admin and Catalog (Customer) contexts
 */

var SubscriptionManager = (function() {
    'use strict';
    
    /**
     * Initialize subscription management
     * @param {Object} config - Configuration object
     * @param {string} config.baseUrl - Base URL for AJAX requests
     * @param {number} config.subscriptionId - Subscription ID
     * @param {string} config.token - User or session token
     * @param {string} config.tokenParam - Token parameter name (user_token or token)
     */
    function init(config) {
        if (!config || !config.baseUrl || !config.subscriptionId) {
            console.error('SubscriptionManager: Invalid configuration');
            return;
        }
        
        this.config = config;
        this.setupEventHandlers();
    }
    
    /**
     * Setup event handlers for all subscription management buttons
     */
    function setupEventHandlers() {
        var self = this;
        
        // Pause Subscription
        $(document).on('click', '#button-pause-confirm', function(e) {
            e.preventDefault();
            self.pauseSubscription();
        });
        
        // Resume Subscription
        $(document).on('click', '#button-resume-confirm', function() {
            self.resumeSubscription();
        });
        
        // Skip Next Delivery
        $(document).on('click', '#button-skip-confirm', function() {
            self.skipDelivery();
        });
        
        // Change Frequency
        $(document).on('click', '#button-frequency-confirm', function() {
            self.changeFrequency();
        });
        
        // Change Delivery Date
        $(document).on('click', '#button-delivery-date-confirm', function() {
            self.changeDeliveryDate();
        });
        
        // Change Plan
        $(document).on('click', '#button-plan-confirm', function() {
            self.changePlan();
        });
        
        // Change Address
        $(document).on('click', '#button-address-confirm', function() {
            self.changeAddress();
        });
        
        // Cancel Subscription
        $(document).on('click', '#button-cancel-subscription-confirm', function() {
            self.cancelSubscription();
        });
    }
    
    /**
     * Build URL with token parameter
     */
    function buildUrl(route) {
        var url = this.config.baseUrl + '?route=' + route;
        if (this.config.token && this.config.tokenParam) {
            url += '&' + this.config.tokenParam + '=' + this.config.token;
        }
        return url;
    }
    
    /**
     * Make AJAX request with common error handling
     */
    function makeRequest(options) {
        var defaults = {
            type: 'post',
            dataType: 'json',
            beforeSend: function() {
                if (options.button) {
                    $(options.button).prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> ' + (options.loadingText || 'Processing...'));
                }
            },
            complete: function() {
                if (options.button) {
                    $(options.button).prop('disabled', false).html(options.buttonText || 'Submit');
                }
            },
            success: function(json) {
                if (json['error']) {
                    alert(json['error']);
                }
                if (json['success']) {
                    if (options.modal) {
                        $(options.modal).modal('hide');
                    }
                    location.reload();
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log('AJAX Error:', thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                alert('An error occurred. Please try again.');
            }
        };
        
        return $.ajax($.extend({}, defaults, options));
    }
    
    /**
     * Pause Subscription
     */
    function pauseSubscription() {
        var pauseDate = $('#input-pause-date').val();
        
        if (!pauseDate) {
            alert('Please select a pause date.');
            return false;
        }
        
        this.makeRequest({
            url: this.buildUrl(this.config.routes.pause),
            data: {
                subscription_id: this.config.subscriptionId,
                paused_until: pauseDate,
                comment: $('#input-pause-comment').val()
            },
            button: '#button-pause-confirm',
            buttonText: 'Pause Subscription',
            loadingText: 'Processing...',
            modal: '#modal-pause'
        });
    }
    
    /**
     * Resume Subscription
     */
    function resumeSubscription() {
        this.makeRequest({
            url: this.buildUrl(this.config.routes.resume),
            data: {
                subscription_id: this.config.subscriptionId,
                comment: $('#input-resume-comment').val()
            },
            button: '#button-resume-confirm',
            buttonText: 'Resume Subscription',
            loadingText: 'Processing...',
            modal: '#modal-resume'
        });
    }
    
    /**
     * Skip Next Delivery
     */
    function skipDelivery() {
        var skipCount = $('#input-skip-count').val();
        
        this.makeRequest({
            url: this.buildUrl(this.config.routes.skip),
            data: {
                subscription_id: this.config.subscriptionId,
                skip_count: skipCount,
                comment: $('#input-skip-comment').val()
            },
            button: '#button-skip-confirm',
            buttonText: 'Skip Deliveries',
            loadingText: 'Processing...',
            modal: '#modal-skip'
        });
    }
    
    /**
     * Change Frequency
     */
    function changeFrequency() {
        this.makeRequest({
            url: this.buildUrl(this.config.routes.changeFrequency),
            data: {
                subscription_id: this.config.subscriptionId,
                frequency_id: $('#input-frequency').val(),
                comment: $('#input-frequency-comment').val()
            },
            button: '#button-frequency-confirm',
            buttonText: 'Change Frequency',
            loadingText: 'Processing...',
            modal: '#modal-frequency'
        });
    }
    
    /**
     * Change Delivery Date
     */
    function changeDeliveryDate() {
        this.makeRequest({
            url: this.buildUrl(this.config.routes.changeDeliveryDate),
            data: {
                subscription_id: this.config.subscriptionId,
                delivery_date: $('#input-delivery-date').val(),
                comment: $('#input-delivery-date-comment').val()
            },
            button: '#button-delivery-date-confirm',
            buttonText: 'Change Date',
            loadingText: 'Processing...',
            modal: '#modal-delivery-date'
        });
    }
    
    /**
     * Change Plan
     */
    function changePlan() {
        this.makeRequest({
            url: this.buildUrl(this.config.routes.changePlan),
            data: {
                subscription_id: this.config.subscriptionId,
                plan_id: $('#input-plan').val(),
                comment: $('#input-plan-comment').val()
            },
            button: '#button-plan-confirm',
            buttonText: 'Change Plan',
            loadingText: 'Processing...',
            modal: '#modal-plan'
        });
    }
    
    /**
     * Change Address
     */
    function changeAddress() {
        var activeTab = $('#modal-address .tab-pane.active').attr('id');
        
        var postData = {
            subscription_id: this.config.subscriptionId
        };
        
        if (activeTab === 'tab-edit-address') {
            postData.update_current = '1';
            postData.firstname = $('#input-firstname').val();
            postData.lastname = $('#input-lastname').val();
            postData.company = $('#input-company').val();
            postData.address_1 = $('#input-address-1').val();
            postData.address_2 = $('#input-address-2').val();
            postData.city = $('#input-city').val();
            postData.postcode = $('#input-postcode').val();
            postData.country_id = $('#input-country').val();
            postData.zone_id = $('#input-zone').val();
            postData.comment = $('#input-edit-comment').val();
        } else {
            postData.address_id = $('#input-address-select').val();
            postData.comment = $('#input-select-comment').val();
        }
        
        this.makeRequest({
            url: this.buildUrl(this.config.routes.changeAddress),
            data: postData,
            button: '#button-address-confirm',
            buttonText: 'Update Address',
            loadingText: 'Updating...',
            modal: '#modal-address'
        });
    }
    
    /**
     * Cancel Subscription
     */
    function cancelSubscription() {
        var reason = $('#input-cancel-reason').val();
        
        if (!reason || reason.trim() === '') {
            alert('Please provide a reason for cancellation.');
            return false;
        }
        
        if (!confirm('Are you sure you want to cancel this subscription? This action cannot be undone.')) {
            return false;
        }
        
        this.makeRequest({
            url: this.buildUrl(this.config.routes.cancel),
            data: {
                subscription_id: this.config.subscriptionId,
                comment: reason
            },
            button: '#button-cancel-subscription-confirm',
            buttonText: 'Cancel Subscription',
            loadingText: 'Cancelling...',
            modal: '#modal-cancel-subscription'
        });
    }
    
    /**
     * Initialize zone/state loading for address change
     */
    function initAddressZoneLoader(currentZoneId, zoneLoadUrl) {
        var shouldSelectZone = true;
        
        function loadZones(country_id, selectZone) {
            if (!country_id) {
                $('#input-zone').html('<option value="">-- Select Region / State --</option>');
                return;
            }
            
            $.ajax({
                url: zoneLoadUrl + '&country_id=' + country_id,
                type: 'get',
                dataType: 'json',
                beforeSend: function() {
                    $('#input-zone').html('<option value="">Loading...</option>');
                },
                success: function(json) {
                    var html = '<option value="">-- Select Region / State --</option>';
                    
                    if (json && json.length > 0) {
                        for (var i = 0; i < json.length; i++) {
                            html += '<option value="' + json[i]['zone_id'] + '"';
                            if (selectZone && (json[i]['zone_id'] == currentZoneId || json[i]['zone_id'] === parseInt(currentZoneId))) {
                                html += ' selected';
                            }
                            html += '>' + json[i]['name'] + '</option>';
                        }
                    } else {
                        html = '<option value="">No regions available</option>';
                    }
                    
                    $('#input-zone').html(html);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    console.log('Zone loading error:', thrownError);
                    $('#input-zone').html('<option value="">Error loading regions</option>');
                }
            });
        }
        
        $(document).on('change', '#input-country', function() {
            var country_id = $(this).val();
            loadZones(country_id, shouldSelectZone);
            shouldSelectZone = false;
        });
        
        $(document).on('shown.bs.modal', '#modal-address', function() {
            var countryValue = $('#input-country').val();
            shouldSelectZone = true;
            
            if (countryValue) {
                loadZones(countryValue, true);
            }
        });
    }
    
    // Public API
    return {
        init: init,
        pauseSubscription: pauseSubscription,
        resumeSubscription: resumeSubscription,
        skipDelivery: skipDelivery,
        changeFrequency: changeFrequency,
        changeDeliveryDate: changeDeliveryDate,
        changePlan: changePlan,
        changeAddress: changeAddress,
        cancelSubscription: cancelSubscription,
        initAddressZoneLoader: initAddressZoneLoader,
        setupEventHandlers: setupEventHandlers,
        buildUrl: buildUrl,
        makeRequest: makeRequest
    };
})();
