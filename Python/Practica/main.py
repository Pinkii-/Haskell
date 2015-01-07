#!/usr/bin/python

import sys
import urllib2
import xml.etree.ElementTree as ET
import unicodedata
import csv

"""utils"""

class UrlProcessor(object):
	def __init__(self, url):
		self.url = url
		f = urllib2.urlopen(self.url)
		self.xml = f.read()
		f.close()

class CsvProcessor(object):
	def __init__(self, myCsv):
		self.csv = myCsv
		self.content = csv.DictReader(open(self.csv), delimiter = ';')
		for row in self.content:
			self.header = []
			for aux in row:
				self.header.append(aux)
			break		

def removeAccents(s):
	uS = unicode(s)
	return unicodedata.normalize('NFKD', uS).encode('ascii', 'ignore')

def mNormalize(s):
	s = removeAccents(s)
	return s.lower().strip()

"""Events"""

class Event(object):
	def printEvent(self):
		print 'Acte', self.nom
		print '   direccio', self.carrer, self.numero, self.districte, self.codi_postal, self.municipi
		print '   geolocalizazion', self.lat, self.lon
		print '   data', self.data
		print '   interesos', self.intereses
		
def getEvents():
	url = 'http://w10.bcn.es/APPS/asiasiacache/peticioXmlAsia?id=199'
	xmlGetter = UrlProcessor(url)
	root = ET.fromstring(xmlGetter.xml)
	events = []
	for event in root.iter('acte'):
		e = Event()
		for ele in event:
			if (ele.tag == 'id' or ele.tag == 'nom'):
				e.__setattr__(ele.tag, ele.text)

			elif (ele.tag == 'lloc_simple'):
				for dirr in ele:
					if (dirr.tag == 'adreca_simple'):
						for direc in dirr:
							if (direc.tag == 'carrer' or direc.tag == 'numero' or direc.tag == 'districte' or 
								direc.tag == 'codi_postal' or direc.tag == 'municipi' or direc.tag == 'barri'):
								e.__setattr__(direc.tag, direc.text)
							elif (direc.tag == 'coordenades'):
								e.__setattr__('lat',direc.find('googleMaps').get('lat'))
								e.__setattr__('lon',direc.find('googleMaps').get('lon'))
			elif (ele.tag == 'data'):
				e.__setattr__('data',ele.find('data_proper_acte').text)
			elif (ele.tag == 'classificacions'):
				e.__setattr__('intereses', [])
				for interes in ele:
					e.intereses.append(interes.text)
		events.append(e)
	return events

def getGoodEvents():
	events = getEvents()
	entrada = sys.argv[1]
	entrada = mNormalize(entrada)
	restriccions = entrada.split(",")
	goodEvents = []
	import unicodedata
	for event in events:
		toAdd = True
		for res in restriccions:
			r = res.split(":")
			if (r[0] == 'nom'):
				toAdd = toAdd & (r[1] in mNormalize(event.nom))
			elif (r[0] == 'barri'):
				toAdd = toAdd & (r[1] in mNormalize(event.barri))
			elif (r[0] == 'lloc'): 
				"""Que quiere decir lloc?"""
				toAdd = toAdd & True
			else:
				toAdd = False
		if toAdd:
			goodEvents.append(event)
	return goodEvents

"""Meteosat"""

def getMeteo():
	url = 'http://static-m.meteo.cat/content/opendata/ctermini_comarcal.xml'
	xmlGetter = UrlProcessor(url)
	root = ET.fromstring(xmlGetter.xml)
	weather = []
	for comarca in root.iter('comarca'):
		capital = comarca.get('nomCAPITALCO')
		if capital == 'Barcelona':
			comarcaId = comarca.get('id')
			# print 'Barcelona encontrada con la id', comarcaId
	for prediccion in root.iter('prediccio'):
		idPrediccio = prediccion.get('idcomarca')
		if idPrediccio == comarcaId:
			# print 'prediccion encontrada'
			fPredic = {}
			for dia in prediccion:
				data = dia.get('data').replace('-','/')
				weather.append((data,dia.get('probcalamati'),dia.get('probcalatarda')))
	return weather

"""Bus"""

class Bus(object):
	def printBus(self):
		print "Bus", self.EQUIPAMENT

def loadBus():
	csv = 'Documents/ESTACIONS_BUS.csv'
	buses = CsvProcessor(csv)
	first = True
	paradaBuses = []
	for row in buses.content:
		if first:
			first = False
		else:
			b = Bus()
			for header in buses.header:
				b.__setattr__(header,row[header])
			paradaBuses.append(b)
	return paradaBuses

"""Metro"""

class Metro(object):
	def printMetro(self):
		print "Metro", self.EQUIPAMENT

def loadMetro():
	csv = 'Documents/TRANSPORTS.csv'
	metro = CsvProcessor(csv)
	first = True
	paradaMetro = []
	for row in metro.content:
		if first:
			first = False
		else:
			m = Metro()
			for header in metro.header:
				m.__setattr__(header,row[header])
			paradaMetro.append(m)
	return paradaMetro

"""Bicing"""

class Bicing(object):
	def printBicing(self):
		print 'Bicing', self.lat, self.long

def loadBicing():
	url = 'http://wservice.viabicing.cat/v1/getstations.php?v=1'
	xmlGetter = UrlProcessor(url)
	root = ET.fromstring(xmlGetter.xml)
	bicing = []
	for station in root.iter('station'):
		b = Bicing()
		for bic in station:
			if (bic.tag == 'lat' or bic.tag == 'long' or bic.tag == 'status' or 
				bic.tag == 'slots' or bic.tag == 'bikes' or bic.tag == 'street'):
				b.__setattr__(bic.tag,bic.text)
		bicing.append(b)
	return bicing

"""Web"""

def drawWeb(events, weathers, buses, metros, bicings):
	with open('index.html','w') as html:
		html.write('<html><body><table>')
		for event in events:
			html.write('<tr><td><b>'+event.nom+'</b><br> ('+
				event.carrer+' '+event.numero+' '+event.districte+' '+event.codi_postal+' '+event.municipi)


			dayAndHour = event.data.split(' ')
			someWeather = None
			for weather in weathers:
				if dayAndHour[0] == weather[0]:
					someWeather = weather
			print someWeather, dayAndHour[0], event.nom


"""Main"""

def main():
	eventosElegidos = getGoodEvents()
	isRainingMen = getMeteo()
	bus = loadBus()
	metro = loadMetro()
	bicing =  loadBicing()
	drawWeb(eventosElegidos, isRainingMen,bus,metro,bicing)


if __name__ == '__main__':
	main()


		