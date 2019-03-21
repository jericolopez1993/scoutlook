class Message < ApplicationRecord
  scope :inboxes, ->(user_id) {where(:inbox => true, :user_id => user_id)}
  scope :sents, ->(user_id) {where(:sent => true, :user_id => user_id)}
  scope :trashes, ->(user_id) {where(:trash => true, :user_id => user_id)}
  scope :archives, ->(user_id) {where(:archive => true, :user_id => user_id)}
end
