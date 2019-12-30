customers = Customer.all
staff_members = StaffMember.where(suspended: false).all

s = 2.years.ago
23.times do |n|
  m = CustomerMessage.create!(
    customer: customers.sample,
    subject: "これは問い合わせです。" * 4,
    body: "これは問い合わせです。\n" * 8,
    created_at: s.advance(months: n)
  )
  r = StaffMessage.create!(
    customer: m.customer,
    staff_member: staff_members.sample,
    root: m,
    parent: m,
    subject: "これは返信です。" * 4,
    body: "これは返信です。\n" * 8,
    created_at: s.advance(months: n, hours: 1)
  )
  if n % 6 == 0
    m2 = CustomerMessage.create!(
      customer: r.customer,
      root: m,
      parent: r,
      subject: "これは返信への返信です。",
      body: "これは返信への返信です。",
      created_at: s.advance(months: n, hours: 2)
    )
    StaffMessage.create!(
      customer: m2.customer,
      staff_member: staff_members.sample,
      root: m,
      parent: m2,
      subject: "これは返信の返信への返信です。",
      body: "これは返信の返信への返信です。",
      created_at: s.advance(months: n, hours: 3)
    )
  end
end

s = 24.hours.ago
8.times do |n|
  CustomerMessage.create!(
    customer: customers.sample,
    subject: "これは問い合わせです。" * 4,
    body: "これは問い合わせです。\n" * 8,
    created_at: s.advance(hours: n * 3)
  )
end
