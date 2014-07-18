#Program to parse gre words from wordlists found in http://www.majortests.com

require 'open-uri'
require 'nokogiri'


class WebParser
   def initialize (page)
     @page = page
     @wordarray=[]
     @meaningarray=[]
   end

   def parse_tables  
     (1..15).each do |pageno| #there are 15 wordlist pages
       page = Nokogiri::HTML(open("#{@page}/wordlist_#{pageno > 9 ? pageno : "0#{pageno}"} ")) #open page 01-15
       page.xpath('//table/tr/th').each {|i| @wordarray<<i.inner_html} #parsing th for words
       page.xpath('//table/tr/td').each {|i| @meaningarray<<i.inner_html} #td for meanings
     end
   end
   def print_table
     puts "word \t  meaning"
     @wordarray.zip @meaningarray.each do |word, meaning| # zipping 2 arrays
       puts word + "\t: "+ meaning
     end
   end
end
parser = WebParser.new("http://www.majortests.com/gre/")
parser.parse_tables
parser.print_table

