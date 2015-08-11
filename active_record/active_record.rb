require "pg"
require "singleton"
require "pry"
require "ostruct"
require "active_support/inflector"

class Connection
  include Singleton

  def connection
    @connection ||= PG::Connection.open(dbname: "hsnews_development")
  end
end

class ActiveRecord < OpenStruct

  def self.connection
    Connection.instance.connection
  end

  def self.table_name
    self.name.downcase.pluralize
  end

  def self.all
    result = self.connection.exec("SELECT * FROM #{self.table_name}")

    result.map {|tuple| self.new(tuple) }
  end

  def self.find(id)
    instance = nil
    result = self.connection.exec("SELECT * FROM #{self.table_name}
                                   WHERE id = #{id} limit 1")

    result.each do |tuple|
      instance = self.new(tuple)
    end

    raise "Not Record Found" if instance.nil?

    instance
  end

  #INSERT INTO users(
            #name, email, id)
    #VALUES ('Abraham kuri', 'kurenn@icalialans.com', 1);
  def save
    sql_column_names = self.to_h.keys.join(", ")
    values = self.to_h.values.map {|value| "'#{value}'"}.join(', ')
    #=> ['Abraham', 'kurenn...']
    
    self.class.connection.exec("INSERT INTO #{self.class.table_name} (
                               #{sql_column_names})
                               VALUES (#{values})")
    self
  end

  def update(attr = {})

    sql_update = attr.map {|k, v| "#{k} = '#{v}'" }.join(", ")

    self.class.connection.exec("UPDATE #{self.class.table_name}
                                SET #{sql_update}
                                WHERE id = #{self.id}")
    self.class.find(self.id)
  end

  def destroy
    self.class.connection.exec("DELETE FROM #{self.class.table_name}
                                WHERE id = #{self.id}")
    nil
  end

  def self.create(attrs = {})
    instance = self.new(attrs)
    instance.save
  end

  def self.where(conditions = {})
    sql_where = conditions.map {|k, v| "#{k} = '#{v}'" }.join(" AND ")

    result = self.connection.exec("SELECT * FROM #{self.table_name}
                          WHERE #{sql_where}")

    result.map { |tuple| self.new(tuple) }
  end

  def self.has_many(*args)
    association_class = args[0].to_s.classify #=> "Link"
    association_method_name = args[0]
    foreign_key = "#{self.name.downcase}_id"

    define_method association_method_name do
      association_class.constantize.where(foreign_key => self.id)
    end
  end

  def self.belongs_to(*args)
    association_model = args[0].to_s
    association_method_name = args[0]

    define_method association_method_name do |model=""|
      instance_variable_set("@#{association_model}", association_model.classify.constantize.find(self.user_id)) if instance_variable_get("@#{association_model}").nil?
      instance_variable_get("@#{association_model}")
    end

    define_method "#{association_method_name}=" do |model|
      instance_variable_set("@#{association_model}", model)
    end
  end

end

class User < ActiveRecord
  has_many :links
end

class Link < ActiveRecord
  belongs_to :user
end

binding.pry

User.all
# => [#<User name: "">, #<User name: "">]

puts "Hola"


