require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  SUBJECT = "Reset password email"
  FROM_EMAIL = "from@example.com"

  def setup
    @user = User.create(email: "to@example.org")
  end

  test "reset_password_email" do
    mail = UserMailer.reset_password_email(@user)
    assert_equal SUBJECT, mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ FROM_EMAIL ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
