Scenario: Verify that allows register a User
Given I am on main application page
When I click on element located by `xpath(//a[@class='ico-register'])`
When I enter `John` in field located by `id(FirstName)`
When I enter `#{generate(Name.lastName)}` in field located by `id(LastName)`
When I enter `john.dou71@gmail.com` in field located by `id(Email)`
When I enter `6clz0w9ft47ubf` in field located by `id(Password)`
When I enter `6clz0w9ft47ubf` in field located by `id(ConfirmPassword)`
When I click on element located by `id(register-button)`
Then `${current-page-url}` is equal to `https://demowebshop.tricentis.com/registerresult/1`

Scenario: Verify that allows login a User
When I click on element located by `xpath(//a[@class='ico-logout'])`
When I click on element located by `xpath(//a[@class='ico-login'])`
When I enter `john.dou71@gmail.com` in field located by `id(Email)`
When I enter `6clz0w9ft47ubf` in field located by `id(Password)`
When I click on element located by `xpath(//input[@class='button-1 login-button'])`
Then `${current-page-url}` is equal to `https://demowebshop.tricentis.com/`

Scenario: Verify that ‘Computers’ group has 3 sub-groups with correct names
Given I am on page with URL `https://demowebshop.tricentis.com/computers`
Then number of elements found by `xpath(//h2/a[@href='/desktops' and contains(text(), 'Desktops')])` is = `1`
Then number of elements found by `xpath(//h2/a[@href='/notebooks' and contains(text(), 'Notebooks')])` is = `1`
Then number of elements found by `xpath(//h2/a[@href='/accessories' and contains(text(), 'Accessories')])` is = `1`


Scenario: Verify that allows sorting items with different options
Given I am on page with URL `https://demowebshop.tricentis.com/computers`
When I click on element located by `xpath(//h2/a[@href='/desktops' and contains(text(), 'Desktops')])`
When I select `Name: A to Z` in dropdown located by `xpath(//select[contains(@id, 'products-orderby')])`
Then elements located by `xpath(//h2[@class='product-title'])` are sorted by text in ascending order
When I select `Name: Z to A` in dropdown located by `xpath(//select[contains(@id, 'products-orderby')])`
Then elements located by `xpath(//h2[@class='product-title'])` are sorted by text in descending order


Scenario: Verify that allows changing number of items on page
When I select `4` in dropdown located by `xpath(//select[@id='products-pagesize'])`
Then number of elements found by `xpath(//div[@class='product-grid']//div[contains(@class, 'item-box')])` is = `4`
When I select `8` in dropdown located by `xpath(//select[@id='products-pagesize'])`
Then number of elements found by `xpath(//div[@class='product-grid']//div[contains(@class, 'item-box')])` is = `8`


Scenario: Verify that allows adding an item to the Wishlist
Given I am on page with URL `https://demowebshop.tricentis.com/black-white-diamond-heart`
When I click on element located by `id(add-to-wishlist-button-14)`
When I click on element located by `xpath(//p/a[@href='/wishlist'])`
Then number of elements found by `xpath(//a[@href='/black-white-diamond-heart'])` is = `1`

Scenario: Verify that allows adding an item to the card
Given I am on page with URL `https://demowebshop.tricentis.com/album-3`
When I click on element located by `id(add-to-cart-button-53)`
When I click on element located by `xpath(//span[@class='cart-label' and text()='Shopping cart'])`
Then number of elements found by `xpath(//a[@href='/album-3'])` is = `1`

Scenario: Verify that allows removing an item from the card
When I click on element located by `xpath(//input[@name='removefromcart'])`
When I click on element located by `xpath(//input[@name='updatecart'])`
Then number of elements found by `xpath(//*[contains(text(), 'Your Shopping Cart is empty')])` is = `1`

Scenario: Verify that allows checkout an item
Given I am on page with URL `https://demowebshop.tricentis.com/album-3`
When I click on element located by `id(add-to-cart-button-53)`
When I click on element located by `xpath(//span[@class='cart-label' and text()='Shopping cart'])`
When I click on element located by `id(termsofservice)`
When I click on element located by `id(checkout)`
When I select `Canada` in dropdown located by `id(BillingNewAddress_CountryId)`
When I enter `#{generate(Address.city)}` in field located by `id(BillingNewAddress_City)`
When I enter `#{generate(Address.streetName)}` in field located by `id(BillingNewAddress_Address1)`
When I enter `#{generate(Address.zipCode)}` in field located by `id(BillingNewAddress_ZipPostalCode)`
When I enter `#{generate(PhoneNumber.cellPhone)}` in field located by `id(BillingNewAddress_PhoneNumber)`
When I click on element located by `xpath(//input[@class='button-1 new-address-next-step-button'])`
When I click on element located by `xpath(//input[@class='button-1 payment-method-next-step-button'])`
When I click on element located by `xpath(//input[@class='button-1 payment-info-next-step-button'])`
When I click on element located by `xpath(//input[@class='button-1 confirm-order-next-step-button'])`
When I save text of element located by `xpath(//div/strong[text()='Your order has been successfully processed!'])` to SCENARIO variable `thankYouMessage`
Given I initialize SCENARIO variable `expectedMessage` with value `#{loadResource(/data/message.txt)}`
Then `#{eval(thankYouMessage == expectedMessage)}` is equal to `true`
When I take screenshot
