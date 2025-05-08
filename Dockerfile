FROM ruby:3.4.3


ENV GEM_HOME="/usr/local/bundle"
ENV PATH="$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH"


RUN gem install bundler -v '< 2'


COPY entrypoint.sh /


ENTRYPOINT ["bash"]
CMD ["/entrypoint.sh"]
