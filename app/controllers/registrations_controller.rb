# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    render 'new', :layout => "public"
  end

  def create
    # add custom create logic here
    super
  end

  def update
    super
  end
end