module Methods_Manager
  def log_in_as(user)
    post new_user_session_path, params: { user: { email: user.email,
                                                  password: 'password' } }
  end
end