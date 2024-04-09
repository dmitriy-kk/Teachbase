#cost = []
#cost_produkt = {}
purchases = {:a=>{1.0=>3.0}}


purchases.each do |k, v|
  print k.class
  print v.class
  
  v.each do |k1, v1|
    a = k1 * v1
    print " #{k1} #{v1}"
  end
  
end