module Authorization
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

	private

	def user_not_authorized
		render :json => { :error => 'You are not authorized.' }, :status => 422
	end
end