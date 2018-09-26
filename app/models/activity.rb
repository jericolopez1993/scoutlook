class Activity < ApplicationRecord
  has_one_attached :proposal_pdf
  has_one_attached :credit_application
end
