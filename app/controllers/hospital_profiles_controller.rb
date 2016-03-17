class HospitalProfilesController < ApplicationController
  before_action :set_hospital_profile, only: [:show, :edit, :update, :destroy]

  before_filter :load_permissions
  load_and_authorize_resource param_method: :hospital_profile_params
  # GET /hospital_profiles
  # GET /hospital_profiles.json
  def index
    @hospital_profiles = HospitalProfile.all
  end

  # GET /hospital_profiles/1
  # GET /hospital_profiles/1.json
  def show
  end

  # GET /hospital_profiles/new
  def new
    @hospital_profile = HospitalProfile.new
  end

  # GET /hospital_profiles/1/edit
  def edit
  end

  # POST /hospital_profiles
  # POST /hospital_profiles.json
  def create
    @hospital_profile = HospitalProfile.new(hospital_profile_params)

    respond_to do |format|
      if @hospital_profile.save
        format.html { redirect_to root_path, notice: 'Hospital profile was successfully created.' }
        format.json { render :show, status: :created, location: @hospital_profile }
      else
        format.html { render :new }
        format.json { render json: @hospital_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospital_profiles/1
  # PATCH/PUT /hospital_profiles/1.json
  def update
    respond_to do |format|
      if @hospital_profile.update(hospital_profile_params)
        format.html { redirect_to @hospital_profile, notice: 'Hospital profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @hospital_profile }
      else
        format.html { render :edit }
        format.json { render json: @hospital_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospital_profiles/1
  # DELETE /hospital_profiles/1.json
  def destroy
    @hospital_profile.destroy
    respond_to do |format|
      format.html { redirect_to hospital_profiles_url, notice: 'Hospital profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def self.permission
    return 'HospitalProfile'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital_profile
      @hospital_profile = HospitalProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hospital_profile_params
      params.require(:hospital_profile).permit(:name, :about, :location)
    end
end
