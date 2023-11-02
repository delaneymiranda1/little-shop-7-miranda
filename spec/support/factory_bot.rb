FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name  }
  end
end

FactoryBot.define do
  factory :merchant do
    name { Faker::Name.name }
  end
end

FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Alphanumeric.alphanumeric(number: 16, min_numeric: 16) }
    credit_card_expiration_date { "#{"%02d" % (Faker::Number.between(from: 1, to: 12))}/#{Faker::Number.between(from: 24, to: 30)}"  }
    result { Faker::Number.between(from: 0, to: 1)  }
  end
end

FactoryBot.define do
  factory :invoice do
    association :customer
    status { Faker::Number.between(from: 0, to: 2) }
  end
end

FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Lorem.word(exclude_words: 'error') }
    description { Faker::Lorem.sentence(word_count: 4, exclude_words: 'error') }
    unit_price { Faker::Number.between(from: 1, to: 10000) }
  end
end

FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { Faker::Number.between(from: 0, to: 2) }
    status { Faker::Number.between(from: 0, to: 2) }
    # unit_price { Faker::Name.first_name }
  end
end