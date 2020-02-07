class Mailing < ApplicationRecord
  has_many_attached :attachment_files
  default_scope {order("created_at DESC")}
  scope :inboxes, ->(user_id) {where(:inbox => true, :user_id => user_id)}
  scope :sents, ->(user_id) {where(:sent => true, :user_id => user_id)}
  scope :trashes, ->(user_id) {where(:trash => true, :user_id => user_id)}
  scope :archives, ->(user_id) {where(:archive => true, :user_id => user_id)}
  scope :all_sents, ->{where(:sent => true).order("created_at DESC")}
end
