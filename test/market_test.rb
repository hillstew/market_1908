require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3.stock("Peaches", 65)
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @market.name
  end

  def test_it_has_no_vendors_to_start
    assert_equal [], @market.vendors
  end

  def test_it_can_add_vendors
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_2, @vendor_3], @market.vendors
  end

  def test_it_can_return_the_names_of_vendors
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @market.vendor_names
  end

  def test_it_can_return_vendors_with_specific_produce
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_3], @market.vendors_that_sell("Peaches")
    assert_equal [@vendor_2], @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_it_can_sort_vendors_items_alphabetically
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]

    assert_equal expected, @market.sorted_item_list
  end

  def test_it_can_total_inventory_all_vendors
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    expected = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}

    assert_equal expected, @market.total_inventory
  end

  def test_it_can_sell
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)
    refute @market.sell("Peaches", 200)
    refute @market.sell("Onions", 1)
    assert @market.sell("Banana Nice Cream", 5)
    assert_equal 45, @vendor_2.check_stock("Banana Nice Cream")
    assert @market.sell("Peaches", 40)
    assert_equal 0, @vendor_1.check_stock("Peaches")
    assert_equal 60, @vendor_3.check_stock("Peaches")
  end
end
