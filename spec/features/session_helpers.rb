
def sign_up_with(email, password)
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up'
end

def sign_in_with(email, password)
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end