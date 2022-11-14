class ToolsController < ApplicationController
  def create_token
  end

  def proxy
    @addresses = Address.all

    @proxy_type = params[:type]
    if @proxy_type == 'getAddressInfo'
      @description = 'Get info for address'
      @submit_text = 'Get info'
    elsif @proxy_type == 'httpBin'
      @description = 'HTTPBin tool: Show request / response for address'
      @submit_text = 'Show request / response'
    elsif @proxy_type == 'getAddressDistance'
      @description = 'Calculate distance between a zip code and address'
      @submit_text = 'Calculate distance'
      @show_zip_input = true
    end
  end
end
