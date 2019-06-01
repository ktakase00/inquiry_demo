cp -p config/master.key.dev config/master.key
bundle install --path=vendor/bundler
yarn install
bundle exec rails db:migrate
bundle exec rails db:seed
