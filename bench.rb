''' This file benchmarks different Selenium selector methods.

The test page is the Wikipedia page on Selenium (the element).
'''


require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'selenium-webdriver'
require 'benchmark'


TEST_URL = "file://#{File.dirname(__FILE__)}/wikipedia-selenium.html"
N = 100
ELEMENT_ID = 'jump-to-nav'


describe "benchmark" do
  before(:each) do
    client = Selenium::WebDriver::Remote::Http::Default.new
    @browser = Selenium::WebDriver.for(:firefox, :http_client => client)
  end
  
  after(:each) do
    @browser.quit
  end
  
  it "should benchmark!" do
    @browser.navigate.to TEST_URL
    
    Benchmark.bm do |b|
      b.report('by id:') do
        N.times { @browser.find_element(:id, ELEMENT_ID) }
      end
      
      b.report('by xpath:') do
        N.times { @browser.find_element(:xpath, '//div[@id="#{ELEMENT_ID}"]') }
      end
    end
  end
end
