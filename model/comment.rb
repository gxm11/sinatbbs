require "sequel"

db = Sequel.connect("sqlite://comments.db")

unless db.table_exists?(:comments)
  db.create_table(:comments) do
    primary_key :id
    string :name
    string :title
    text :message
    timestamp :posted_date
  end
end

Sequel::Model.db = db

class Comments < Sequel::Model
  def date
    self.posted_date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def formatted_message
    Rack::Utils.escape_html(self.message).gsub(/\n/, "<br>")
  end
end
