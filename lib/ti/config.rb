require 'nokogiri'

module Ti
  class Config
    attr_accessor :id, :name, :version, :publisher, :url, :description, :copyright

    def parse(filename)
      xml  = File.open(filename)
      doc    = Nokogiri::XML(xml)
      xml.close
      # parse into properties
      @id = doc.xpath('ti:app/id').text
      @name = doc.xpath('ti:app/name').text
      @version = doc.xpath('ti:app/version').text
      @publisher = doc.xpath('ti:app/publisher').text
      @url = doc.xpath('ti:app/url').text
      @description = doc.xpath('ti:app/description').text
      @copyright = doc.xpath('ti:app/copyright').text
    end

  end
end