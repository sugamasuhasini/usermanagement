class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy, :remove]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = system( "usermod -d #{params[:home_folder]} #{params[:username]}" )
    pass = system( "echo #{params[:username]}:#{params[:password]} | chpasswd")
    @shell = system( "usermod --shell #{params[:shell_type]} #{params[:username]} " )
    if (params[:grant_sudo] == '1' && system("grep #{params[:username]} /etc/sudoers") == false)

    File.open('/etc/sudoers', 'a') do |file|
    file.write "#{params[:username]} ALL=(ALL) NOPASSWD:ALL\n"
    end
    elsif (params[:grant_sudo] != '1')

    system("sed -i '/#{params[:username]}/d' /etc/sudoers")
  end
end

  # POST /users
  # POST /users.json
  def create
    #@user = User.new(user_params)
    @user = system( "useradd #{params[:username]} -s #{params[:shell_type]} -d #{params[:home_folder]}")
    pass = system( "echo #{params[:username]}:#{params[:password]} | chpasswd")
    #format.html { redirect_to @user, notice: 'User was successfully created.' }
   puts @user
   if params[:grant_sudo] == '1'

   File.open('/etc/sudoers', 'a') do |file|
    file.write "#{params[:username]} ALL=(ALL) NOPASSWD:ALL\n"
  end
end
   
     

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1
  # DELETE /users/1.json
#   def remove
    
     
#   # else
#   #   redirect_to '/users/remove'
 
# end

  # def destroy
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end



  def destroy
    @user = system( "userdel -r #{params[:username]}")
    puts @user
    system("sed -i '/#{params[:username]}/d' /etc/sudoers")


    
  end



  

  private
    #Use callbacks to share common setup or constraints between actions.
    # def set_user
    #   @user = User.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :shell_type, :home_folder, :password, :grant_sudo)
    end
end
