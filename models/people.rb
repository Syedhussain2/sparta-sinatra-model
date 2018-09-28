class People
  attr_accessor :id, :first_name, :last_name, :gender

  def self.open_connection
    conn = PG.connect( dbname: 'people')
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM people ORDER BY id"
    results = conn.exec(sql)

    people = results.map do |people|
      self.hydrate people

  end
  people
end

def save
  conn =  People.open_connection
  if !self.id
    sql = "INSERT INTO people (first_name,last_name,gender) VALUES ('#{self.first_name}', '#{self.last_name}', '#{self.gender}')"
  else
    sql = "UPDATE people SET first_name='#{self.first_name}',last_name='#{self.last_name}',gender='#{self.gender}' WHERE id=#{self.id} "
  end

  conn.exec(sql)
end


def self.find id

  conn = self.open_connection
  sql = "SELECT * FROM people WHERE id=#{id} ORDER BY id"
  results = conn.exec(sql)
  people = self.hydrate results[0]
end

def self.destroy id

  conn = self.open_connection
  sql = "DELETE FROM people WHERE id=#{id}"
  conn.exec(sql)

end

def self.hydrate people_data
  people = People.new

  people.id = people_data['id']
  people.first_name = people_data['first_name']
  people.last_name = people_data['last_name']
  people.gender = people_data['gender']

  people
end

end # class end
