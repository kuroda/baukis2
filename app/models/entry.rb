class Entry < ApplicationRecord
  belongs_to :program
  belongs_to :customer
end
