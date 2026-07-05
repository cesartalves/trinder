class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
  if params[:password].blank?
    params.delete(:password)
    params.delete(:password_confirmation)
  end

  result = resource.update(params)

  if result && request.params[:photos].present?
    request.params[:photos].each do |position, uploaded_image|
      next if uploaded_image.blank?

      photo = resource.photos.find_or_initialize_by(position: position.to_i)
      photo.save! unless photo.persisted?

      photo.image.purge if photo.image.attached?
      photo.image.attach(uploaded_image)
    end
  end

  result
end

  def account_update_params
    params.require(:user).permit(
      :email,
      :name,
      :description,
      :password,
      :password_confirmation
    )
  end
end