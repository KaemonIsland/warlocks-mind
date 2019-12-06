module RequirePermission

  def require_permission resource_owner
    if current_user != resource_owner
      flash[:danger] = 'You do not have access to that resource'
      redirect_to(root_path)
    end
  end
end
