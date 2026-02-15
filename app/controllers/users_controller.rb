# app/controllers/users_controller.rb
def show
  @user = User.find(params[:id])
  @owned_sessions = @user.plan_sessions.order(start_time: :desc) 
end
