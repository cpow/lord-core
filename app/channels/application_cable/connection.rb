module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      @current_user = verify_current_user
    end

    private

    def verify_current_user
      env['warden'].user('user') || env['warden'].user('property_manager')
    end
  end
end
