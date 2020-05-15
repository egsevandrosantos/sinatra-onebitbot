configure :test do
    set :database, {
        adapter: 'postgresql',
        encoding: 'utf8',
        database: 'onebitbot_test',
        pool: 5,
        username: 'postgres',
        password: 'postgres',
        host: 'db'
    }
end

configure :development do
    set :database, {
        adapter: 'postgresql',
        encoding: 'utf8',
        database: 'onebitbot_development',
        pool: 5,
        username: 'postgres',
        password: 'postgres',
        host: 'db'
    }
end

configure :production do
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///postgres/onebitbot_production')

    set :database, {
        adapter: 'postgresql',
        encoding: 'utf8',
        database: db.path[1..-1],
        username: db.user,
        password: db.password,
        host: db.host
    }
end