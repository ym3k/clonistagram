class PictureMailer < ApplicationMailer
  def picture_mail(picture, action)
    @picture = picture
    @action = action
    mail to: @picture.user.email, subject: "投稿の確認メール"
  end
end
