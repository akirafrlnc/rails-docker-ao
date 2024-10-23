FROM ruby:3.3.4

ENV RAILS_ENV=production

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
	&& apt-get update -q \
	&& apt-get install -y nodejs yarn

WORKDIR /app

COPY ./src /app

RUN bundle config --local set path 'vendor/bundle' \
	&& bundle install

COPY start.sh /start.sh

RUN chmod 744 /start.sh
CMD ["sh", "/start.sh"]

# FROM ruby:3.3.4

# WORKDIR /var/www

# COPY ./src /var/www

# RUN bundle config --local set path 'vendor/bundle' \
# 	&& bundle install

# CMD ["bundle", "exec", "ruby", "app.rb"]

# RUN mkdir /var/www

# RUN gem install webrick

# COPY main.rb /var/www

# CMD ["ruby", "/var/www/main.rb"]
