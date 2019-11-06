city_names = %w(青巻市 赤巻市 黄巻市)

family_names = %w{
  佐藤:サトウ:sato
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
  渡辺:ワタナベ:watanabe
  伊藤:イトウ:ito
  山本:ヤマモト:yamamoto
  中村:ナカムラ:nakamura
  小林:コバヤシ:kobayashi
  加藤:カトウ:kato
}

given_names = %w{
  一郎:イチロウ:ichiro
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  四郎:シロウ:shiro
  五郎:ゴロウ:goro
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
  鶴子:ツルコ:tsuruko
  亀子:カメコ:kameko
}

company_names = %w(OIAX ABC XYZ)

10.times do |n|
  10.times do |m|
    fn = family_names[n].split(":")
    gn = given_names[m].split(":")

    c = Customer.create!(
      email: "#{fn[2]}.#{gn[2]}@example.jp",
      family_name: fn[0],
      given_name: gn[0],
      family_name_kana: fn[1],
      given_name_kana: gn[1],
      password: "password",
      birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
      gender: m < 5 ? "male" : "female"
    )
    c.create_home_address!(
      postal_code: sprintf("%07d", rand(10000000)),
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: "開発1-2-3",
      address2: "レイルズハイツ301号室"
    )
    if m % 3 == 0
      c.create_work_address!(
        postal_code: sprintf("%07d", rand(10000000)),
        prefecture: Address::PREFECTURE_NAMES.sample,
        city: city_names.sample,
        address1: "試験4-5-6",
        address2: "ルビービル2F",
        company_name: company_names.sample
      )
    end
  end
end
