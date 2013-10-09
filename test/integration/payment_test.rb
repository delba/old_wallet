require 'test_helper'

class PaymentTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
    @jane = users(:jane)
    @card = OpenStruct.new(
      name: 'John Doe',
      number: '4242 4242 4242 4242',
      exp_date: 1.year.from_now.strftime('%m / %y'),
      cvc: '123'
    )
  end

  test "make a payment" do
    visit "/users/#{@jane.id}"

    within '#payment' do
      select 'USD', from: 'Currency'
      fill_in 'Amount', with: '50'
      fill_in 'Name on card', with: @card.name
      fill_in 'Card number', with: @card.number
      fill_in 'Expires', with: @card.exp_date
      fill_in 'Card code', with: @card.cvc
      click_button 'Donate'
    end

    t = Time.now

    until has_selector?('p.notice')
      sleep 0.1
      break if Time.now - t > 10
    end

    assert_selector 'p.notice', text: 'Thank you!'
    assert_equal "/users/#{@jane.id}", current_path
  end
end
