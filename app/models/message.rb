class Message < ApplicationRecord
  scope :inboxes, -> {where(:inbox => true)}
  scope :sents, -> {where(:sent => true)}
  scope :trashes, -> {where(:trash => true)}
  scope :archives, -> {where(:archive => true)}
end
