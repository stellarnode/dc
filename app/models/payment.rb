class Payment < ApplicationRecord
  belongs_to :user
  after_initialize :init

  validates :receiver, presence: true
  validates :formcomment, presence: true, length: { maximum: 50 }
  validates :comment, length: { maximum: 200 }

  def init
    self.short_dest       = self.formcomment
    self.quickpay_form    = "donate"
    self.targets          = "Donation for #{self.formcomment}. Domochat ID #{self.id}."
    self.label            = "#{self.id}"
    self.successURL       = ENV["ROOT_URL"]
  end

  def set_checkbox_defaults
    self.need_fio         = self.need_fio == "1" ? "true" : "false"
    self.need_email       = self.need_email == "1" ? "true" : "false"
    self.need_phone       = self.need_phone == "1" ? "true" : "false"
    self.need_address     = self.need_address == "1" ? "true" : "false"
  end

end
