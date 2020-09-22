class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        render json: { data: @user, status: :ok, message: 'Success' }
      end

    def update
    @user = User.find(params[:id])
    if @user.update(user_params)
        render json: { status: :ok, message: 'Success' }
    else
        render json: { json: @user.errors, status: :unprocessable_entity }
    end

    private
    def user_params
        params.require(:user).permit(:id, :first_name, :last_name, :email, :phone,:task)
    end 
end
