require 'rubygems'
require 'nokogiri'
require 'open-uri'


def takeCryptoCourant
	doc = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
	coursCrypto = doc.css("table#currencies-all tbody td.data-sort")
	# coursCrypto.each {|a| puts a}

	coursCrypto.each do |uneMonnaie|
		puts uneMonnaie
		puts "*"*20
	end
	puts coursCrypto.class
end
# CLASS ===> .
# ID	===> #


# puts "LETS GO ! Mario :)"
takeCryptoCourant
# rvm use ruby-2.5.1