class PasswordForm
  include ActiveModel::Model

  def persisted?
    false
  end

  validate :verify_original_password
  attr_accessor :original_password, :new_password, :new_password_confirmation

  def initialize(user)
    @user = user
  end

  def submit(params)
    self.original_password = params[:original_password]
    self.new_password = params[:new_password]
    self.new_password_confirmation = params[:new_password_confirmation]
    if valid?
      @user.password = new_password
      @user.password_confirmation = new_password_confirmation
      @user.save!
      true
    else
      false
    end
  end


  private

  def verify_original_password
    unless @user.authenticate(original_password)
      errors.add :original_password, "is not correct"
    end
  end
end
