class OrderProduct < ApplicationRecord
 belongs_to :item
 belongs_to :order
 enum production_status: { impossible: 0, waiting: 1, make: 2, finish: 3 }
end
