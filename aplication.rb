class Basket
  def initialize(products:, delivery_charge_rules:, offers:)
    @products = products
    @delivery_charge_rules = delivery_charge_rules
    @offers = offers
    @items = []
  end

  def add(code)
    @items << code
  end

  def total
    product_total = calculate_product_total
    delivery = calculate_delivery(product_total)
    (product_total + delivery).round(2)
  end

  private

  def calculate_product_total
    grouped = @items.tally

    total = 0.0

    grouped.each do |code, quantity|
      price = @products[code][:price]
      offer = @offers.find { |o| o[:code] == code }

      if offer && offer[:type] == "buy_one_get_one_half_price"
        pairs = quantity / 2
        remainder = quantity % 2
        total += (pairs * (price + price / 2.0)) + (remainder * price)
      else
        total += quantity * price
      end
    end

    total
  end

  def calculate_delivery(product_total)
    if product_total < 50
      4.95
    elsif product_total < 90
      2.95
    else
      0.0
    end
  end
end

# ------------------------------Product_data------------------------------
products = {
  "R01" => { name: "Red Widget", price: 32.95 },
  "G01" => { name: "Green Widget", price: 24.95 },
  "B01" => { name: "Blue Widget", price: 7.95 }
}

# -------------------------------Delivery_charge_rules-------------------
delivery_charge_rules = [
  { threshold: 50, charge: 4.95 },
  { threshold: 90, charge: 2.95 },
  { threshold: Float::INFINITY, charge: 0.0 }
]

# -------------------------------Offers----------------------------------
offers = [
  { code: "R01", type: "buy_one_get_one_half_price" }
]

# -------------------------------Test_case-------------------------------
def run_case(codes, products, delivery_charge_rules, offers)
  basket = Basket.new(products:, delivery_charge_rules:, offers:)
  codes.each { |c| basket.add(c) }
  puts "Products: #{codes.join(', ')} => Total: $#{'%.2f' % basket.total}"
end

# -------------------------------Result----------------------------------
run_case(["B01", "G01"], products, delivery_charge_rules, offers)                       # $37.85
run_case(["R01", "R01"], products, delivery_charge_rules, offers)                       # $54.37
run_case(["R01", "G01"], products, delivery_charge_rules, offers)                       # $60.85
run_case(["B01", "B01", "R01", "R01", "R01"], products, delivery_charge_rules, offers)  # $98.27
