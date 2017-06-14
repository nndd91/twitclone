class UserSearch
  def initialize(searchvalue)
    @searchvalue = searchvalue.downcase
  end

  def call
    @search_first_name = User.where("first_name ~* '#{@searchvalue}'").pluck(:id)
    @search_last_name = User.where("last_name ~* '#{@searchvalue}'").pluck(:id)
    @search_username = User.where("username ~* '#{@searchvalue}'").pluck(:id)
    @search_email = User.where("email ~* '#{@searchvalue}'").pluck(:id)
    @allusers = (@search_first_name + @search_last_name + @search_username + @search_email).uniq
  end
end
