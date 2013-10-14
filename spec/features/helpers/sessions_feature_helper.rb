module Features

  module SessionHelpers

    def create_user(first_name, last_name, email, password)
      user = User.create({ first_name: first_name,
                           last_name: last_name,
                           email: email,
                           password: password,
                           password_confirmation: password })
    end

    def sign_in(email,password)  
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end

  end

end
