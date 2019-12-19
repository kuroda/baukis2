class UpdateCustomers1 < ActiveRecord::Migration[6.0]
  def up
    execute(%q{
      UPDATE customers SET birth_year = EXTRACT(YEAR FROM birthday),
        birth_month = EXTRACT(MONTH FROM birthday),
        birth_mday = EXTRACT(DAY FROM birthday)
        WHERE birthday IS NOT NULL
    })
  end

  def down
    execute(%q{
      UPDATE customers SET birth_year = NULL,
        birth_month = NULL,
        birth_mday = NULL
    })
  end
end
