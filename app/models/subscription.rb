class Subscription < ActiveRecord::Base
  belongs_to :event
  belongs_to :user


  validates :event, presence: true

  # проверки выполняются только если  user не задан (незареганные приглашенные)
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :email_valid?, unless: 'user.present?'

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def email_valid?
    if User.where(email: user_email).exists?
      errors.add(:base, I18n.t('controllers.subscription.emails_error'))
    end
  end

end
