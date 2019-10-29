staff_members = StaffMember.all

256.times do |n|
  m = staff_members.sample
  e = m.events.build
  if m.active?
    if n.even?
      e.type = "logged_in"
    else
      e.type = "logged_out"
    end
  else
    e.type = "rejected"
  end
  e.occurred_at = (256 - n).hours.ago
  e.save!
end
