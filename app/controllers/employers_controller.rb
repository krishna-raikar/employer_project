class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy, :reset_password]
  before_action :set_employer_by_token, only: [:edit_password]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /employers/:emp_id/reset_password
  def reset_password
    respond_to do|format|
      if @employer.reset_token.nil?
        @employer.update(reset_token: random_token)
        EmployerMailer.send_reset_password_link(@employer).deliver_now
        format.html { redirect_to employers_url, notice: 'Reset password Token has been sent.'}
      else
        format.html { redirect_to employers_url, notice: 'Reset password Token already sent!.'}
      end
    end
  end

  def edit_password
    respond_to do|format|
      if @employer
        format.html
      else
        format.html { render 'token_invalid', notice: 'Token invalid or not present.'}
      end
    end
  end


  # DELETE /employers/1
  # DELETE /employers/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to employers_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # This function will return random token
    def random_token
      rand(36**30).to_s(36)
    end

    def set_employer_by_token
      @employer = Employer.find_by(reset_token: params[:reset_token])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_employer
      @employer = Employer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_params
      params.require(:employer).permit(:name, :email, :password, :age, :gender, :reset_token)
    end
end
