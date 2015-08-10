# Rails Patterns & AntiPatterns

I just want to build software like a pro.

![Suspenders](suspenders.png)

### Topics

* [Law of Demeter](#law-of-demeter)
* [ActiveRecord](#activerecord)
* [Presenters](#presenters)
* [Single Responsibility Principle](#single-responsibility-principle)
* [Null Object Pattern](#null-object-pattern)
* [Factory](#factory)
* [Facade](#facade)
* [Fat Models, Skinny Controllers](#fat-models-skinny-controllers)
* [CodeRetreat](#coderetreat)

--

### Law of Demeter

The Law of Demeter (LoD) or principle of least knowledge is a design guideline for developing software, particularly object-oriented programs. In its general form, the LoD is a specific case of loose coupling. The guideline was proposed at Northeastern University towards the end of 1987, and can be succinctly summarized in each of the following ways:[1]

* Each unit should have only limited knowledge about other units: only units "closely" related to the current unit.
* Each unit should only talk to its friends; don't talk to strangers.
* Only talk to your immediate friends.

The fundamental notion is that a given object should assume as little as possible about the structure or properties of anything else (including its subcomponents), in accordance with the principle of "information hiding".

#### Problem

```ruby
class Article < ActiveRecord::Base
	belongs_to :author
end

class Author < ActiveRecord::Base
	has_many :articles
	has_one :personal_information
end

class PersonalInformation < ActiveRecord::Base
	belongs_to :author
end

=> article.author.personal_information.name
=> article.author.personal_information.birthdate
=> article.author.personal_information.gender
=> article.author.personal_information.city
=> article.author.personal_information.last_name
```

#### Solution

```ruby
class Author < ActiveRecord::Base
	has_many :articles
	has_one :personal_information
	
	def name
		personal_information.name
	end
	
	def birthdate
		personal_information.birthdate
	end
	
	def gender
		personal_information.gender
	end
	
	def city
		personal_information.city
	end
	
	def last_name
		personal_information.last_name
	end
end

class Article < ActiveRecord::Base
	belongs_to :author
	
	def author_name
		personal_information.name
	end
	
	def author_birthdate
		personal_information.birthdate
	end
	
	def author_gender
		personal_information.gender
	end
	
	def author_city
		personal_information.city
	end
	
	def author_last_name
		personal_information.last_name
	end
end
```

#### +2 Solution

```ruby
class Author < ActiveRecord::Base
	has_many :articles
	has_one :personal_information
	
	delegate  :name,
	          :birthdate,
	          :gender,
	          :city,
	          :last_name,
	          to: :personal_information
end

class Article < ActiveRecord::Base
	belongs_to :author
	
	delegate  :name,
	          :birthdate,
	          :gender,
	          :city,
	          :last_name,
	          to: :author,
	          prefix: true

end
```

### ActiveRecord

In software engineering, the active record pattern is an architectural pattern found in software that stores in-memory object data in relational databases. It was named by Martin Fowler in his 2003 book Patterns of Enterprise Application Architecture.[1] The interface of an object conforming to this pattern would include functions such as Insert, Update, and Delete, plus properties that correspond more or less directly to the columns in the underlying database table.

The active record pattern is an approach to accessing data in a database. A database table or view is wrapped into a class. Thus, an object instance is tied to a single row in the table. After creation of an object, a new row is added to the table upon save. Any object loaded gets its information from the database. When an object is updated the corresponding row in the table is also updated. The wrapper class implements accessor methods or properties for each column in the table or view.

#### Example

```ruby
class User < ActiveRecord::Base
end
```

[Code](active_record)

### Presenters
Coming soon...

### Single Responsibility Principle
Coming soon...

### Null Object Pattern
Coming soon...

### Factory
Coming soon...

### Facade
Coming soon...

### Fat Models, Skinny Controllers
Coming soon...

### CodeRetreat
Coming soon...