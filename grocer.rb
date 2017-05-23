def consolidate_cart(cart)
  # code here
  newHash = {}
  hashcount = Hash.new(0)
  cart.each do |item|
    item.each do |key,value|
      newHash[key] = value
      hashcount[key] += 1
    end
  end
  hashcount.each do |key,value|
    newHash[key].merge!(:count => value)
  end
  newHash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |x|
    if cart[x[:item]] && cart[x[:item]][:count] >= x[:num]
      cart.merge!({"#{x[:item]} W/COUPON" => {:price => x[:cost], :clearance => cart[x[:item]][:clearance],:count => cart[x[:item]][:count] /x[:num]}})
      cart[x[:item]][:count] =  cart[x[:item]][:count] %x[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key,value|
    if value[:clearance] == true
      value[:price] = (value[:price]*0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  apply_coupons(cart, coupons)
  apply_clearance(cart)
  sum = 0
  cart.each do |key,value|
    sum += value[:price]*value[:count] 
  end
  sum > 100 ? sum*0.9 : sum
end
