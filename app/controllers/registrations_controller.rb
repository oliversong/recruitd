# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    puts params.to_yaml
    super
  end

  def update
    puts params.to_yaml
    super
  end
end