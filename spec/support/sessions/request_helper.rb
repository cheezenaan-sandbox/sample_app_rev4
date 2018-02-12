# frozen_string_literal: true

module Sessions
  module Test
    module RequestHelper
      def log_in_as(user, remember_me: "1")
        post login_path, params: {
          session: {
            email: user.email,
            password: user.password,
            remember_me: remember_me,
          },
        }
      end

      private

      def remember_me?
        remember_me == "1"
      end
    end
  end
end
