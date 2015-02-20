module DashboardHelper
  def resource
    @resource ||= User.new
  end
end
