db = URI.parse(ENV['DATABASE_URL'] || 'postgres://postgres:@localhost/rmcontacts')

#postgres://faflqpdqyzddzj:Ci07LknUCuWQitFJtMGi672BVo@ec2-23-21-170-190.compute-1.amazonaws.com:5432/da8r7u9ks8r4el

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
