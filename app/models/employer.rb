class Employer < ApplicationRecord

  # Validations
  validates :name, presence: true

  validates_format_of :email, :with => /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
  # password format validations
  PASSWORD_FORMAT = /\A
  (?=.{8,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
  (?=.*[[:^alnum:]])
  /x

  validates :password,
            presence: true,
            length: { in: 8..20 },
            format: { with: PASSWORD_FORMAT, message: 'must contain number,uppercase,lowercase & special characters.' }

  validates :age, presence: true, numericality: { only_integer: true, greater_than: 10, less_then: 120}
  validates :gender, presence: true, :inclusion=> { :in => %w(male female m f MALE FEMALE M F), message: 'Must be valid Gender.' }








  # Callbacks

  before_save :update_reset_token, :if => proc{ password_was.present? && password_changed? }

  def update_reset_token
    p "******SETTING RESET PASSWORD TOKEN TO NIL*****"
    update_column(:reset_token, nil)
  end
end
