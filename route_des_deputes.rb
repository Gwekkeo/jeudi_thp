require 'rubygems'
require 'nokogiri'
require 'open-uri'


# RENVOIE UN TABLEAU DES NOMS DES DEPUTES
# RECOIT L'URL DE L'ANNUAIRE COMPLET
def nomDeputes(url)
	tabDeputeName = []
	doc = Nokogiri::HTML(open(url))
	links = doc.css("div.clearfix ul a")

	links.each{
		|link|
		tabDeputeName << link.text
	}
	return tabDeputeName
end

# RETOURNE UN ARRAY D'ARRAY QUI CONTIENNENT CHAQU'UN LE [PRENOM,NOM] D'UN DEPUTE
# RECOIT UN TABLEAU SIMPLE DES NOMS
def nomPrenom(tabDepute)
	tabNomPrenom = []

	# ON ENLEVE LE MONSIEUR/MADAME DU NOM
	tabDepute.each {
		|nom|
		if nom[0,3] == "M. "
			nom[0,3] = ""
		else
			nom[0,4] = ""
		end
	}

	# ON SPLIT PUIS ON MET LE NOM/PRENOM DANS UN TABLEAU QU'ON AJOUT AU TABLEAU tabNomPrenom
	tabDepute.each{
		|name|
		tabNomPrenom << [name.split[0], name.split[1]]
	}
	return tabNomPrenom
end

# RENVOIE UN TABLEAU DES LIENS URL DES DEPUTES
def lienDeputes(urlAnnuaire)
	tabDeputeUrl = []
	doc = Nokogiri::HTML(open(urlAnnuaire))
	links = doc.css("div.clearfix ul a")

	links.each{
		|link|
		tabDeputeUrl << "http://www2.assemblee-nationale.fr#{link['href']}"
	}
	return tabDeputeUrl
end

# RENVOIE UN SEUL MAIL SELON L'URL ENVOYER
def mailDepute(urlDuDepute)
	doc = Nokogiri::HTML(open(urlDuDepute))
	mail = doc.css("a.email")
	mail.each do |i|
		mail = i['href']
	end
	mail = mail[7,mail.length]

	puts mail
	return mail
end

def startRAPIDE
	tabMailDepute = []
	monHash = {}
	tabLienDepute = lienDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	10.times do |i|
		print "#{i+1}/10 : "
		tabMailDepute << mailDepute(tabLienDepute[i])
	end
	tabNomPrenom1 = nomDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	tabNomPrenom2 = nomPrenom(tabNomPrenom1)
	10.times do |i|
		monHash[tabNomPrenom2[i]] = tabMailDepute[i]
	end
	puts monHash
end


# LET'S GO?
def start
	# tabLienDepute = []
	# tabNomPrenom = []
	tabMailDepute = []
	monHash = {}
	puts "Il y a environ 576 députés dont il faut charger les informations [soyez patient ;)]"

	tabLienDepute = lienDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	# tabLienDepute.each do |link|
	tabLienDepute.length.times do |i|
		print "#{i+1}/#{tabLienDepute.length} : "
		tabMailDepute << mailDepute(tabLienDepute[i])
	end

	tabNomPrenom1 = nomDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	tabNomPrenom2 = nomPrenom(tabNomPrenom1)
	# print tabNomPrenom2, "\n"

	# ON MET TOUTES SES INFOS DANS UN HASH

	tabLienDepute.each do |mail|
		# puts tabMailDepute[i]
		monHash[tabNomPrenom2[i]] = mail
	end

	puts monHash
end


# start
# rvm use ruby-2.5.1

# SI LE GROS TEST RATE A CAUSE DU TEMPS MIS A CHARGER LES INFOS
# DECOMMENTER LA LIGNE SUIVANTE POUR TESTER SUR 10 DEPUTES
startRAPIDE




