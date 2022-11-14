require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module StracDemoWebsiteRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Requests to third-party API services go through a Strac proxy. If this is true, you can use Strac tokens for
    # API keys. Can also specify using env variable: USE_STRAC_PROXY=false, if true you can use environment variable
    # to specify the API Key: STRAC_API_KEY=sk_test_...
    config.use_strac_proxy = false

    # You can place the API keys or API key token for third-party providers below, or in environment variables
    # API #1: Get city / zip code info. Can also specify using env variable: ADDRESS_GET_INFO_API_KEY=82d...
    config.address_get_info_api_key = "82df2c19-a7c1-47b9-bc83-32942d39c72d"
    # API #2: Calculate address distance. Can also specify using env variable: ADDRESS_CALCULATE_DISTANCE_API_KEY=cac...
    config.address_calculate_distance_api_key = "cacd6b8e-39a2-403a-a554-59f67b8ddee8"
    # API #3: Verify social security number. Can also specify using env variable: SSN_VALIDATE_API_KEY=33f...
    config.ssn_validate_api_key = "33fb8900-11c3-43bb-b8e6-ab9f22fe65f5"
  end
end
