class HashLock < ApplicationRecord
  class << self
    def acquire(table, column, value)
      HashLock.where(table: table, column: column,
        key: Digest::MD5.hexdigest(value)[0,2]).lock(true).first!
    end
  end
end
