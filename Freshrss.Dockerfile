FROM freshrss/freshrss:edge

RUN apt update -y && \
    apt install -y git

# ------------------
# --- Extensions ---
# ------------------
# Note: The commit checkout process is just for reproducibility, so it can be removed

WORKDIR /var/www/FreshRSS/extensions

# Install togglable menu extension
RUN git clone --branch main https://framagit.org/nicofrand/xextension-togglablemenu.git ./togglable-menu && \
    cd ./togglable-menu && \
    git checkout 008755ca2912ac919a6abc58ad84fc73c6f60769

# Install autorefresh extension
RUN git clone --branch master https://github.com/Eisa01/FreshRSS---Auto-Refresh-Extension.git ./auto-refresh && \
    cd ./auto-refresh && \
    git checkout 4f9add4567b595b2a7bdff432b0b6b8ff6912d5e && \
    mv ./xExtension-AutoRefresh ../

# Install official Freshrss extensions
RUN git clone --branch master https://github.com/FreshRSS/Extensions.git ./official-extensions && \
    cd official-extensions && \
    git checkout 8cebb26c3d3bce7c629cf86d08e665ef9623d22a && \
    mv ./xExtension-* ../

# Give permissions to www-data
RUN chown www-data:www-data -R /var/www/FreshRSS/extensions
RUN chmod g+rx /var/www/FreshRSS/extensions

WORKDIR /var/www/FreshRSS