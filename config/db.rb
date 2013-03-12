db = URI.parse(ENV['DATABASE_URL'] || 'postgres://postgres:@localhost/rmcontacts')

ActiveRecord::Base.establish_connection(
    :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :port     => db.port,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
)

#ActiveRecord::Base.establish_connection(
#
#  :adapter => 'postgresql',
#  :encoding => 'unicode',
#  :database => 'rmcontacts',
#  :host => 'localhost',
#  :username => 'postgres',
#  :password => ''
#
#)
