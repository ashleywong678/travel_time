class AgenciesController < ApplicationController
  before_action :require_login, except: [:new, :create, :show]
  before_action :set_agency, only: [:main, :show, :edit, :update, :destroy]
  before_action :redirect_if_not_auth, only: [:main, :show, :edit, :destroy]

  def new #signup
    @agency = Agency.new
  end
  
  def create #signup
    @agency = Agency.new(agency_params)
    if @agency.save
      session[:user_id] = @agency.id
      redirect_to agencies_main_path(@agency)
    else
      render :new
    end
  end

  def main #agency's main page
  end

  def show #agency's profile page
  end

  def edit
  end

  def update
    # if @agency == current_user
      @agency.update(agency_params)
      if @agency.errors.any?
        render :edit
      else
        redirect_to @agency
      end
    # else
    #   redirect_to root_path
    # end
  end

  def destroy
    # if @agency == current_user
      @article.destroy
    # else
    #   redirect_to root_path
    # end
  end

  private

  def agency_params
    params.require(:agency).permit(:name, :password, :email, :address, :phone_number, :country, :language)
  end

  def set_agency
    @agency = Agency.find_by(id: params[:id])
  end

  def redirect_if_not_auth
    if @agency != current_user
      flash[:message] = "Sorry, you are not authorized to view this page"
      redirect_to root_path
    end
  end

end
