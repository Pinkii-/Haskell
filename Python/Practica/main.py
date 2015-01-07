#!/usr/bin/python

import sys
import urllib2
import xml.etree.ElementTree as ET
import unicodedata

class UrlProcessor(object):
	def __init__(self, url):
		self.url = url
		f = urllib2.urlopen(self.url)
		self.xml = f.read()
		f.close()

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

def removeAccents(s):
	uS = unicode(s)
	return unicodedata.normalize('NFKD', uS).encode('ascii', 'ignore')

def mNormalize(s):
	s = removeAccents(s)
	return s.lower().strip()

def getGoodEvents():
	events = getEvents()
	entrada = sys.argv[1]
	entrada = entrada.lower().strip()
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

def main():
	eventosElegidos = getGoodEvents()
	for e in eventosElegidos:
		e.printEvent()


if __name__ == '__main__':
	main()


		