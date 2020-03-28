require 'httparty'

module DonDuSang
  class Events
    URL = "http://api.openeventdatabase.org/event/?what=health.blood.collect&when=nextweek&limit=1000"

    def initialize
      @events = HTTParty.get(URL)
    end

    def write_csv(filename)
      CSV.open(filename, "wb") do |csv|
        csv << headers
        @events["features"].each do |event|
          csv << event["properties"].values_at(*headers)
        end
      end
    end


    private
    def headers
      ["name", "where:name", "start", "stop", "lat","lon"]
    end
  end
end

DonDuSang::Events.new.write_csv("don-du-sang.csv")
