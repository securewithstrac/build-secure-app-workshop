class AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end

  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def strac_new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to @address
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to @address
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def view
    @addresses = Address.all
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def address_params
      params.require(:address).permit(:alias, :line1, :line2, :city, :state, :zipCode, :stracTokens)
    end
end
