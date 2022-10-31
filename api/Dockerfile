FROM elixir:latest

# Make sure we have sudo
RUN apt-get update && apt-get -y install sudo
# Create an app directory to store our files in
ADD . /app

# Install the Phoenix archive
RUN mix local.hex --force && mix local.rebar --force && mix archive.install --force hex phx_new

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - && sudo apt-get install -y nodejs

# Set working directory as app
WORKDIR /app

# CD to assests folder and npm i node modules
RUN npm install --prefix ./assets

# Back to root folder
RUN cd ..
# Install Elxir deps
RUN mix deps.get
# Compile files
RUN mix compile
# Expose port 4000
EXPOSE 4000

COPY ["mix.exs", "mix.lock"] ./app/

# Execute commands mentioned under scripy.sh file
CMD ["./api/script.sh"]