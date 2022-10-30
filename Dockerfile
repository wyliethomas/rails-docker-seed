FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /[YOUR PROJECT]
WORKDIR /[YOUR PROJECT]
COPY Gemfile /[YOUR PROJECT]/Gemfile
COPY Gemfile.lock /[YOUR PROJECT]/Gemfile.lock
ENV GEM_HOME="/usr/local/bundle"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
RUN gem install bundler:2.3.14
#RUN bundle update nokogiri marcel mimemagic
RUN bundle install
COPY . /[YOUR PROJECT]
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.      
CMD ["rails", "server", "-b", "0.0.0.0"]
