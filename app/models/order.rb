class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products

  enum pay_method: { credit_card: 0, transfer: 1 }
  enum order_status: { pay_waiting: 0, confirmation: 1, make: 2, ready: 3, sent: 4 }
end
