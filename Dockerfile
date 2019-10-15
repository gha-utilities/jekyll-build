LABEL "name"="GHA Jekyll Build Container"
LABEL "version"="0.0.1"
LABEL maintainer="S0AndS0"
LABEL repository="https://github.com/gha-utilities/jekyll-build"
# LABEL homepage=""
LABEL "com.github.actions.name"="GHA Jekyll Build"
LABEL "com.github.actions.description"="Action for running Bundle Install and Jekyll Build within a Docker container"
LABEL "com.github.actions.icon"="book"
LABEL "com.github.actions.color"="black"


FROM ruby:2.5


# RUN apt-get install build-essential ruby-full


ENV GEM_HOME="/usr/local/bundle"
ENV PATH="$GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH"


RUN gem install bundler -v '< 2'


COPY entrypoint.sh /


ENTRYPOINT ["bash"]
CMD ["/entrypoint.sh"]
