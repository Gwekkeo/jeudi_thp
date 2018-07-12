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

# LET'S GO?
def start
	# tabLienDepute = []
	# tabNomPrenom = []
	tabMailDepute = []
	monHash = {}

	tabLienDepute = lienDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	tabLienDepute.each do |link|
		tabMailDepute = mailDepute(link)
		# tabMailDepute = ["Lea","Leo","Lola","Lilou","Lili","Lyndsay","Linda","Lisa"]
	end
	puts tabMailDepute.length

	tabNomPrenom1 = nomDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
	tabNomPrenom2 = nomPrenom(tabNomPrenom1)
	# print tabNomPrenom2, "\n"

	# ON MET TOUTES SES INFOS DANS UN HASH

	20.times do |i|
		monHash[tabNomPrenom2[i]]=tabMailDepute[i]
	end

	puts monHash


end


start


# puts lienDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
# namesCollee = nomDeputes("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique")
# print tabNomDep = nomPrenom(namesCollee), "\n"
# puts mailDepute("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA718768")






# rvm use ruby-2.5.1
