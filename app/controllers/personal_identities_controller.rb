class PersonalIdentitiesController < ApplicationController
  def index
    @personal_identities = PersonalIdentity.all
  end

  def show
    @personal_identity = PersonalIdentity.find(params[:id])
  end

  def new
    @personal_identity = PersonalIdentity.new
  end

  def strac_new
    @personal_identity = PersonalIdentity.new
  end

  def create
    @personal_identity = PersonalIdentity.new(pi_params)

    if @personal_identity.save
      redirect_to @personal_identity
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @personal_identity = PersonalIdentity.find(params[:id])
  end

  def update
    @personal_identity = PersonalIdentity.find(params[:id])

    if @personal_identity.update(pi_params)
      redirect_to @personal_identity
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def view
    @personal_identities = PersonalIdentity.all
  end

  def destroy
    @personal_identity = PersonalIdentity.find(params[:id])
    @personal_identity.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def pi_params
    params.require(:personal_identity).permit(:name, :ssn, :stracTokens)
  end
end
