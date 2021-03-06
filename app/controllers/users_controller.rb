class UsersController < ApplicationController
  load_and_authorize_resource
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    current_user=User.find(session[:user_id])
    flag=false
    flag=true if current_user.is? :admin
    flag=true if current_user.id===@user.id

    #if !(current_user.is? :admin || current_user.id==@user.id)
    if !flag
      redirect_to '/', notice: @user.id.to_s
      return 
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def change_role
    user=User.find(params[:user_id])
    role=params[:role]
    if user.is? role
      user.roles=user.roles-[role]
    else
      user.roles=user.roles<<role
    end
    if user.save
      redirect_to '/users/'+user.id.to_s+'/edit', notice: 'Role changed'
    else
      redirect_to '/users/', notice: 'Error changing role'
    end
  end
  
  def sing_out
    session[:user_id] = nil
    redirect_to :back, :notice => "Logged out"
  end

end
