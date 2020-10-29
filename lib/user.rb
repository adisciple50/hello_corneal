require_relative '../app/models/author'
class User
  attr_accessor :username
  # @password = ''
  @user = false
  @profile = false
  @profile_pic = false

  def initialize username,password
    @user = Author.find_by({:username => username})
  end

  def authenticate! password
    if @user.username
      # check password salt
      # https://github.com/codahale/bcrypt-ruby
      storedpassword = @user.salt.to_s
      hashedpassword = BCrypt::Password.new storedpassword
      if hashedpassword == password
        # generate and store login token
        token = SecureRandom.base64
        @user.update({token:token})
        return token
      else
        return false
      end
    end
  end

  def db
    @user
  end

  def logged_in?
    @user.token != '' # if token is blank, user is logged out
  end

  def log_out
    @user.token = ''
    @user.save!
  end

  def logged_out?
    !logged_in?
  end

  def new_salt password
    BCrypt::Password.new password
  end

  def update_password password
    @user.salt = new_salt password
    @user.save!
  end

  def load_profile_pic mappings={profile:0,facebook:1,twitter:2}
    #   get profile to load pic from
    case @user.profile_image_type
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

  private

  def load_facebook
    @profile = Facebook.find @user.facebook.id
  end

  def load_twitter
    @profile = Twitter.find @user.twitter.id
  end

  def load_profile
    @profile = Profile.find @user.profile.id
  end

  def update_profile_pic
    @profile_pic = @profile.profile_image
  end
end