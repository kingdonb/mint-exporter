require "uri"
require "bundler/setup"
Bundler.require

hostname = "https://wwws.mint.com/"

unless ARGV.length == 2
  puts "Usage: ruby #{$0} USERNAME PASSWORD"
  exit 1
end

username = ARGV[0]
password = ARGV[1]

browser = Capybara
Capybara.javascript_driver = :webkit
Capybara.current_driver = :webkit

browser.visit(URI.join hostname, "/login.event")

browser.fill_in("form-login-username", with: username)
browser.fill_in("form-login-password", with: password)
browser.click_button("submit")

puts URI.join hostname, "/transactionDownload.event"
browser.visit(URI.join hostname, "/transactionDownload.event")
puts browser.page.source
