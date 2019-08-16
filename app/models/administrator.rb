class Administrator < ApplicationRecord
  include EmailHolder
  include PasswordHolder
end
