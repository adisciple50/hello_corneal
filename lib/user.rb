require_relative '../app/models/author'
class User
  attr_accessor :username
  @password = ''
  @db = ''

  def initialize username,password
    @db = Author.find_by({:username => username}).take
    authenticate!
  end
  def authenticate!
    puts @db.to_s
    # check login exists

    if @db.username == username
      # check password salt
      # https://github.com/codahale/bcrypt-ruby
      storedpassword = @db.password.to_s
      hashedpassword = BCrypt::Password.new storedpassword
      if hashedpassword == password
        # generate and store login token
        token = SecureRandom.base64
        @db.update({token:token})
        return token
      end
    end
  end

  def logged_in?

  end
end