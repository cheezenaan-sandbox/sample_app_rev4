# frozen_string_literal: true

module Sessions
  module Test
    module LoginMacros
      def log_in_as(user)
        visit login_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Login"

        expect(page).to have_current_path user_path(user)
      end

      def log_out
        click_link "Account"
        click_link "Log out"

        expect(page).not_to have_current_path root_path
      end
    end
  end
end
