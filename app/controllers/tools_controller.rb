class ToolsController < ApplicationController
  def create_token
  end

  THIRD_PARTY_PROVIDERS = {
    'httpBin' => {
      :requires_auth => false,
      :target_url => 'https://httpbin.org/post',
    },
    'getAddressInfo' => {
      :api_key => ENV['ADDRESS_GET_INFO_API_KEY'] || Rails.application.config.address_get_info_api_key,
      :requires_auth => true,
      :target_url => 'https://test.purple-collar.com/api/address-info'
    },
    'getAddressDistance' => {
      :api_key => ENV['ADDRESS_CALCULATE_DISTANCE_API_KEY'] || Rails.application.config.address_calculate_distance_api_key,
      :requires_auth => true,
      :target_url => 'https://test.purple-collar.com/api/address-distance'
    },
    'validateSsn' => {
      :api_key => ENV['SSN_VALIDATE_API_KEY'] || Rails.application.config.ssn_validate_api_key,
      :requires_auth => true,
      :target_url => 'https://test.purple-collar.com/api/validate-ssn'
    }
  }

  def proxy_execute
    request_body = JSON.parse(request.body.read)
    proxy_type = request_body['proxy_type']
    third_party_config = THIRD_PARTY_PROVIDERS[proxy_type]

    use_strac_proxy = ENV['USE_STRAC_PROXY'] == 'true' || Rails.application.config.use_strac_proxy
    puts "Sending request with USE_STRAC_PROXY flag set to #{use_strac_proxy}"

    if use_strac_proxy
      url = "https://api.test.tokenidvault.com/proxy"
      request = Net::HTTP::Post.new(url)
      # Strac API key used to authenticate the application to Strac Proxy service
      request["x-api-key"] = ENV['STRAC_API_KEY']
      # URL of the third party API to proxy requests to
      request["Target-Url"] = third_party_config[:target_url]
    else
      url = third_party_config[:target_url]
      request = Net::HTTP::Post.new(url)
    end

    request_url = URI(url)
    https = Net::HTTP.new(request_url.host, request_url.port)
    https.use_ssl = true
    # All the third parties in this demo use JSON for requests and responses
    request["Content-Type"] = third_party_config[:content_type] || "application/json"

    if third_party_config[:requires_auth]
      request["Authorization"] = "Bearer #{third_party_config[:api_key]}"
    end

    if request_body['resource_type'] == 'address'
      @address = Address.find(request_body['resource_id'])
      puts("Found address #{@address.id}")

      request.body = JSON.dump({
        'line1' => @address.line1,
        'line2' => @address.line2,
        'city' => @address.city,
        'state' => @address.state,
        'zipCode' => @address.zipCode,
        'fromZipCode' => request_body['from_zip_code']
      })
    elsif request_body['resource_type'] == 'personalIdentity'
      @personal_identity = PersonalIdentity.find(request_body['resource_id'])
      puts("Found personal identity #{@personal_identity.id}")
      request.body = JSON.dump({
        'ssn' => @personal_identity.ssn
      })
    end

    response = https.request(request)
    puts "Third-party API response:", response.read_body

    # Mock response
    render :json => { :request_body => JSON.parse(request.body), :response_body => JSON.parse(response.read_body) }
  end

  def proxy
    @proxy_type = params[:type]
    if @proxy_type == 'getAddressInfo'
      @resources = Address.all
      @description = 'Get info for address'
      @submit_text = 'Get info'
      @resource_type = 'address'
    elsif @proxy_type == 'httpBin'
      @resources = Address.all
      @description = 'HTTPBin tool: Show request / response for address'
      @submit_text = 'Show request / response'
      @resource_type = 'address'
    elsif @proxy_type == 'getAddressDistance'
      @resources = Address.all
      @description = 'Calculate distance between a zip code and address'
      @submit_text = 'Calculate distance'
      @show_zip_input = true
      @resource_type = 'address'
    elsif @proxy_type == 'validateSsn'
      @resources = PersonalIdentity.all
      @resource_type = 'personalIdentity'
      @description = 'Validate social security number'
      @submit_text = 'Validate'
    end
  end
end
