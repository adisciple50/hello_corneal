require_relative '../app/models/author'
class User
  attr_accessor :username
  # @password = ''
  @db = false
  @facebook = false
  @twitter = false
  @profile = false
  @profile_pic = false

  def initialize username,password
    @db = Author.find_by({:username => username})
    self.authenticate! password
  end

  def authenticate! password
    puts @db.to_s
    # check login exists

    if @db.username == @username
      # check password salt
      # https://github.com/codahale/bcrypt-ruby
      storedpassword = @db.salt.to_s
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
    @db.token != '' # if token is blank, user is logged out
  end

  def logged_out?
    !logged_in?
  end

  def new_salt password
    BCrypt::Password.new password
  end

  def update_password password
    @db.salt = new_salt password
    @db.save!
  end

  private

  def load_facebook
    @profile = Facebook.find @db.facebook.id
  end

  def load_twitter
    @profile = Twitter.find @db.twitter.id
  end

  def load_profile
    @profile = Profile.find @db.profile.id
  end

  def load_profile_pic mappings={profile:0,facebook:1,twitter:2}
  #   get profile to load pic from
    case @db.profile_image_type
      when 0 # profile picture is default profile
        self.load_profile
        self.update_profile_pic
      when 1 # profile picture is facebook picture
        self.load_facebook
        self.update_profile_pic
      when 2 # profile picture is twitter picture
        self.load_twitter
        self.update_profile_pic
      else
        Exception 'profile picture type not implemented - see load profile pic'
    end
  #   return picture
  end

  def update_profile_pic
    @profile_pic = @profile.profile_image
  end
end