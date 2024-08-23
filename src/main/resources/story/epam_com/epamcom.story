Scenario: Check the title is correct
Given I am on main application page
Then page title is equal to `EPAM | Software Engineering & Product Development Services`

Scenario: Check the ability to switch Light / Dark mode 
When I save `class` attribute value of element located by `xpath(//body)` to scenario variable `${initialTheme}`
When I click on element located by `xpath(//div[@class='theme-switcher'])`
When I save `class` attribute value of element located by `xpath(//body)` to scenario variable `${newTheme}`
Then `${initialTheme}` is not equal to `${newTheme}`

Scenario: Check that allow to change language to UA
When I click on element located by `xpath(//button[@class='location-selector__button'])`
When I click on element located by `xpath(//li/a[@class='location-selector__link' and @lang='uk'])`
Then number of elements found by `xpath(//html[@lang='uk-UA'])` is = `1`

Scenario: Check the policies list
Given I am on main application page
When I scroll element located by `xpath(//div/h2[@class='heading large-preheader' and text()='policies'])` into view
Then number of elements found by `xpath(//li/a[@class='fat-links' and text()='<PageName>'])` is = `1`
Examples:
|PageName   				|
|INVESTORS  				|
|COOKIE POLICY          	|
|OPEN SOURCE				|
|APPLICANT PRIVACY NOTICE	|
|PRIVACY POLICY				|
|WEB ACCESSIBILITY			|

Scenario: Check that allow to switch location list by region
When I scroll element located by `xpath(//span[@class='museo-sans-light' and text()='Our'])` into view
When I click on element located by `xpath(//*[contains(@class, 'tabs-23__link js-tabs-link') and text()='<PageName>'])`
Then number of elements found by `xpath(//*[(@aria-selected='true') and text()='<PageName>'])` is = `1`
Examples:
|PageName   |
|AMERICAS	|
|EMEA       |
|APAC		|


Scenario: Check the search function
Given I am on main application page
When I click on element located by `xpath(//span[@class='search-icon dark-iconheader-search__search-icon'])`
When I enter `AI` in field located by `id(new_form_search)`
When I click on element located by `xpath(//span[@class='bth-text-layer'])`
Then number of elements found by `xpath(//*[contains(text(), 'results for')])` is = `1`



Scenario: Chack form's fields validation
Given I am on page with URL `https://www.epam.com/about/who-we-are/contact`
When I click on element located by `xpath(//button[@type='submit'])`
Then number of elements found by `xpath(//*[@name='<FieldName>' and @aria-required='true'])` is = `1`
Examples:
|FieldName       |
|user_email      |
|user_first_name |
|user_last_name  |
|user_phone      |

Scenario: Check that the Company logo on the header lead to the main page
Given I am on page with URL `https://www.epam.com/about`
When I click on element located by `xpath(//a/img[@class='header__logo header__logo-light'])`
Then `${current-page-url}` is equal to `https://www.epam.com/`

Scenario: Check that allows to download report
Given I am on page with URL `https://www.epam.com/about`
When I save `href` attribute value of element located by `xpath(//span[contains(@class, 'desktop') and contains(text(), 'DOWNLOAD')]/../../..//a[@data-gtm-action='click'])` to scenario variable `FileName`
Then `${FileName}` is = `https://www.epam.com/content/dam/epam/free_library/EPAM_Corporate_Overview_Q4_EOY.pdf`
When I execute HTTP GET request for resource with URL `${FileName}`
Then response code is equal to `200`




