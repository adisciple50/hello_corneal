require_relative '../app/models/author'
require_relative '../app/models/facebook'
require_relative '../app/models/twitter'
class User
  attr_accessor :username
  attr_accessor :profile_pic


  def initialize username_or_empty_string,find_username=true
    @user = false
    @profile = false
    @profile_pic = false
    @token = false
    @username = username_or_empty_string
    if find_username
      if username_or_empty_string != '' || username_or_empty_string != ""
        @user = Author.find_by({:username => username_or_empty_string})
      end
    end
  end

  def get_user_by_token token
    if token
      @user = Author.find_by({:token => token})
    else
      self.clone
    end
  end

  def authenticate! password
    if @user.username
      # check password salt
      # https://github.com/codahale/bcrypt-ruby
      @@storedpassword = @user.salt.to_s
      @@hashedpassword = BCrypt::Password.new @@storedpassword
      if @@hashedpassword == password
        # generate and store login token
        @@token = SecureRandom.base64
        @user.update({token:@@token})
        @token = @@token
        return @@token
      else
        return false
      end
    end
  end

  def db
    @user
  end

  def create password
    if @user != nil
      @profile = Profile.create!
      @user = Author.create({:username => @username,
                             :salt => new_salt(password),
                             profile_image_type:0,profile:@profile})
      @user.save!

    end
  end

  def logged_in? compared_token
    @user.token == compared_token # if token != , user is logged out
  end

  def log_out
    @user.token = SecureRandom.base64
    @user.save!
  end

  def logged_out?
    !logged_in?
  end

  def new_salt password
    BCrypt::Password.create password
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
  end

  def save_profile_pic mappings={profile:0,facebook:1,twitter:2}
    update_profile_pic!
  end

  def update_profile_pic!
    @profile.profile_image.save!
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