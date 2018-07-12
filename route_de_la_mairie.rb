require 'rubygems'
require 'nokogiri'
require 'open-uri'
def histoire
	puts "\t#{'*'*12} UNE JOURNEE DE TRAVAIL LAMBDA #{'*'*12}\n\n\n"

	puts "CEO: 'Je voudrait toutes les adresses email des mairies du Val d'Oise.'"
	puts "MOI: 'Quelle coincidence, je viens d'apprendre à le faire.'"
	puts "\n[...]"
	puts "[...]"
	puts "\n*Se dirige vers l'annuaire des mairies* -> http://annuaire-des-mairies.com/"
	puts "\n*Tourne les pages pour acceder à celle du Val d'Oise* -> http://annuaire-des-mairies.com/val-d-oise.html"
end
# CLASS ===> .
# ID	===> #

# RETOURNE UN EMAIL (lui donner l'URL de la mairie voulu)
def get_the_email_of_a_townhal_from_it_webpage(urlMairie)
	doc = Nokogiri::HTML(open(urlMairie))
	mail = doc.css("tbody tr")[3].css("td")[1]
	# mail = doc.css("tbody tr.txt-primary td")
	return mail.content
end

# RETOURNE UN TABLEAU DE LIEN DES MAIRIES (lui donner le lien de la mairie avec ses liens)
def get_all_the_urls_of_val_doise_townhalls(urlMairieDuneCommune)
	tabDurl = []
	doc = Nokogiri::HTML(open(urlMairieDuneCommune))

	urlVillesCommune = doc.css("a.lientxt")
	urlVillesCommune.each {
		|link|
		tabDurl << "http://annuaire-des-mairies.com/"+link['href']
	}
	# puts urlVillesCommune
	return tabDurl
end

def start(urlCommune)
	links = get_all_the_urls_of_val_doise_townhalls(urlCommune)


	# links.each do |link|
	links.length.times do |i|
		if get_the_email_of_a_townhal_from_it_webpage(links[i]).empty? == false
			puts get_the_email_of_a_townhal_from_it_webpage(links[i])
		end
	end
end


start("http://annuaire-des-mairies.com/val-d-oise.html")