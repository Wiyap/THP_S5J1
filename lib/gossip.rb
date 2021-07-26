require 'csv'

class Gossip
  attr_accessor :content, :author, :all_gossip
  @@all_gossip = []

  def initialize (author,content)
    @author = author
    @content = content
  end

  def save
    id_count = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      id_count << csv_line
    end

    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [id_count.length+1,self.author, self.content]
    end
  end

  def self.all
    CSV.read("./db/gossip.csv").each do |csv_line|
      @@all_gossip << [csv_line[0],Gossip.new(csv_line[1], csv_line[2])]
    end
    return @@all_gossip
  end

  def self.find(id)
    gossip_array = Gossip.all
    return gossip_array[id][1]
  end

  def self.edit(id,edit)
    gossip_array= []
    CSV.read("./db/gossip.csv").each do |csv|
      gossip_array << csv
    end
    
    gossip_array[id][2] = edit

    CSV.open("./db/gossip.csv", "w") do |csv|
      gossip_array.each do |gossip|
        csv << gossip
      end
    end
  end

end
