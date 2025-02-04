# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class AnbientItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
	title = scrapy.Field()
	url = scrapy.Field()
	episodes = scrapy.Field()
	year = scrapy.Field()
	genres = scrapy.Field()
	imgUrl = scrapy.Field()
	synopsis = scrapy.Field()
	myAnimeListUrl = scrapy.Field()
	category = scrapy.Field()
	relatedItems = scrapy.Field()
	error = scrapy.Field()